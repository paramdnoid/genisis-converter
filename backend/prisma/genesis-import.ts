import "dotenv/config";

import { Prisma, PrismaClient } from "@prisma/client";

import {
  CanonicalCustomerDraft,
  CanonicalInstallationDraft,
  CanonicalObjectDraft,
  CanonicalObjectTariffAssignmentDraft,
  CanonicalTariffCatalogDraft,
  CanonicalUserDraft,
  GenesisImportPlan,
  LegacyRecordDraft,
  inspectGenesisArchive,
} from "../src/import/genesis-importer";

const prisma = new PrismaClient();

interface CliOptions {
  command: "inspect" | "import";
  archivePath: string;
  tenantId?: string;
  dryRun: boolean;
}

async function main() {
  const options = parseArgs(process.argv.slice(2));
  const plan = await inspectGenesisArchive(options.archivePath);

  if (options.command === "inspect" || options.dryRun) {
    printPlan(plan, options);
    return;
  }

  if (!options.tenantId) {
    throw new Error("--tenant-id is required for a real Genesis import.");
  }

  await runGenesisImport(plan, options.tenantId);
  printPlan(plan, options);
}

export async function runGenesisImport(
  plan: GenesisImportPlan,
  tenantId: string,
) {
  const tenant = await prisma.tenant.findUnique({ where: { id: tenantId } });
  if (!tenant) {
    throw new Error(`Tenant ${tenantId} does not exist.`);
  }

  const existingBatch = await prisma.legacyImportBatch.findFirst({
    where: {
      tenantId,
      sourceSystem: "genesis",
      archiveSha256: plan.archiveSha256,
    },
    orderBy: { createdAt: "desc" },
  });
  const batch = existingBatch
    ? await prisma.legacyImportBatch.update({
        where: { id: existingBatch.id },
        data: {
          archivePath: plan.archivePath,
          status: "running",
          completedAt: null,
          counts: plan.counts as Prisma.InputJsonValue,
          warnings: plan.warnings as Prisma.InputJsonValue,
          summary: plan.summary as Prisma.InputJsonValue,
        },
      })
    : await prisma.legacyImportBatch.create({
        data: {
          tenantId,
          sourceSystem: "genesis",
          archivePath: plan.archivePath,
          archiveSha256: plan.archiveSha256,
          status: "running",
          counts: plan.counts as Prisma.InputJsonValue,
          warnings: plan.warnings as Prisma.InputJsonValue,
          summary: plan.summary as Prisma.InputJsonValue,
        },
      });

  try {
    await prisma.legacyImportRecord.deleteMany({
      where: { batchId: batch.id },
    });

    for (const user of plan.users) {
      await upsertUser(tenantId, user);
    }
    for (const customer of plan.customers) {
      await upsertCustomer(tenantId, customer);
    }
    for (const object of plan.objects) {
      await upsertObject(tenantId, object);
    }
    for (const installation of plan.installations) {
      await upsertInstallation(tenantId, installation);
    }
    for (const tariff of plan.tariffCatalogItems) {
      await upsertTariffCatalogItem(tenantId, tariff);
    }
    for (const assignment of plan.objectTariffAssignments) {
      await upsertObjectTariffAssignment(tenantId, assignment);
    }

    await createLegacyRecords(tenantId, batch.id, plan.legacyRecords);

    await prisma.legacyImportBatch.update({
      where: { id: batch.id },
      data: {
        status: "completed",
        completedAt: new Date(),
        counts: plan.counts as Prisma.InputJsonValue,
        warnings: plan.warnings as Prisma.InputJsonValue,
        summary: plan.summary as Prisma.InputJsonValue,
      },
    });
  } catch (error) {
    await prisma.legacyImportBatch.update({
      where: { id: batch.id },
      data: {
        status: "failed",
        completedAt: new Date(),
        warnings: [
          ...plan.warnings,
          error instanceof Error ? error.message : String(error),
        ] as Prisma.InputJsonValue,
      },
    });
    throw error;
  }
}

async function upsertUser(tenantId: string, user: CanonicalUserDraft) {
  const { id, ...write } = user;
  await prisma.user.upsert({
    where: {
      tenantId_sourceSystem_sourceKey: {
        tenantId,
        sourceSystem: user.sourceSystem,
        sourceKey: user.sourceKey,
      },
    },
    create: {
      id,
      tenantId,
      ...write,
    },
    update: {
      ...write,
    },
  });
}

async function upsertCustomer(
  tenantId: string,
  customer: CanonicalCustomerDraft,
) {
  const { id, ...write } = customer;
  await prisma.customer.upsert({
    where: {
      tenantId_sourceSystem_sourceKey: {
        tenantId,
        sourceSystem: customer.sourceSystem,
        sourceKey: customer.sourceKey,
      },
    },
    create: {
      id,
      tenantId,
      ...write,
    },
    update: {
      ...write,
    },
  });
}

async function upsertObject(tenantId: string, object: CanonicalObjectDraft) {
  const { id, ...write } = object;
  await prisma.customerObject.upsert({
    where: {
      tenantId_sourceSystem_sourceKey: {
        tenantId,
        sourceSystem: object.sourceSystem,
        sourceKey: object.sourceKey,
      },
    },
    create: {
      id,
      tenantId,
      ...write,
    },
    update: {
      ...write,
    },
  });
}

async function upsertInstallation(
  tenantId: string,
  installation: CanonicalInstallationDraft,
) {
  const { id, ...write } = installation;
  await prisma.installation.upsert({
    where: {
      tenantId_sourceSystem_sourceKey: {
        tenantId,
        sourceSystem: installation.sourceSystem,
        sourceKey: installation.sourceKey,
      },
    },
    create: {
      id,
      tenantId,
      ...write,
    },
    update: {
      ...write,
    },
  });
}

async function upsertTariffCatalogItem(
  tenantId: string,
  tariff: CanonicalTariffCatalogDraft,
) {
  const { id, ...write } = tariff;
  await prisma.tariffCatalogItem.upsert({
    where: {
      tenantId_sourceSystem_sourceKey: {
        tenantId,
        sourceSystem: tariff.sourceSystem,
        sourceKey: tariff.sourceKey,
      },
    },
    create: {
      id,
      tenantId,
      ...write,
    },
    update: {
      ...write,
    },
  });
}

async function upsertObjectTariffAssignment(
  tenantId: string,
  assignment: CanonicalObjectTariffAssignmentDraft,
) {
  const { id, ...write } = assignment;
  await prisma.objectTariffAssignment.upsert({
    where: {
      tenantId_sourceSystem_sourceKey: {
        tenantId,
        sourceSystem: assignment.sourceSystem,
        sourceKey: assignment.sourceKey,
      },
    },
    create: {
      id,
      tenantId,
      ...write,
    },
    update: {
      ...write,
    },
  });
}

async function createLegacyRecords(
  tenantId: string,
  batchId: string,
  records: LegacyRecordDraft[],
) {
  for (const chunk of chunks(records, 1000)) {
    await prisma.legacyImportRecord.createMany({
      data: chunk.map((record) => ({
        tenantId,
        batchId,
        sourceSystem: "genesis",
        sourceFile: record.sourceFile,
        sourceTable: record.sourceTable,
        sourceKey: record.sourceKey,
        rowHash: record.rowHash,
        rowIndex: record.rowIndex,
        recordType: record.recordType,
        mappedEntityType: record.mappedEntityType,
        mappedEntityId: record.mappedEntityId,
        payload: record.payload as Prisma.InputJsonValue,
      })),
      skipDuplicates: true,
    });
  }
}

function chunks<T>(values: T[], size: number): T[][] {
  const output: T[][] = [];
  for (let index = 0; index < values.length; index += size) {
    output.push(values.slice(index, index + size));
  }
  return output;
}

function printPlan(plan: GenesisImportPlan, options: CliOptions) {
  console.log(
    JSON.stringify(
      {
        command: options.command,
        dryRun: options.dryRun,
        archivePath: plan.archivePath,
        archiveSha256: plan.archiveSha256,
        summary: plan.summary,
        requiredCounts: {
          "KFDSTAMM.GebStamm": plan.counts["KFDSTAMM.GebStamm"],
          "KFDSTAMM.Tarife": plan.counts["KFDSTAMM.Tarife"],
          "KFDSTAMM.GTarife": plan.counts["KFDSTAMM.GTarife"],
          "FKSTAMM.GebStamm": plan.counts["FKSTAMM.GebStamm"],
          "FKSTAMM.Tarife": plan.counts["FKSTAMM.Tarife"],
          "FKSTAMM.GTarife": plan.counts["FKSTAMM.GTarife"],
          "FKSTAMM.FestStoff": plan.counts["FKSTAMM.FestStoff"],
          "OPSTAMM.OP": plan.counts["OPSTAMM.OP"],
          "KFKRECH.RechZeilen": plan.counts["KFKRECH.RechZeilen"],
        },
        warnings: plan.warnings,
      },
      null,
      2,
    ),
  );
}

function parseArgs(args: string[]): CliOptions {
  const [commandRaw, archivePath, ...rest] = args;
  if (commandRaw !== "inspect" && commandRaw !== "import") {
    throw new Error(
      "Usage: ts-node prisma/genesis-import.ts <inspect|import> <archive.zip> [--tenant-id <id>] [--dry-run]",
    );
  }
  if (!archivePath) {
    throw new Error("Genesis ZIP path is required.");
  }

  let tenantId: string | undefined;
  let dryRun = false;
  for (let index = 0; index < rest.length; index += 1) {
    const value = rest[index];
    if (value === "--dry-run") {
      dryRun = true;
      continue;
    }
    if (value === "--tenant-id") {
      tenantId = rest[index + 1];
      index += 1;
      continue;
    }
    throw new Error(`Unknown Genesis import option: ${value}`);
  }

  return {
    command: commandRaw,
    archivePath,
    tenantId,
    dryRun,
  };
}

if (require.main === module) {
  main()
    .catch((error) => {
      console.error(error instanceof Error ? error.message : error);
      process.exitCode = 1;
    })
    .finally(async () => {
      await prisma.$disconnect();
    });
}

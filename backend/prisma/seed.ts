import "dotenv/config";

import { PrismaClient } from "@prisma/client";
import { hash } from "bcryptjs";

const prisma = new PrismaClient();

async function main() {
  const tenant = await prisma.tenant.upsert({
    where: { id: "00000000-0000-4000-8000-000000000001" },
    update: {},
    create: {
      id: "00000000-0000-4000-8000-000000000001",
      slug: "demo-kaminfeger",
      name: "Demo Kaminfeger Betrieb",
      plan: "starter",
      status: "active",
      address: "Hauptstrasse 1",
      postalCode: "8000",
      city: "Zuerich",
      country: "CH",
      phone: "+41 44 000 00 00",
      email: "demo@example.invalid",
    },
  });

  await prisma.user.upsert({
    where: {
      tenantId_email: {
        tenantId: tenant.id,
        email: "admin@example.invalid",
      },
    },
    update: {
      passwordHash: await hash("admin1234", 12),
      isActive: true,
    },
    create: {
      tenantId: tenant.id,
      firstName: "Demo",
      lastName: "Admin",
      email: "admin@example.invalid",
      role: "admin",
      passwordHash: await hash("admin1234", 12),
      isActive: true,
    },
  });

  await prisma.reportTemplate.upsert({
    where: {
      tenantId_name: {
        tenantId: tenant.id,
        name: "Standard Rapport",
      },
    },
    update: {
      isDefault: true,
      titlePrefix: "Rapport",
      primaryColor: "#1f2937",
      includeCustomer: true,
      includeInstallations: true,
      includeMeasurements: true,
      includeDefects: true,
      includeMaterials: true,
      includeTimeEntries: true,
      includePhotos: true,
      includeSignature: true,
    },
    create: {
      tenantId: tenant.id,
      name: "Standard Rapport",
      reportType: "work_order",
      titlePrefix: "Rapport",
      locale: "de",
      primaryColor: "#1f2937",
      footerText: "Demo Kaminfeger Betrieb",
      includeCustomer: true,
      includeInstallations: true,
      includeMeasurements: true,
      includeDefects: true,
      includeMaterials: true,
      includeTimeEntries: true,
      includePhotos: true,
      includeSignature: true,
      isDefault: true,
    },
  });
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (error) => {
    console.error(error);
    await prisma.$disconnect();
    process.exit(1);
  });

import { createHash } from "node:crypto";
import { readFile } from "node:fs/promises";
import * as path from "node:path";
import { Readable } from "node:stream";

import * as yauzl from "yauzl";

export const GENESIS_SOURCE_SYSTEM = "genesis";

export type GenesisRow = Record<string, unknown>;
export type JsonPayload =
  | string
  | number
  | boolean
  | null
  | JsonPayload[]
  | { [key: string]: JsonPayload };

export interface LegacyRecordDraft {
  sourceFile: string;
  sourceTable: string;
  sourceKey: string;
  rowHash: string;
  rowIndex?: number;
  recordType: "row" | "file";
  mappedEntityType?: string;
  mappedEntityId?: string;
  payload: JsonPayload;
}

export interface CanonicalUserDraft {
  id: string;
  firstName: string;
  lastName: string;
  email: string;
  phone?: string;
  role: string;
  passwordHash: string;
  isActive: boolean;
  sourceSystem: string;
  sourceFile: string;
  sourceTable: string;
  sourceKey: string;
}

export interface CanonicalCustomerDraft {
  id: string;
  type: string;
  displayName: string;
  firstName?: string;
  lastName?: string;
  companyName?: string;
  email?: string;
  phone?: string;
  mobile?: string;
  billingAddress?: string;
  notes?: string;
  sourceSystem: string;
  sourceFile: string;
  sourceTable: string;
  sourceKey: string;
}

export interface CanonicalObjectDraft {
  id: string;
  customerId: string;
  name: string;
  street: string;
  houseNumber: string;
  postalCode: string;
  city: string;
  country: string;
  accessNotes?: string;
  safetyNotes?: string;
  objectNotes?: string;
  sourceSystem: string;
  sourceFile: string;
  sourceTable: string;
  sourceKey: string;
}

export interface CanonicalInstallationDraft {
  id: string;
  objectId: string;
  type: string;
  manufacturer?: string;
  model?: string;
  serialNumber?: string;
  fuelType?: string;
  installationYear?: number;
  locationDescription?: string;
  intervalMonths?: number;
  notes?: string;
  sourceSystem: string;
  sourceFile: string;
  sourceTable: string;
  sourceKey: string;
}

export interface CanonicalTariffCatalogDraft {
  id: string;
  tariffSystem: string;
  code: string;
  description: string;
  defaultPrice?: number;
  taxCategory?: string;
  taxPoints?: number;
  isActive: boolean;
  sourceSystem: string;
  sourceFile: string;
  sourceTable: string;
  sourceKey: string;
}

export interface CanonicalObjectTariffAssignmentDraft {
  id: string;
  objectId?: string;
  tariffCatalogItemId?: string;
  tariffSystem: string;
  code?: string;
  description: string;
  position?: number;
  defaultQuantity?: number;
  unit?: string;
  priceOverride?: number;
  taxPoints?: number;
  billingCode?: string;
  intervalCode?: string;
  flag13?: string;
  flag14?: string;
  flag15?: string;
  notes?: string;
  isActive: boolean;
  sourceSystem: string;
  sourceFile: string;
  sourceTable: string;
  sourceKey: string;
}

export interface GenesisArchiveData {
  archivePath: string;
  archiveSha256: string;
  counts: Record<string, number>;
  warnings: string[];
  tables: GenesisTableData[];
  files: GenesisTextFileData[];
  legacyRecords: LegacyRecordDraft[];
}

export interface GenesisTableData {
  sourceFile: string;
  sourceName: string;
  sourceTable: string;
  rows: GenesisRow[];
}

export interface GenesisTextFileData {
  sourceFile: string;
  sourceName: string;
  text: string;
  byteLength: number;
  sha256: string;
}

export interface GenesisImportPlan {
  archivePath: string;
  archiveSha256: string;
  counts: Record<string, number>;
  warnings: string[];
  summary: {
    users: number;
    customers: number;
    objects: number;
    installations: number;
    tariffCatalogItems: number;
    objectTariffAssignments: number;
    legacyRecords: number;
    files: number;
    tables: number;
  };
  users: CanonicalUserDraft[];
  customers: CanonicalCustomerDraft[];
  objects: CanonicalObjectDraft[];
  installations: CanonicalInstallationDraft[];
  tariffCatalogItems: CanonicalTariffCatalogDraft[];
  objectTariffAssignments: CanonicalObjectTariffAssignmentDraft[];
  legacyRecords: LegacyRecordDraft[];
}

interface ZipEntryData {
  fileName: string;
  buffer: Buffer;
}

type MdbReaderConstructor = new (buffer: Buffer) => {
  getTableNames(): string[];
  getTable(name: string): { getData(): unknown[] };
};

interface PersonInfo {
  displayName?: string;
  firstName?: string;
  lastName?: string;
  companyName?: string;
  email?: string;
  phone?: string;
  mobile?: string;
  billingAddress?: string;
  contactNotes?: string;
}

const WINDOWS_1252_DECODER = new TextDecoder("windows-1252");
const DISABLED_PASSWORD_HASH = "legacy-import-disabled";

export async function inspectGenesisArchive(
  archivePath: string,
): Promise<GenesisImportPlan> {
  const archive = await readGenesisArchive(archivePath);
  return mapGenesisArchive(archive);
}

export async function readGenesisArchive(
  archivePath: string,
): Promise<GenesisArchiveData> {
  const archiveBuffer = await readFile(archivePath);
  const archiveSha256 = sha256Hex(archiveBuffer);
  const entries = await readZipEntries(archivePath);
  const counts: Record<string, number> = {};
  const warnings: string[] = [];
  const tables: GenesisTableData[] = [];
  const files: GenesisTextFileData[] = [];
  const legacyRecords: LegacyRecordDraft[] = [];
  const MDBReader = await loadMdbReader();

  for (const entry of entries) {
    const sourceFile = entry.fileName;
    const sourceName = sourceNameFromFile(sourceFile);

    if (isMdbFile(sourceFile)) {
      try {
        const reader = new MDBReader(entry.buffer);
        for (const sourceTable of reader.getTableNames()) {
          const rows = reader
            .getTable(sourceTable)
            .getData()
            .map((row) => normalizeRow(row as GenesisRow));
          counts[`${sourceName}.${sourceTable}`] = rows.length;
          tables.push({ sourceFile, sourceName, sourceTable, rows });

          rows.forEach((row, rowIndex) => {
            const payload = toJsonPayload(row);
            const rowHash = sha256Stable(payload);
            legacyRecords.push({
              sourceFile,
              sourceTable,
              sourceKey: `row:${sourceName}.${sourceTable}:${rowIndex}:${rowHash.slice(0, 16)}`,
              rowHash,
              rowIndex,
              recordType: "row",
              payload,
            });
          });
        }
      } catch (error) {
        warnings.push(
          `${sourceFile}: MDB could not be read: ${errorMessage(error)}`,
        );
      }
      continue;
    }

    const text = WINDOWS_1252_DECODER.decode(entry.buffer);
    const filePayload = {
      text,
      byteLength: entry.buffer.byteLength,
      sha256: sha256Hex(entry.buffer),
    };
    files.push({
      sourceFile,
      sourceName,
      text,
      byteLength: entry.buffer.byteLength,
      sha256: filePayload.sha256,
    });
    counts[`${sourceName}.__file__`] = 1;
    legacyRecords.push({
      sourceFile,
      sourceTable: "__file__",
      sourceKey: `file:${sourceName}`,
      rowHash: filePayload.sha256,
      recordType: "file",
      payload: toJsonPayload(filePayload),
    });
  }

  return {
    archivePath,
    archiveSha256,
    counts,
    warnings,
    tables,
    files,
    legacyRecords,
  };
}

async function loadMdbReader(): Promise<MdbReaderConstructor> {
  const nativeImport = new Function(
    "specifier",
    "return import(specifier)",
  ) as (specifier: string) => Promise<{ default: MdbReaderConstructor }>;
  return (await nativeImport("mdb-reader")).default;
}

export function mapGenesisArchive(
  archive: GenesisArchiveData,
): GenesisImportPlan {
  const table = tableAccessor(archive.tables);
  const customers = new Map<string, CanonicalCustomerDraft>();
  const objects = new Map<string, CanonicalObjectDraft>();
  const installations = new Map<string, CanonicalInstallationDraft>();
  const tariffCatalogItems = new Map<string, CanonicalTariffCatalogDraft>();
  const objectTariffAssignments = new Map<
    string,
    CanonicalObjectTariffAssignmentDraft
  >();
  const users = new Map<string, CanonicalUserDraft>();
  const objectById = new Map<string, CanonicalObjectDraft>();
  const legacyEntityByRecord = new Map<string, { type: string; id: string }>();
  const objectIdByKfdGrundId = new Map<string, string>();
  const objectIdByFkGrundId = new Map<string, string>();
  const objectIdByAddressKey = new Map<string, string>();
  const tariffCatalogIdBySystemCode = new Map<string, string>();

  const poolByAddressKey = indexByAddressKey(
    table("KFDPOOL", "PoolDaten"),
    "GemNr",
    "StrNr",
    "HausNr",
    "ZuNr",
  );
  const personByKfdId = buildPersonIndex(table);
  const fkObjectRows = indexFkObjects(table("FKSTAMM", "GebStamm"));
  const festArchByInstallationKey = indexFestArch(table("FKSTAMM", "FestArch"));

  for (const [rowIndex, row] of table("KFDSTAMM", "GebStamm").entries()) {
    const addressKey = addressKeyFromRow(row, "GKuG", "GKuS", "GKuH", "GKuZ");
    const grundId = cleanString(row.KGrundID);
    const sourceKey = sourceKeyFromParts("customer:kfd", [
      grundId ?? addressKey,
    ]);
    const objectSourceKey = sourceKeyFromParts("object:kfd", [
      grundId ?? addressKey,
    ]);
    const person = grundId ? personByKfdId.get(grundId) : undefined;
    const pool = poolByAddressKey.get(addressKey);
    const customer = mapCustomer(row, person, pool, {
      sourceFile: "Daten/KFDSTAMM.MDB",
      sourceTable: "GebStamm",
      sourceKey,
    });
    const object = mapObject(row, customer.id, {
      sourceFile: "Daten/KFDSTAMM.MDB",
      sourceTable: "GebStamm",
      sourceKey: objectSourceKey,
    });

    customers.set(customer.sourceKey, customer);
    objects.set(object.sourceKey, object);
    objectById.set(object.id, object);
    legacyEntityByRecord.set(
      legacyRowMapKey("Daten/KFDSTAMM.MDB", "GebStamm", rowIndex, row),
      {
        type: "object",
        id: object.id,
      },
    );
    objectIdByAddressKey.set(addressKey, object.id);
    if (grundId) {
      objectIdByKfdGrundId.set(grundId, object.id);
    }
  }

  for (const [rowIndex, row] of table("FKSTAMM", "GebStamm").entries()) {
    const fkGrundId = cleanString(row.FKGrundID);
    const kfdGrundId = cleanString(row.KFDGrundID);
    const addressKey = addressKeyFromRow(row, "GKuG", "GKuS", "GKuH", "GKuZ");
    const existingObjectId =
      (kfdGrundId ? objectIdByKfdGrundId.get(kfdGrundId) : undefined) ??
      objectIdByAddressKey.get(addressKey);

    if (existingObjectId) {
      appendFkObjectNotes(objectById.get(existingObjectId), row);
      legacyEntityByRecord.set(
        legacyRowMapKey("Daten/FKSTAMM.MDB", "GebStamm", rowIndex, row),
        {
          type: "object",
          id: existingObjectId,
        },
      );
      if (fkGrundId) {
        objectIdByFkGrundId.set(fkGrundId, existingObjectId);
      }
      continue;
    }

    const fallbackSourceKey = sourceKeyFromParts("customer:fk", [
      fkGrundId ?? addressKey,
    ]);
    const fallbackObjectSourceKey = sourceKeyFromParts("object:fk", [
      fkGrundId ?? addressKey,
    ]);
    const fallbackCustomer = mapCustomer(row, undefined, undefined, {
      sourceFile: "Daten/FKSTAMM.MDB",
      sourceTable: "GebStamm",
      sourceKey: fallbackSourceKey,
    });
    const fallbackObject = mapObject(row, fallbackCustomer.id, {
      sourceFile: "Daten/FKSTAMM.MDB",
      sourceTable: "GebStamm",
      sourceKey: fallbackObjectSourceKey,
    });
    customers.set(fallbackCustomer.sourceKey, fallbackCustomer);
    objects.set(fallbackObject.sourceKey, fallbackObject);
    objectById.set(fallbackObject.id, fallbackObject);
    legacyEntityByRecord.set(
      legacyRowMapKey("Daten/FKSTAMM.MDB", "GebStamm", rowIndex, row),
      {
        type: "object",
        id: fallbackObject.id,
      },
    );
    objectIdByAddressKey.set(addressKey, fallbackObject.id);
    if (fkGrundId) {
      objectIdByFkGrundId.set(fkGrundId, fallbackObject.id);
    }
    if (kfdGrundId) {
      objectIdByKfdGrundId.set(kfdGrundId, fallbackObject.id);
    }
  }

  for (const [rowIndex, row] of table("FKSTAMM", "FestStoff").entries()) {
    const fkGrundId = cleanString(row.FKuLfd)
      ? lookupFkGrundId(row, fkObjectRows)
      : undefined;
    const addressKey = addressKeyFromRow(row, "FKuG", "FKuS", "FKuH", "FKuZ");
    const objectId =
      (fkGrundId ? objectIdByFkGrundId.get(fkGrundId) : undefined) ??
      objectIdByAddressKey.get(addressKey);

    if (!objectId) {
      continue;
    }

    const installation = mapInstallation(
      row,
      objectId,
      festArchByInstallationKey.get(installationKeyFromFestStoff(row)) ?? [],
    );
    installations.set(installation.sourceKey, installation);
    legacyEntityByRecord.set(
      legacyRowMapKey("Daten/FKSTAMM.MDB", "FestStoff", rowIndex, row),
      {
        type: "installation",
        id: installation.id,
      },
    );
  }

  for (const [index, row] of table("KFDSTAMM", "Tarife").entries()) {
    const tariff = mapTariffCatalogItem(row, "kfd", {
      sourceFile: "Daten/KFDSTAMM.MDB",
      sourceTable: "Tarife",
      rowIndex: index,
    });
    tariffCatalogItems.set(tariff.sourceKey, tariff);
    setFirstTariffCatalogLookup(
      tariffCatalogIdBySystemCode,
      tariff.tariffSystem,
      tariff.code,
      tariff.id,
    );
    legacyEntityByRecord.set(
      legacyRowMapKey("Daten/KFDSTAMM.MDB", "Tarife", index, row),
      {
        type: "tariff_catalog_item",
        id: tariff.id,
      },
    );
  }

  for (const [index, row] of table("FKSTAMM", "Tarife").entries()) {
    const tariff = mapTariffCatalogItem(row, "fk", {
      sourceFile: "Daten/FKSTAMM.MDB",
      sourceTable: "Tarife",
      rowIndex: index,
    });
    tariffCatalogItems.set(tariff.sourceKey, tariff);
    setFirstTariffCatalogLookup(
      tariffCatalogIdBySystemCode,
      tariff.tariffSystem,
      tariff.code,
      tariff.id,
    );
    legacyEntityByRecord.set(
      legacyRowMapKey("Daten/FKSTAMM.MDB", "Tarife", index, row),
      {
        type: "tariff_catalog_item",
        id: tariff.id,
      },
    );
  }

  for (const [index, row] of table("KFDSTAMM", "GTarife").entries()) {
    const assignment = mapObjectTariffAssignment(row, "kfd", {
      sourceFile: "Daten/KFDSTAMM.MDB",
      sourceTable: "GTarife",
      rowIndex: index,
      objectId: objectIdByAddressKey.get(
        addressKeyFromRow(row, "TKuG", "TKuS", "TKuH", "TKuZ"),
      ),
      tariffCatalogIdBySystemCode,
      tariffCatalogItems,
    });
    objectTariffAssignments.set(assignment.sourceKey, assignment);
    legacyEntityByRecord.set(
      legacyRowMapKey("Daten/KFDSTAMM.MDB", "GTarife", index, row),
      {
        type: "object_tariff_assignment",
        id: assignment.id,
      },
    );
  }

  for (const [index, row] of table("FKSTAMM", "GTarife").entries()) {
    const assignment = mapObjectTariffAssignment(row, "fk", {
      sourceFile: "Daten/FKSTAMM.MDB",
      sourceTable: "GTarife",
      rowIndex: index,
      objectId: objectIdByAddressKey.get(
        addressKeyFromRow(row, "TKuG", "TKuS", "TKuH", "TKuZ"),
      ),
      tariffCatalogIdBySystemCode,
      tariffCatalogItems,
    });
    objectTariffAssignments.set(assignment.sourceKey, assignment);
    legacyEntityByRecord.set(
      legacyRowMapKey("Daten/FKSTAMM.MDB", "GTarife", index, row),
      {
        type: "object_tariff_assignment",
        id: assignment.id,
      },
    );
  }

  for (const [index, row] of table("ALLSTAMM", "Mitarbeiter").entries()) {
    const user = mapInactiveUser(row, {
      sourceFile: "Daten/ALLSTAMM.MDB",
      sourceTable: "Mitarbeiter",
      sourceKey: sourceKeyFromParts("user:allstamm:mitarbeiter", [
        cleanString(row.Kuerzel) ?? String(index),
      ]),
    });
    users.set(user.sourceKey, user);
    legacyEntityByRecord.set(
      legacyRowMapKey("Daten/ALLSTAMM.MDB", "Mitarbeiter", index, row),
      {
        type: "user",
        id: user.id,
      },
    );
  }

  for (const [index, row] of table("ALLSTAMM", "MitDaten").entries()) {
    const code = cleanString(row.MitK);
    if (code) {
      const sourceKey = sourceKeyFromParts("user:allstamm:mitarbeiter", [code]);
      if (users.has(sourceKey)) {
        legacyEntityByRecord.set(
          legacyRowMapKey("Daten/ALLSTAMM.MDB", "MitDaten", index, row),
          {
            type: "user",
            id: users.get(sourceKey)!.id,
          },
        );
        continue;
      }
    }
    const user = mapInactiveUser(row, {
      sourceFile: "Daten/ALLSTAMM.MDB",
      sourceTable: "MitDaten",
      sourceKey: sourceKeyFromParts("user:allstamm:mitdaten", [
        code ?? cleanString(row.MitNa) ?? String(index),
      ]),
    });
    users.set(user.sourceKey, user);
    legacyEntityByRecord.set(
      legacyRowMapKey("Daten/ALLSTAMM.MDB", "MitDaten", index, row),
      {
        type: "user",
        id: user.id,
      },
    );
  }

  const mappedLegacyRecords = annotateLegacyRecords(
    archive.legacyRecords,
    legacyEntityByRecord,
  );

  return {
    archivePath: archive.archivePath,
    archiveSha256: archive.archiveSha256,
    counts: archive.counts,
    warnings: archive.warnings,
    summary: {
      users: users.size,
      customers: customers.size,
      objects: objects.size,
      installations: installations.size,
      tariffCatalogItems: tariffCatalogItems.size,
      objectTariffAssignments: objectTariffAssignments.size,
      legacyRecords: mappedLegacyRecords.length,
      files: archive.files.length,
      tables: archive.tables.length,
    },
    users: [...users.values()],
    customers: [...customers.values()],
    objects: [...objects.values()],
    installations: [...installations.values()],
    tariffCatalogItems: [...tariffCatalogItems.values()],
    objectTariffAssignments: [...objectTariffAssignments.values()],
    legacyRecords: mappedLegacyRecords,
  };
}

export function sourceKeyFromParts(prefix: string, parts: unknown[]): string {
  const cleanParts = parts
    .map((part) => cleanString(part) ?? "0")
    .map((part) => part.toLowerCase().replace(/\s+/g, " "));
  return `${prefix}:${cleanParts.join(":")}`;
}

export function deterministicId(sourceKey: string): string {
  const hash = createHash("sha256")
    .update(`${GENESIS_SOURCE_SYSTEM}:${sourceKey}`)
    .digest();
  const bytes = Buffer.from(hash.subarray(0, 16));
  bytes[6] = (bytes[6] & 0x0f) | 0x50;
  bytes[8] = (bytes[8] & 0x3f) | 0x80;
  const hex = bytes.toString("hex");
  return [
    hex.slice(0, 8),
    hex.slice(8, 12),
    hex.slice(12, 16),
    hex.slice(16, 20),
    hex.slice(20, 32),
  ].join("-");
}

export function splitPersonName(displayName: string): {
  firstName?: string;
  lastName?: string;
} {
  const clean = displayName.trim().replace(/\s+/g, " ");
  if (!clean) {
    return {};
  }
  const parts = clean.split(" ");
  if (parts.length === 1) {
    return { lastName: parts[0] };
  }
  return {
    firstName: parts.slice(0, -1).join(" "),
    lastName: parts.at(-1),
  };
}

export function mapKfkInvoiceLine(row: GenesisRow): {
  quantity?: number;
  description?: string;
  price?: number;
  total?: number;
} {
  const total = numberValue(row.PossGes);
  return {
    quantity: numberValue(row.PossAnz),
    description: cleanString(row.PossBez),
    price: numberValue(row.PossPreis) ?? total,
    total,
  };
}

function tableAccessor(tables: GenesisTableData[]) {
  const byKey = new Map<string, GenesisRow[]>();
  for (const table of tables) {
    byKey.set(`${table.sourceName}.${table.sourceTable}`, table.rows);
  }
  return (sourceName: string, sourceTable: string) =>
    byKey.get(`${sourceName}.${sourceTable}`) ?? [];
}

function mapCustomer(
  row: GenesisRow,
  person: PersonInfo | undefined,
  pool: GenesisRow | undefined,
  source: { sourceFile: string; sourceTable: string; sourceKey: string },
): CanonicalCustomerDraft {
  const poolName = cleanString(pool?.PAdr2);
  const rowName = cleanString(row.GPerson);
  const displayName =
    person?.displayName ??
    poolName ??
    rowName ??
    `${cleanString(row.GStrasse) ?? "Unbekannt"} ${cleanString(row.GHausNr) ?? ""}`.trim();
  const isCompany = looksLikeCompany(displayName);
  const split = isCompany ? {} : splitPersonName(displayName);
  const phone =
    person?.phone ??
    cleanString(pool?.Telefon1) ??
    cleanString(row.GTel1) ??
    undefined;
  const mobile =
    person?.mobile ??
    cleanString(pool?.Natel) ??
    cleanString(row.GNatel) ??
    cleanString(row.GTel2) ??
    undefined;
  const email =
    person?.email ?? cleanString(pool?.EMail) ?? cleanString(row.GEMail);

  return removeUndefined({
    id: deterministicId(source.sourceKey),
    type: isCompany ? "company" : "person",
    displayName,
    firstName: person?.firstName ?? split.firstName,
    lastName: person?.lastName ?? split.lastName,
    companyName: isCompany ? displayName : person?.companyName,
    email,
    phone,
    mobile,
    billingAddress:
      person?.billingAddress ??
      billingAddressFromPool(pool) ??
      billingAddressFromGeb(row),
    notes: joinNotes(
      cleanString(row.GBem1),
      cleanString(row.GBem2),
      person?.contactNotes,
    ),
    sourceSystem: GENESIS_SOURCE_SYSTEM,
    ...source,
  });
}

function mapObject(
  row: GenesisRow,
  customerId: string,
  source: { sourceFile: string; sourceTable: string; sourceKey: string },
): CanonicalObjectDraft {
  const postalCity = splitPostalCity(cleanString(row.GPLZOrt));
  const street = cleanString(row.GStrasse) ?? "Unbekannte Strasse";
  const houseNumber = cleanString(row.GHausNr) ?? "-";

  return removeUndefined({
    id: deterministicId(source.sourceKey),
    customerId,
    name: `${street} ${houseNumber}`.trim(),
    street,
    houseNumber,
    postalCode: postalCity.postalCode ?? "0000",
    city: postalCity.city ?? "Unbekannt",
    country: "CH",
    objectNotes: joinNotes(
      cleanString(row.GGebBez),
      cleanString(row.GGebErg),
      cleanString(row.GBem1),
      cleanString(row.GBem2),
      cleanString(row.GSpez),
    ),
    sourceSystem: GENESIS_SOURCE_SYSTEM,
    ...source,
  });
}

function mapInstallation(
  row: GenesisRow,
  objectId: string,
  controlHistory: GenesisRow[],
): CanonicalInstallationDraft {
  const sourceKey = sourceKeyFromParts("installation:fk:feststoff", [
    row.FKuG,
    row.FKuS,
    row.FKuH,
    row.FKuZ,
    row.FKuLfd,
    row.F1234,
  ]);
  const type = cleanString(row.FATyp) ?? "Feuerstätte";
  const fuelType = joinNotes(
    cleanString(row.FBst1),
    cleanString(row.FBst2),
    cleanString(row.FBst3),
  );
  const notes = joinNotes(
    cleanString(row.FArtA),
    cleanString(row.FNutz),
    cleanString(row.FBeschi),
    cleanString(row.FBem1),
    cleanString(row.FBem2),
    cleanString(row.FBem3),
    formatFestArchSummary(controlHistory),
  );

  return removeUndefined({
    id: deterministicId(sourceKey),
    objectId,
    type,
    manufacturer: cleanString(row.FFabr),
    model: cleanString(row.FTyp),
    serialNumber: cleanString(row.FTypNr) ?? cleanString(row.FVKFNr),
    fuelType,
    installationYear: numberValue(row.FBJ),
    locationDescription: cleanString(row.FAufstell) ?? cleanString(row.FBezGeb),
    intervalMonths: undefined,
    notes,
    sourceSystem: GENESIS_SOURCE_SYSTEM,
    sourceFile: "Daten/FKSTAMM.MDB",
    sourceTable: "FestStoff",
    sourceKey,
  });
}

function mapTariffCatalogItem(
  row: GenesisRow,
  tariffSystem: "kfd" | "fk",
  source: { sourceFile: string; sourceTable: string; rowIndex: number },
): CanonicalTariffCatalogDraft {
  const code = cleanString(row.TKurz) ?? `__row_${source.rowIndex + 1}`;
  const sourceKey = sourceKeyFromParts("tariff_catalog", [
    tariffSystem,
    code,
    source.rowIndex,
  ]);

  return removeUndefined({
    id: deterministicId(sourceKey),
    tariffSystem,
    code,
    description: cleanString(row.TLang) ?? code,
    defaultPrice: numberValue(row.TPreis),
    taxCategory: cleanString(row.TSteuer),
    taxPoints: numberValue(row.TTax),
    isActive: true,
    sourceSystem: GENESIS_SOURCE_SYSTEM,
    sourceFile: source.sourceFile,
    sourceTable: source.sourceTable,
    sourceKey,
  });
}

function mapObjectTariffAssignment(
  row: GenesisRow,
  tariffSystem: "kfd" | "fk",
  context: {
    sourceFile: string;
    sourceTable: string;
    rowIndex: number;
    objectId?: string;
    tariffCatalogIdBySystemCode: Map<string, string>;
    tariffCatalogItems: Map<string, CanonicalTariffCatalogDraft>;
  },
): CanonicalObjectTariffAssignmentDraft {
  const code = cleanString(row.TTarif);
  const catalogId = code
    ? context.tariffCatalogIdBySystemCode.get(
        tariffCatalogLookupKey(tariffSystem, code),
      )
    : undefined;
  const catalog = catalogId
    ? [...context.tariffCatalogItems.values()].find(
        (tariff) => tariff.id === catalogId,
      )
    : undefined;
  const sourceKey = sourceKeyFromParts("object_tariff", [
    tariffSystem,
    addressKeyFromRow(row, "TKuG", "TKuS", "TKuH", "TKuZ"),
    row.TPos,
    code ?? "no-code",
    context.rowIndex,
  ]);

  return removeUndefined({
    id: deterministicId(sourceKey),
    objectId: context.objectId,
    tariffCatalogItemId: catalogId,
    tariffSystem,
    code,
    description:
      cleanString(row.TTBez) ??
      catalog?.description ??
      code ??
      "Unbekannte Leistung",
    position: numberValue(row.TPos),
    defaultQuantity: numberValue(row.TAnz),
    unit: "Stk",
    priceOverride: numberValue(row.TPreis),
    taxPoints: catalog?.taxPoints,
    billingCode: cleanString(row.TRkz),
    intervalCode: cleanString(row.TTurnus),
    flag13: cleanString(row.TVF13),
    flag14: cleanString(row.TVF14),
    flag15: cleanString(row.TVF15),
    notes: joinNotes(
      cleanString(row.TTBem),
      cleanString(row.TA1),
      cleanString(row.TA2),
    ),
    isActive: true,
    sourceSystem: GENESIS_SOURCE_SYSTEM,
    sourceFile: context.sourceFile,
    sourceTable: context.sourceTable,
    sourceKey,
  });
}

function setFirstTariffCatalogLookup(
  index: Map<string, string>,
  tariffSystem: string,
  code: string,
  id: string,
) {
  const key = tariffCatalogLookupKey(tariffSystem, code);
  if (!index.has(key)) {
    index.set(key, id);
  }
}

function tariffCatalogLookupKey(tariffSystem: string, code: string) {
  return `${tariffSystem}:${code.toLowerCase()}`;
}

function mapInactiveUser(
  row: GenesisRow,
  source: { sourceFile: string; sourceTable: string; sourceKey: string },
): CanonicalUserDraft {
  const fullName =
    cleanString(row.Mitarbeiter) ??
    cleanString(row.MitNa) ??
    cleanString(row.Kuerzel) ??
    cleanString(row.MitK) ??
    "Genesis Import";
  const split = splitPersonName(fullName);
  const code = cleanString(row.Kuerzel) ?? cleanString(row.MitK) ?? fullName;

  return removeUndefined({
    id: deterministicId(source.sourceKey),
    firstName: split.firstName ?? "Genesis",
    lastName: split.lastName ?? fullName,
    email: `${slug(code)}.import.invalid`,
    phone: cleanString(row.MitTel) ?? cleanString(row.MitNatel),
    role: "technician",
    passwordHash: DISABLED_PASSWORD_HASH,
    isActive: false,
    sourceSystem: GENESIS_SOURCE_SYSTEM,
    ...source,
  });
}

function annotateLegacyRecords(
  records: LegacyRecordDraft[],
  mapped: Map<string, { type: string; id: string }>,
) {
  return records.map((record) => {
    const mappedEntity = mapped.get(legacyRecordMapKey(record));
    return mappedEntity
      ? {
          ...record,
          mappedEntityType: mappedEntity.type,
          mappedEntityId: mappedEntity.id,
        }
      : record;
  });
}

function legacyRecordMapKey(record: {
  sourceFile: string;
  sourceTable: string;
  sourceKey: string;
}) {
  return `${record.sourceFile}:${record.sourceTable}:${record.sourceKey}`;
}

function legacyRowMapKey(
  sourceFile: string,
  sourceTable: string,
  rowIndex: number,
  row: GenesisRow,
) {
  const sourceName = sourceNameFromFile(sourceFile);
  const payload = toJsonPayload(row);
  const rowHash = sha256Stable(payload);
  return legacyRecordMapKey({
    sourceFile,
    sourceTable,
    sourceKey: `row:${sourceName}.${sourceTable}:${rowIndex}:${rowHash.slice(0, 16)}`,
  });
}

function buildPersonIndex(
  table: (sourceName: string, sourceTable: string) => GenesisRow[],
) {
  const people = new Map<string, GenesisRow>();
  const communication = new Map<string, GenesisRow[]>();
  const functionsByKfdId = new Map<string, GenesisRow[]>();
  for (const person of table("Anschriften", "Personen")) {
    const personId = cleanIdentifier(person.PersonID);
    if (personId) {
      people.set(personId, person);
    }
  }
  for (const row of table("Anschriften", "Kommunikation")) {
    const personId = cleanIdentifier(row.PersonID);
    if (!personId) {
      continue;
    }
    communication.set(personId, [...(communication.get(personId) ?? []), row]);
  }

  for (const functionRow of table("Anschriften", "Funktionen")) {
    const kfdId = cleanIdentifier(functionRow.KFDID);
    const personId = cleanIdentifier(functionRow.PersonID);
    if (!kfdId || !personId) {
      continue;
    }
    functionsByKfdId.set(kfdId, [
      ...(functionsByKfdId.get(kfdId) ?? []),
      functionRow,
    ]);
  }

  const byKfdId = new Map<string, PersonInfo>();
  for (const [kfdId, functionRows] of functionsByKfdId.entries()) {
    const contacts = functionRows
      .map((functionRow) => {
        const personId = cleanIdentifier(functionRow.PersonID);
        const person = personId ? people.get(personId) : undefined;
        if (!person || !personId) {
          return undefined;
        }
        return {
          functionRow,
          info: personInfo(person, communication.get(personId) ?? []),
        };
      })
      .filter(
        (contact): contact is { functionRow: GenesisRow; info: PersonInfo } =>
          Boolean(contact),
      )
      .sort(
        (left, right) =>
          functionPriority(left.functionRow) -
          functionPriority(right.functionRow),
      );

    const primary = contacts[0];
    if (!primary) {
      continue;
    }
    byKfdId.set(
      kfdId,
      removeUndefined({
        ...primary.info,
        contactNotes: formatContactNotes(contacts),
      }),
    );
  }
  return byKfdId;
}

function cleanIdentifier(value: unknown) {
  const clean = cleanString(value);
  return clean && clean !== "0" ? clean : undefined;
}

function functionPriority(row: GenesisRow) {
  switch (cleanString(row.Typ)) {
    case "1":
      return 0;
    case "3":
      return 1;
    case "2":
      return 2;
    case "4":
      return 3;
    case "5":
      return 4;
    default:
      return 9;
  }
}

function formatContactNotes(
  contacts: Array<{ functionRow: GenesisRow; info: PersonInfo }>,
) {
  const notes = contacts
    .map(({ functionRow, info }) => {
      const role =
        cleanString(functionRow.SonstigerTyp)?.replace(/:$/, "") ??
        roleFromFunctionType(cleanString(functionRow.Typ));
      const contact = joinNotes(
        info.displayName,
        info.billingAddress,
        info.email,
        info.mobile,
        info.phone,
      );
      return contact ? `${role}: ${contact}` : undefined;
    })
    .filter((value): value is string => Boolean(value));
  return notes.length > 0 ? `Kontaktrollen: ${notes.join(" | ")}` : undefined;
}

function roleFromFunctionType(type?: string) {
  switch (type) {
    case "1":
      return "Eigentümer";
    case "2":
      return "Mieter";
    case "3":
      return "Verwaltung";
    case "4":
      return "Hauswart";
    case "5":
      return "Ansprechperson";
    default:
      return "Kontakt";
  }
}

function personInfo(
  person: GenesisRow,
  communication: GenesisRow[],
): PersonInfo {
  const firstName = cleanString(person.Vorname);
  const lastName = cleanString(person.Name);
  const displayName =
    [firstName, lastName]
      .filter((value): value is string => Boolean(value))
      .join(" ") || "Unbekannt";
  const email =
    communication
      .map((row) => cleanString(row.KommText))
      .find((value) => value?.includes("@")) ?? undefined;
  const phones = communication
    .map((row) => cleanString(row.KommText))
    .filter((value): value is string => Boolean(value && !value.includes("@")));
  const mobile = phones.find((value) =>
    value.replace(/\D/g, "").startsWith("07"),
  );
  const phone = phones.find((value) => value !== mobile);
  const street = joinNotes(
    cleanString(person.Strasse),
    cleanString(person.Hausnummer),
  );
  const city = joinNotes(cleanString(person.PLZ), cleanString(person.Ort));

  return removeUndefined({
    displayName,
    firstName,
    lastName,
    companyName: looksLikeCompany(displayName) ? displayName : undefined,
    email,
    phone,
    mobile,
    billingAddress: joinNotes(street, city),
  });
}

function indexByAddressKey(
  rows: GenesisRow[],
  gemField: string,
  strField: string,
  houseField: string,
  zuField: string,
) {
  const index = new Map<string, GenesisRow>();
  for (const row of rows) {
    index.set(
      addressKeyFromRow(row, gemField, strField, houseField, zuField),
      row,
    );
  }
  return index;
}

function indexFkObjects(rows: GenesisRow[]) {
  const index = new Map<string, GenesisRow>();
  for (const row of rows) {
    index.set(addressKeyFromRow(row, "GKuG", "GKuS", "GKuH", "GKuZ"), row);
  }
  return index;
}

function indexFestArch(rows: GenesisRow[]) {
  const index = new Map<string, GenesisRow[]>();
  for (const row of rows) {
    const key = installationKeyFromFestArch(row);
    index.set(key, [...(index.get(key) ?? []), row]);
  }
  return index;
}

function appendFkObjectNotes(
  object: CanonicalObjectDraft | undefined,
  row: GenesisRow,
) {
  if (!object) {
    return;
  }
  const fkNotes = joinNotes(
    cleanString(row.GBem1),
    cleanString(row.GBem2),
    cleanString(row.GIntBem),
  );
  if (!fkNotes) {
    return;
  }
  object.objectNotes = joinNotes(
    object.objectNotes,
    `Holzfeuerungskontrolle: ${fkNotes}`,
  );
}

function installationKeyFromFestStoff(row: GenesisRow) {
  return [row.FKuG, row.FKuS, row.FKuH, row.FKuZ, row.FKuLfd, row.F1234]
    .map((value) => cleanString(value) ?? "0")
    .join(":")
    .toLowerCase();
}

function installationKeyFromFestArch(row: GenesisRow) {
  return [row.FAKuG, row.FAKuS, row.FAKuH, row.FAKuZ, row.FAKuLfd, row.FA1234]
    .map((value) => cleanString(value) ?? "0")
    .join(":")
    .toLowerCase();
}

function formatFestArchSummary(rows: GenesisRow[]) {
  if (rows.length === 0) {
    return undefined;
  }
  const entries = rows
    .map((row) =>
      joinNotes(
        cleanString(row.FADatum),
        cleanString(row.FAArt),
        cleanString(row.FAMit) ? `MA ${cleanString(row.FAMit)}` : undefined,
        cleanString(row.FAEntsch)
          ? `Entscheid ${cleanString(row.FAEntsch)}`
          : undefined,
        cleanString(row.FABem1),
        cleanString(row.FABem2),
        cleanString(row.FABem3),
      ),
    )
    .filter((value): value is string => Boolean(value));
  return entries.length > 0
    ? `Holzfeuerungs-Kontrollhistorie: ${entries.join(" | ")}`
    : undefined;
}

function lookupFkGrundId(
  row: GenesisRow,
  fkObjectRows: Map<string, GenesisRow>,
) {
  const objectRow = fkObjectRows.get(
    addressKeyFromRow(row, "FKuG", "FKuS", "FKuH", "FKuZ"),
  );
  return cleanString(objectRow?.FKGrundID);
}

function addressKeyFromRow(
  row: GenesisRow,
  gemField: string,
  strField: string,
  houseField: string,
  zuField: string,
) {
  return [row[gemField], row[strField], row[houseField], row[zuField]]
    .map((value) => cleanString(value) ?? "0")
    .join(":")
    .toLowerCase();
}

function splitPostalCity(value?: string) {
  if (!value) {
    return {};
  }
  const match = value.match(/^(\d{4})\s+(.+)$/);
  if (!match) {
    return { city: value };
  }
  return { postalCode: match[1], city: match[2].trim() };
}

function billingAddressFromPool(pool?: GenesisRow) {
  if (!pool) {
    return undefined;
  }
  return joinNotes(
    cleanString(pool.PAdr1),
    cleanString(pool.PAdr2),
    cleanString(pool.PAdr3),
    cleanString(pool.PAdr4),
  );
}

function billingAddressFromGeb(row: GenesisRow) {
  return joinNotes(
    `${cleanString(row.GStrasse) ?? ""} ${cleanString(row.GHausNr) ?? ""}`.trim(),
    cleanString(row.GPLZOrt),
  );
}

function joinNotes(...parts: Array<string | undefined>) {
  const clean = parts.filter((part): part is string => Boolean(part));
  return clean.length > 0 ? clean.join(", ") : undefined;
}

function looksLikeCompany(value: string) {
  return /\b(ag|gmbh|stweg|restaurant|gemeinde|verwaltung|hotel|bank|schule)\b/i.test(
    value,
  );
}

function slug(value: string) {
  const clean = value
    .toLowerCase()
    .normalize("NFKD")
    .replace(/[^\w\s-]/g, "")
    .trim()
    .replace(/\s+/g, "-")
    .replace(/_+/g, "-");
  return clean || "genesis-user";
}

function isMdbFile(fileName: string) {
  return fileName.toLowerCase().endsWith(".mdb");
}

function sourceNameFromFile(fileName: string) {
  return path.posix.basename(fileName).replace(/\.[^.]+$/, "");
}

function normalizeRow(row: GenesisRow): GenesisRow {
  const normalized: GenesisRow = {};
  for (const [key, value] of Object.entries(row)) {
    normalized[key] = normalizeValue(value);
  }
  return normalized;
}

function normalizeValue(value: unknown): unknown {
  if (value instanceof Date) {
    return value.toISOString();
  }
  if (typeof value === "bigint") {
    return value.toString();
  }
  if (Buffer.isBuffer(value)) {
    return value.toString("base64");
  }
  return value;
}

function toJsonPayload(value: unknown): JsonPayload {
  if (value === null || value === undefined) {
    return null;
  }
  if (typeof value === "number" || typeof value === "boolean") {
    return value;
  }
  if (typeof value === "string") {
    return sanitizeText(value);
  }
  if (value instanceof Date) {
    return value.toISOString();
  }
  if (typeof value === "bigint") {
    return value.toString();
  }
  if (Buffer.isBuffer(value)) {
    return value.toString("base64");
  }
  if (Array.isArray(value)) {
    return value.map(toJsonPayload);
  }
  if (typeof value === "object") {
    const output: { [key: string]: JsonPayload } = {};
    for (const [key, child] of Object.entries(value)) {
      output[key] = toJsonPayload(child);
    }
    return output;
  }
  return sanitizeText(String(value));
}

function stableStringify(value: JsonPayload): string {
  if (value === null || typeof value !== "object") {
    return JSON.stringify(value);
  }
  if (Array.isArray(value)) {
    return `[${value.map(stableStringify).join(",")}]`;
  }
  return `{${Object.keys(value)
    .sort()
    .map((key) => `${JSON.stringify(key)}:${stableStringify(value[key])}`)
    .join(",")}}`;
}

function sha256Stable(value: JsonPayload) {
  return sha256Hex(Buffer.from(stableStringify(value), "utf8"));
}

function sha256Hex(buffer: Buffer) {
  return createHash("sha256").update(buffer).digest("hex");
}

function cleanString(value: unknown) {
  if (value === null || value === undefined) {
    return undefined;
  }
  const text = sanitizeText(String(value)).trim().replace(/\s+/g, " ");
  return text.length > 0 ? text : undefined;
}

function sanitizeText(value: string) {
  return value.replace(/\u0000/g, "");
}

function numberValue(value: unknown) {
  const clean = cleanString(value);
  if (!clean) {
    return undefined;
  }
  const parsed = Number(clean.replace(",", "."));
  return Number.isFinite(parsed) ? parsed : undefined;
}

function removeUndefined<T extends Record<string, unknown>>(value: T): T {
  for (const key of Object.keys(value)) {
    if (value[key] === undefined) {
      delete value[key];
    }
  }
  return value;
}

async function readZipEntries(archivePath: string): Promise<ZipEntryData[]> {
  return new Promise((resolve, reject) => {
    yauzl.open(archivePath, { lazyEntries: true }, (openError, zipFile) => {
      if (openError || !zipFile) {
        reject(openError ?? new Error("Could not open ZIP archive."));
        return;
      }

      const entries: ZipEntryData[] = [];
      zipFile.readEntry();
      zipFile.on("entry", (entry) => {
        if (entry.fileName.endsWith("/")) {
          zipFile.readEntry();
          return;
        }
        zipFile.openReadStream(entry, (streamError, stream) => {
          if (streamError || !stream) {
            zipFile.close();
            reject(
              streamError ?? new Error(`Could not read ${entry.fileName}.`),
            );
            return;
          }

          streamToBuffer(stream)
            .then((buffer) => {
              entries.push({ fileName: entry.fileName, buffer });
              zipFile.readEntry();
            })
            .catch((error) => {
              zipFile.close();
              reject(error);
            });
        });
      });
      zipFile.on("end", () => resolve(entries));
      zipFile.on("error", reject);
    });
  });
}

async function streamToBuffer(stream: Readable): Promise<Buffer> {
  const chunks: Buffer[] = [];
  for await (const chunk of stream) {
    chunks.push(Buffer.isBuffer(chunk) ? chunk : Buffer.from(chunk));
  }
  return Buffer.concat(chunks);
}

function errorMessage(error: unknown) {
  return error instanceof Error ? error.message : String(error);
}

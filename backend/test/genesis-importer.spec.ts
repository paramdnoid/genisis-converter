import {
  GenesisArchiveData,
  deterministicId,
  mapGenesisArchive,
  mapKfkInvoiceLine,
  sourceKeyFromParts,
  splitPersonName,
} from "../src/import/genesis-importer";

describe("Genesis importer mapping", () => {
  it("normalizes source keys and derives deterministic IDs", () => {
    const key = sourceKeyFromParts("object:kfd", [" 003 ", " 01 ", "0004  "]);

    expect(key).toBe("object:kfd:003:01:0004");
    expect(deterministicId(key)).toMatch(
      /^[0-9a-f]{8}-[0-9a-f]{4}-5[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/,
    );
  });

  it("splits person names conservatively", () => {
    expect(splitPersonName("Max Muster")).toEqual({
      firstName: "Max",
      lastName: "Muster",
    });
    expect(splitPersonName("Muster")).toEqual({ lastName: "Muster" });
  });

  it("uses PossGes as KFK invoice price fallback", () => {
    expect(
      mapKfkInvoiceLine({
        PossAnz: "2",
        PossBez: "Kontrolle",
        PossPreis: " ",
        PossGes: "42.50",
      }),
    ).toEqual({
      quantity: 2,
      description: "Kontrolle",
      price: 42.5,
      total: 42.5,
    });
  });

  it("maps customers, objects, installations, and inactive users", () => {
    const archive: GenesisArchiveData = {
      archivePath: "Daten.zip",
      archiveSha256: "hash",
      counts: {},
      warnings: [],
      files: [],
      legacyRecords: [],
      tables: [
        {
          sourceFile: "Daten/KFDSTAMM.MDB",
          sourceName: "KFDSTAMM",
          sourceTable: "GebStamm",
          rows: [
            {
              GKuG: 3,
              GKuS: 1,
              GKuH: "0004",
              GKuZ: 100,
              KGrundID: 10,
              GPLZOrt: "7132 Vals",
              GStrasse: "Leis",
              GHausNr: "4",
              GBem1: "allre 5 Jahre reinigen",
            },
          ],
        },
        {
          sourceFile: "Daten/KFDPOOL.MDB",
          sourceName: "KFDPOOL",
          sourceTable: "PoolDaten",
          rows: [
            {
              GemNr: 3,
              StrNr: 1,
              HausNr: "0004",
              ZuNr: 100,
              PAdr2: "Fallback Person",
              Natel: "079 000 00 00",
            },
          ],
        },
        {
          sourceFile: "Daten/Anschriften.MDB",
          sourceName: "Anschriften",
          sourceTable: "Funktionen",
          rows: [
            { KFDID: 10, PersonID: 7, Typ: 1 },
            { KFDID: 10, PersonID: 8, Typ: 3 },
          ],
        },
        {
          sourceFile: "Daten/Anschriften.MDB",
          sourceName: "Anschriften",
          sourceTable: "Personen",
          rows: [
            {
              PersonID: 7,
              Vorname: "Max",
              Name: "Muster",
              Strasse: "Dorfstrasse",
              Hausnummer: "1",
              PLZ: "7000",
              Ort: "Chur",
            },
            {
              PersonID: 8,
              Vorname: "",
              Name: "Verwaltung AG",
              Strasse: "Bürostrasse",
              Hausnummer: "9",
              PLZ: "7001",
              Ort: "Chur",
            },
          ],
        },
        {
          sourceFile: "Daten/Anschriften.MDB",
          sourceName: "Anschriften",
          sourceTable: "Kommunikation",
          rows: [{ PersonID: 7, KommText: "max@example.invalid" }],
        },
        {
          sourceFile: "Daten/FKSTAMM.MDB",
          sourceName: "FKSTAMM",
          sourceTable: "GebStamm",
          rows: [
            {
              GKuG: 3,
              GKuS: 1,
              GKuH: "0004",
              GKuZ: 100,
              FKGrundID: 20,
              KFDGrundID: 10,
              GBem1: "Feuko Zugang via Keller",
            },
          ],
        },
        {
          sourceFile: "Daten/FKSTAMM.MDB",
          sourceName: "FKSTAMM",
          sourceTable: "FestStoff",
          rows: [
            {
              FKuG: 3,
              FKuS: 1,
              FKuH: "0004",
              FKuZ: 100,
              FKuLfd: 1,
              F1234: 1,
              FATyp: "Zentrale Feuerung",
              FFabr: "Buderus",
              FTyp: "PE 15",
              FBJ: "2006",
              FBst1: "Pellets",
              FAufstell: "Heizraum",
            },
          ],
        },
        {
          sourceFile: "Daten/FKSTAMM.MDB",
          sourceName: "FKSTAMM",
          sourceTable: "FestArch",
          rows: [
            {
              FAKuG: 3,
              FAKuS: 1,
              FAKuH: "0004",
              FAKuZ: 100,
              FAKuLfd: 1,
              FA1234: 1,
              FADatum: "2025.05.01",
              FAArt: "Periodische",
              FAMit: "MM",
              FAEntsch: "1",
            },
          ],
        },
        {
          sourceFile: "Daten/ALLSTAMM.MDB",
          sourceName: "ALLSTAMM",
          sourceTable: "Mitarbeiter",
          rows: [{ Kuerzel: "MM", Mitarbeiter: "Mia Monteur" }],
        },
        {
          sourceFile: "Daten/ALLSTAMM.MDB",
          sourceName: "ALLSTAMM",
          sourceTable: "MitDaten",
          rows: [],
        },
      ],
    };

    const plan = mapGenesisArchive(archive);

    expect(plan.customers).toHaveLength(1);
    expect(plan.customers[0]).toMatchObject({
      displayName: "Max Muster",
      firstName: "Max",
      lastName: "Muster",
      email: "max@example.invalid",
    });
    expect(plan.customers[0].notes).toContain("Eigentümer: Max Muster");
    expect(plan.customers[0].notes).toContain("Verwaltung: Verwaltung AG");
    expect(plan.objects).toHaveLength(1);
    expect(plan.objects[0]).toMatchObject({
      street: "Leis",
      houseNumber: "4",
      postalCode: "7132",
      city: "Vals",
    });
    expect(plan.objects[0].objectNotes).toContain(
      "Holzfeuerungskontrolle: Feuko Zugang via Keller",
    );
    expect(plan.installations).toHaveLength(1);
    expect(plan.installations[0]).toMatchObject({
      objectId: plan.objects[0].id,
      type: "Zentrale Feuerung",
      manufacturer: "Buderus",
      installationYear: 2006,
    });
    expect(plan.installations[0].notes).toContain(
      "Holzfeuerungs-Kontrollhistorie: 2025.05.01, Periodische, MA MM, Entscheid 1",
    );
    expect(plan.users).toHaveLength(1);
    expect(plan.users[0]).toMatchObject({
      email: "mm.import.invalid",
      isActive: false,
      role: "technician",
    });
  });

  it("maps KFD and FK tariff catalog rows and object assignments", () => {
    const archive: GenesisArchiveData = {
      archivePath: "Daten.zip",
      archiveSha256: "hash",
      counts: {},
      warnings: [],
      files: [],
      legacyRecords: [],
      tables: [
        {
          sourceFile: "Daten/KFDSTAMM.MDB",
          sourceName: "KFDSTAMM",
          sourceTable: "GebStamm",
          rows: [
            {
              GKuG: 3,
              GKuS: 1,
              GKuH: "0004",
              GKuZ: 100,
              KGrundID: 10,
              GPLZOrt: "7132 Vals",
              GStrasse: "Leis",
              GHausNr: "4",
              GPerson: "Max Muster",
            },
          ],
        },
        {
          sourceFile: "Daten/KFDSTAMM.MDB",
          sourceName: "KFDSTAMM",
          sourceTable: "Tarife",
          rows: [
            {
              TKurz: "00+00",
              TLang: "Reinigung / Kontrolle von:",
              TPreis: "0.0000",
              TSteuer: "1",
              TTax: "0.0000",
            },
          ],
        },
        {
          sourceFile: "Daten/KFDSTAMM.MDB",
          sourceName: "KFDSTAMM",
          sourceTable: "GTarife",
          rows: [
            {
              TKuG: 3,
              TKuS: 1,
              TKuH: "0004",
              TKuZ: 100,
              TPos: 1,
              TRkz: "J",
              TAnz: "1.0000",
              TTarif: "00+00",
              TTBez: "Reinigung von:",
              TPreis: "0.0000",
              TTurnus: "2",
            },
          ],
        },
        {
          sourceFile: "Daten/FKSTAMM.MDB",
          sourceName: "FKSTAMM",
          sourceTable: "Tarife",
          rows: [
            {
              TKurz: "HV010",
              TLang: "Holzfeuko mit Reinigung berechnet",
              TPreis: "0.0000",
              TSteuer: "1",
            },
          ],
        },
        {
          sourceFile: "Daten/FKSTAMM.MDB",
          sourceName: "FKSTAMM",
          sourceTable: "GTarife",
          rows: [
            {
              TKuG: 3,
              TKuS: 1,
              TKuH: "0004",
              TKuZ: 100,
              TPos: 2,
              TRkz: "J",
              TAnz: "1.0000",
              TTarif: "HV010",
              TTBez: " ",
              TTBem: "202520",
              TPreis: "0.0000",
            },
          ],
        },
      ],
    };

    const plan = mapGenesisArchive(archive);
    const kfdTariff = plan.tariffCatalogItems.find(
      (tariff) => tariff.code === "00+00",
    );
    const fkTariff = plan.tariffCatalogItems.find(
      (tariff) => tariff.code === "HV010",
    );
    const kfdAssignment = plan.objectTariffAssignments.find(
      (assignment) => assignment.code === "00+00",
    );
    const fkAssignment = plan.objectTariffAssignments.find(
      (assignment) => assignment.code === "HV010",
    );

    expect(plan.tariffCatalogItems).toHaveLength(2);
    expect(plan.objectTariffAssignments).toHaveLength(2);
    expect(kfdTariff).toMatchObject({
      tariffSystem: "kfd",
      description: "Reinigung / Kontrolle von:",
      taxCategory: "1",
      taxPoints: 0,
    });
    expect(fkTariff).toMatchObject({
      tariffSystem: "fk",
      description: "Holzfeuko mit Reinigung berechnet",
    });
    expect(kfdAssignment).toMatchObject({
      objectId: plan.objects[0].id,
      tariffCatalogItemId: kfdTariff?.id,
      description: "Reinigung von:",
      defaultQuantity: 1,
      billingCode: "J",
      intervalCode: "2",
    });
    expect(fkAssignment).toMatchObject({
      objectId: plan.objects[0].id,
      tariffCatalogItemId: fkTariff?.id,
      description: "Holzfeuko mit Reinigung berechnet",
      notes: "202520",
    });
  });
});

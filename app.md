# app.md — Roadmap & Codex-Aufgaben für die Kaminfeger-Techniker-App

**Projekt:** Offline-first Mobile App für Kaminfeger-Techniker  
**Plattformen:** iOS und Android  
**Empfohlener Stack:** Flutter + Drift/SQLite + Backend API + PostgreSQL  
**Arbeitsweise:** Diese Datei ist als vollständige Arbeitsanweisung für Codex gedacht. Codex soll die Punkte sequenziell abarbeiten, nach jedem Block testen und keine fachlichen Annahmen stillschweigend ändern.

---

## 0. Zielbild

Die App soll Kaminfeger-Techniker im Feld unterstützen. Sie muss auch ohne Internet vollständig nutzbar sein. Alle relevanten Daten sollen lokal verfügbar sein: Kunden, Objekte, Anlagen, Feuerstätten, Termine, Arbeitsaufträge, Checklisten, Messwerte, Mängel, Fotos, Unterschriften und Berichte. Sobald wieder Internet verfügbar ist, synchronisiert die App zuverlässig mit dem zentralen Backend.

Der Kern der App ist nicht das hübsche UI, sondern Zuverlässigkeit im Alltag: Keller, Heizräume, ländliche Gebiete, schlechte Verbindung, Akku, Fotos, Signaturen, PDF-Rapporte und konfliktarme Synchronisation.

---

## 1. Produktumfang

### 1.1 Benutzerrollen

- **Techniker**
  - sieht eigene Aufträge
  - arbeitet offline
  - erfasst Checklisten, Messungen, Mängel, Fotos, Material, Zeiten und Signatur
  - erstellt Bericht/PDF
  - synchronisiert Änderungen

- **Disponent / Büro**
  - erstellt und plant Aufträge
  - weist Techniker zu
  - sieht Status aller Aufträge
  - prüft Berichte
  - exportiert Daten

- **Administrator**
  - verwaltet Benutzer
  - verwaltet Stammdaten
  - verwaltet Mandant/Betrieb
  - verwaltet Checklisten-Vorlagen
  - verwaltet Nummernkreise, Berichtsvorlagen und Berechtigungen

### 1.2 Kernprozesse

1. Büro erstellt Kunden, Objekte, Anlagen und Aufträge.
2. Auftrag wird einem Techniker zugewiesen.
3. Techniker synchronisiert morgens seine Daten.
4. Techniker fährt zum Kunden.
5. App funktioniert vollständig offline.
6. Techniker bearbeitet Auftrag:
   - Ankunft erfassen
   - Checkliste ausfüllen
   - Messwerte erfassen
   - Fotos aufnehmen
   - Mängel dokumentieren
   - Material und Zeit erfassen
   - Kunde unterschreibt
   - Bericht wird generiert
7. Auftrag wird lokal als abgeschlossen markiert.
8. App synchronisiert später automatisch.
9. Büro sieht Bericht, Status und Daten im Backend.

---

## 2. Technische Grundsatzentscheidung

### 2.1 Empfohlener Stack

**Mobile App**

- Flutter
- Dart
- Drift als lokaler ORM
- SQLite als lokale Offline-Datenbank
- Riverpod für State Management
- GoRouter für Navigation
- Dio für HTTP
- Freezed/json_serializable für Modelle
- Connectivity Plus für Netzwerkstatus
- Path Provider für lokale Dateien
- Image Picker oder Camera für Fotos
- PDF/Printing für PDF-Berichte
- Signature für digitale Unterschriften
- Secure Storage für Tokens

**Backend**

- PostgreSQL als zentrale Datenbank
- REST API oder GraphQL API
- Empfohlen: NestJS, FastAPI, Rails oder Supabase Edge Functions
- JWT/OAuth-kompatible Authentifizierung
- Mandantenfähigkeit von Anfang an

**Sync**

- Offline-first mit lokaler Schreibpriorität
- Outbox Pattern für lokale Änderungen
- Server-seitige Änderungsfeeds über `updated_at`, `deleted_at`, `version`, `tenant_id`
- Konfliktauflösung pro Entität

### 2.2 Warum Flutter + Drift/SQLite?

- Eine Codebasis für iOS und Android
- Gute Performance für formularlastige Business-Apps
- Lokale relationale Datenbank passt gut zu Kunden, Objekten, Anlagen und Aufträgen
- Drift erlaubt typisierte Queries, Migrationen und Tests
- SQLite ist stabil, lokal, schnell und gut für Offline-first

---

## 3. Zielarchitektur

```text
+---------------------------------------------------------------+
|                         Mobile App                            |
|                                                               |
|  UI Screens                                                   |
|  ├─ Dashboard                                                 |
|  ├─ Aufträge                                                  |
|  ├─ Auftrag Detail                                            |
|  ├─ Checklisten                                               |
|  ├─ Messungen                                                 |
|  ├─ Fotos                                                     |
|  ├─ Mängel                                                    |
|  ├─ Bericht/PDF                                               |
|  └─ Einstellungen/Sync                                        |
|                                                               |
|  Application Layer                                            |
|  ├─ Use Cases                                                 |
|  ├─ Repositories                                              |
|  ├─ Validators                                                |
|  └─ Sync Orchestrator                                         |
|                                                               |
|  Data Layer                                                   |
|  ├─ Drift SQLite DB                                           |
|  ├─ Local File Storage                                        |
|  ├─ API Client                                                |
|  ├─ Outbox Queue                                              |
|  └─ Sync State                                                |
|                                                               |
+-------------------------+-------------------------------------+
                          |
                          | HTTPS + JSON
                          v
+---------------------------------------------------------------+
|                           Backend                             |
|                                                               |
|  API                                                          |
|  ├─ Auth                                                      |
|  ├─ Tenants                                                   |
|  ├─ Users                                                     |
|  ├─ Customers                                                 |
|  ├─ Objects                                                   |
|  ├─ Installations                                             |
|  ├─ Work Orders                                               |
|  ├─ Reports                                                   |
|  ├─ Files                                                     |
|  └─ Sync                                                      |
|                                                               |
|  PostgreSQL                                                   |
|  Object Storage                                               |
+---------------------------------------------------------------+
```

---

## 4. Repository-Struktur

Codex soll ein Monorepo erzeugen:

```text
kaminfeger-app/
├─ app.md
├─ README.md
├─ mobile/
│  ├─ pubspec.yaml
│  ├─ lib/
│  │  ├─ main.dart
│  │  ├─ app.dart
│  │  ├─ core/
│  │  │  ├─ config/
│  │  │  ├─ constants/
│  │  │  ├─ errors/
│  │  │  ├─ logging/
│  │  │  ├─ network/
│  │  │  ├─ routing/
│  │  │  ├─ theme/
│  │  │  └─ utils/
│  │  ├─ data/
│  │  │  ├─ db/
│  │  │  ├─ api/
│  │  │  ├─ repositories/
│  │  │  └─ sync/
│  │  ├─ domain/
│  │  │  ├─ entities/
│  │  │  ├─ enums/
│  │  │  ├─ value_objects/
│  │  │  └─ use_cases/
│  │  ├─ features/
│  │  │  ├─ auth/
│  │  │  ├─ dashboard/
│  │  │  ├─ customers/
│  │  │  ├─ objects/
│  │  │  ├─ work_orders/
│  │  │  ├─ checklists/
│  │  │  ├─ measurements/
│  │  │  ├─ defects/
│  │  │  ├─ photos/
│  │  │  ├─ reports/
│  │  │  ├─ sync_status/
│  │  │  └─ settings/
│  │  └─ l10n/
│  ├─ test/
│  ├─ integration_test/
│  └─ assets/
│     ├─ icons/
│     ├─ images/
│     └─ report_templates/
├─ backend/
│  ├─ package.json
│  ├─ src/
│  ├─ prisma/ oder migrations/
│  └─ test/
├─ docs/
│  ├─ architecture.md
│  ├─ api.md
│  ├─ sync.md
│  ├─ data-model.md
│  ├─ security.md
│  └─ release.md
└─ scripts/
   ├─ setup.sh
   ├─ format.sh
   ├─ test.sh
   └─ generate.sh
```

---

## 5. Projektstart: Create App

### 5.1 Codex-Aufgabe: Repository initialisieren

```bash
mkdir kaminfeger-app
cd kaminfeger-app
git init
mkdir mobile backend docs scripts
```

**Todos**

- [x] `README.md` erstellen
- [x] diese Datei als `app.md` im Root speichern
- [x] `.gitignore` für Flutter, Node, IDEs und Secrets erstellen
- [x] `.env.example` erstellen
- [x] `docs/architecture.md` erstellen
- [x] `docs/api.md` erstellen
- [x] `docs/sync.md` erstellen
- [x] `docs/data-model.md` erstellen
- [x] `docs/security.md` erstellen
- [x] `docs/release.md` erstellen

**Definition of Done**

- Projekt ist lokal in Git initialisiert
- keine Secrets im Repository
- README erklärt Setup und Start

### 5.2 Codex-Aufgabe: Flutter App erstellen

```bash
cd mobile
flutter create . --org ch.example.kaminfeger --project-name kaminfeger_mobile
```

Danach:

```bash
flutter pub get
flutter analyze
flutter test
```

**Todos**

- [x] Standard-Counter-App entfernen
- [x] `lib/main.dart` vereinfachen
- [x] `lib/app.dart` erstellen
- [x] Theme vorbereiten
- [x] Routing vorbereiten
- [x] Projekt auf iOS Simulator starten
- [x] Projekt auf Android Emulator starten

**Status 2026-06-07**

- iOS Simulator Debug-Build erfolgreich geprüft: `flutter build ios --simulator --debug`
- iOS Simulator interaktiv gestartet und sichtbar geprüft: `iPhone 17`, Bundle `ch.example.kaminfeger.kaminfegerMobile`
- Android Debug-Build erfolgreich geprüft: `flutter build apk --debug`
- Android Emulator interaktiv gestartet und sichtbar geprüft: `sdk gphone64 arm64`, Device `emulator-5554`, Bundle `ch.example.kaminfeger.kaminfeger_mobile`

**Definition of Done**

- App startet auf iOS und Android
- `flutter analyze` ist sauber
- `flutter test` läuft grün

---

## 6. Flutter Dependencies

Codex soll im `mobile/pubspec.yaml` folgende Pakete einrichten. Versionen sollen vor Installation geprüft und kompatibel gewählt werden.

### 6.1 Runtime Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter

  flutter_riverpod: any
  go_router: any
  dio: any
  drift: any
  sqlite3_flutter_libs: any
  path_provider: any
  path: any
  uuid: any
  intl: any
  freezed_annotation: any
  json_annotation: any
  connectivity_plus: any
  flutter_secure_storage: any
  shared_preferences: any
  image_picker: any
  camera: any
  file_picker: any
  signature: any
  pdf: any
  printing: any
  geolocator: any
  permission_handler: any
```

### 6.2 Dev Dependencies

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: any
  build_runner: any
  drift_dev: any
  freezed: any
  json_serializable: any
  mocktail: any
  integration_test:
    sdk: flutter
```

### 6.3 Codex-Todos

- [x] Pakete eintragen
- [x] `flutter pub get` ausführen
- [x] Build Runner konfigurieren
- [x] `dart run build_runner build --delete-conflicting-outputs` testen
- [x] Analyze und Tests ausführen

**Status 2026-06-07**

- Runtime Dependencies aus Abschnitt 6.1 sind in `mobile/pubspec.yaml` eingetragen.
- Dev Dependencies aus Abschnitt 6.2 sind in `mobile/pubspec.yaml` eingetragen.
- `integration_test` ist als Flutter-SDK-Dependency eingerichtet.
- `scripts/generate.sh` nutzt die aktuelle Build-Runner-CLI: `dart run build_runner build`.
- Hinweis: `build_runner` 2.15 ignoriert `--delete-conflicting-outputs`; der alte Prompt-Befehl wurde geprüft, der lokale Script-Befehl wurde auf die aktuelle CLI angepasst.
- Android-Kompatibilität: AGP wurde auf `8.11.1` gesetzt, weil AGP 9 mit aktuellen Plugin-Kotlin-Modi kollidiert.
- Validiert mit `flutter pub get`, `scripts/generate.sh`, `dart format --set-exit-if-changed .`, `flutter analyze`, `flutter test`, `flutter build apk --debug` und `flutter build ios --simulator --debug`.
- Bekannte Warnung: `printing` unterstützt aktuell kein Swift Package Manager für iOS; CocoaPods-Build funktioniert.

---

## 7. Coding Standards

Codex muss folgende Regeln einhalten:

- Keine Business-Logik direkt in Widgets
- Kein direkter API-Zugriff aus UI
- Kein direkter Datenbankzugriff aus UI
- Repository Pattern verwenden
- Jede Entität mit `id`, `tenantId`, `createdAt`, `updatedAt`, `deletedAt`, `version`, `syncStatus`
- Für lokale IDs UUID v4 verwenden
- Alle schreibenden Operationen zuerst lokal speichern
- Danach Outbox-Eintrag erzeugen
- Synchronisation darf UI nicht blockieren
- Fehler müssen sichtbar, aber nicht destruktiv sein
- Offline ist Normalzustand, nicht Ausnahme

---

## 8. Domain-Begriffe

| Begriff | Bedeutung |
|---|---|
| Mandant | Kaminfegerbetrieb oder Organisation |
| Benutzer | Techniker, Disponent oder Admin |
| Kunde | Privatperson, Firma oder Verwaltung |
| Objekt | Gebäude/Liegenschaft des Kunden |
| Anlage | Heizungsanlage, Feuerstätte, Kamin, Abgasanlage |
| Auftrag | geplanter Besuch/Arbeitsauftrag |
| Checkliste | strukturierte Prüfpunkte |
| Messung | Messwerte wie Temperatur, CO, O2, Zug, Russzahl etc. |
| Mangel | dokumentierte Abweichung oder Schaden |
| Rapport | Arbeitsbericht mit Zeiten, Material, Fotos und Signatur |
| Sync | Abgleich zwischen lokaler App und Server |

---

## 9. Datenmodell Mobile / Backend

Alle Tabellen müssen mandantenfähig sein. Jede Tabelle enthält mindestens:

```text
id TEXT PRIMARY KEY
tenant_id TEXT NOT NULL
created_at TEXT NOT NULL
updated_at TEXT NOT NULL
deleted_at TEXT NULL
version INTEGER NOT NULL DEFAULT 1
sync_status TEXT NOT NULL DEFAULT 'synced'
last_synced_at TEXT NULL
```

### 9.1 tenants

| Feld | Typ | Beschreibung |
|---|---|---|
| id | text | UUID |
| name | text | Betriebsname |
| address | text | Adresse |
| postal_code | text | PLZ |
| city | text | Ort |
| country | text | Land |
| phone | text | Telefon |
| email | text | E-Mail |
| logo_file_id | text nullable | Logo |

### 9.2 users

| Feld | Typ | Beschreibung |
|---|---|---|
| id | text | UUID |
| tenant_id | text | Mandant |
| first_name | text | Vorname |
| last_name | text | Nachname |
| email | text | Login |
| phone | text nullable | Telefon |
| role | text | admin, dispatcher, technician |
| is_active | bool | aktiv/inaktiv |

### 9.3 customers

| Feld | Typ | Beschreibung |
|---|---|---|
| id | text | UUID |
| tenant_id | text | Mandant |
| type | text | private, company, administration |
| display_name | text | Anzeigename |
| first_name | text nullable | Vorname |
| last_name | text nullable | Nachname |
| company_name | text nullable | Firma |
| email | text nullable | E-Mail |
| phone | text nullable | Telefon |
| mobile | text nullable | Mobile |
| billing_address | text nullable | Rechnungsadresse |
| notes | text nullable | Notizen |

### 9.4 objects

Gebäude/Liegenschaften.

| Feld | Typ | Beschreibung |
|---|---|---|
| id | text | UUID |
| tenant_id | text | Mandant |
| customer_id | text | Kunde |
| name | text | Objektname |
| street | text | Strasse |
| house_number | text | Nummer |
| postal_code | text | PLZ |
| city | text | Ort |
| country | text | Land |
| latitude | real nullable | GPS |
| longitude | real nullable | GPS |
| access_notes | text nullable | Zugangshinweise |
| safety_notes | text nullable | Sicherheitshinweise |
| object_notes | text nullable | Notizen |

### 9.5 installations

Anlagen/Feuerstätten/Abgasanlagen.

| Feld | Typ | Beschreibung |
|---|---|---|
| id | text | UUID |
| tenant_id | text | Mandant |
| object_id | text | Objekt |
| type | text | chimney, fireplace, boiler, stove, exhaust_system, other |
| manufacturer | text nullable | Hersteller |
| model | text nullable | Modell |
| serial_number | text nullable | Seriennummer |
| fuel_type | text nullable | wood, gas, oil, pellets, other |
| installation_year | int nullable | Baujahr |
| location_description | text nullable | z. B. Keller, Dachgeschoss |
| interval_months | int nullable | Wartungs-/Kontrollintervall |
| last_service_date | text nullable | letzte Arbeit |
| next_service_date | text nullable | nächste Arbeit |
| notes | text nullable | Notizen |

### 9.6 work_orders

| Feld | Typ | Beschreibung |
|---|---|---|
| id | text | UUID |
| tenant_id | text | Mandant |
| customer_id | text | Kunde |
| object_id | text | Objekt |
| assigned_user_id | text nullable | Techniker |
| order_number | text | lesbare Nummer |
| title | text | Titel |
| description | text nullable | Beschreibung |
| type | text | inspection, cleaning, maintenance, measurement, repair, emergency |
| status | text | draft, scheduled, in_progress, paused, completed, synced, cancelled |
| priority | text | low, normal, high, urgent |
| scheduled_start | text nullable | geplant Start |
| scheduled_end | text nullable | geplant Ende |
| actual_start | text nullable | tatsächlich Start |
| actual_end | text nullable | tatsächlich Ende |
| customer_signature_file_id | text nullable | Signatur |
| report_file_id | text nullable | PDF |
| completion_notes | text nullable | Abschlussnotiz |

### 9.7 work_order_installations

Zuordnung Auftrag zu Anlagen.

| Feld | Typ | Beschreibung |
|---|---|---|
| id | text | UUID |
| tenant_id | text | Mandant |
| work_order_id | text | Auftrag |
| installation_id | text | Anlage |

### 9.8 checklist_templates

| Feld | Typ | Beschreibung |
|---|---|---|
| id | text | UUID |
| tenant_id | text | Mandant |
| name | text | Name |
| type | text | Auftragstyp |
| version_number | int | Version |
| is_active | bool | aktiv |

### 9.9 checklist_template_items

| Feld | Typ | Beschreibung |
|---|---|---|
| id | text | UUID |
| tenant_id | text | Mandant |
| template_id | text | Vorlage |
| position | int | Reihenfolge |
| label | text | Frage/Text |
| help_text | text nullable | Hilfetext |
| answer_type | text | yes_no, text, number, single_select, multi_select, photo_required |
| required | bool | Pflichtfeld |
| options_json | text nullable | Optionen |

### 9.10 checklist_answers

| Feld | Typ | Beschreibung |
|---|---|---|
| id | text | UUID |
| tenant_id | text | Mandant |
| work_order_id | text | Auftrag |
| template_item_id | text | Prüffrage |
| answer_value | text nullable | Antwort |
| comment | text nullable | Kommentar |
| is_ok | bool nullable | fachlich ok |

### 9.11 measurements

| Feld | Typ | Beschreibung |
|---|---|---|
| id | text | UUID |
| tenant_id | text | Mandant |
| work_order_id | text | Auftrag |
| installation_id | text nullable | Anlage |
| measurement_type | text | co, co2, o2, temperature, draft, soot, efficiency, other |
| value | real | Wert |
| unit | text | Einheit |
| measured_at | text | Zeitpunkt |
| device_name | text nullable | Messgerät |
| device_serial | text nullable | Seriennummer |
| notes | text nullable | Notizen |

### 9.12 defects

| Feld | Typ | Beschreibung |
|---|---|---|
| id | text | UUID |
| tenant_id | text | Mandant |
| work_order_id | text | Auftrag |
| installation_id | text nullable | Anlage |
| severity | text | info, minor, major, critical |
| title | text | Titel |
| description | text | Beschreibung |
| recommended_action | text nullable | Empfehlung |
| due_date | text nullable | Frist |
| resolved | bool | erledigt |

### 9.13 photos

Metadaten. Datei selbst liegt lokal und später im Object Storage.

| Feld | Typ | Beschreibung |
|---|---|---|
| id | text | UUID |
| tenant_id | text | Mandant |
| work_order_id | text nullable | Auftrag |
| object_id | text nullable | Objekt |
| installation_id | text nullable | Anlage |
| defect_id | text nullable | Mangel |
| local_path | text | lokaler Pfad |
| remote_url | text nullable | Server-URL |
| file_name | text | Dateiname |
| mime_type | text | image/jpeg |
| size_bytes | int | Dateigrösse |
| caption | text nullable | Bildnotiz |
| taken_at | text | Zeitpunkt |
| upload_status | text | pending, uploaded, failed |

### 9.14 time_entries

| Feld | Typ | Beschreibung |
|---|---|---|
| id | text | UUID |
| tenant_id | text | Mandant |
| work_order_id | text | Auftrag |
| user_id | text | Techniker |
| type | text | travel, work, waiting, admin |
| start_time | text | Start |
| end_time | text nullable | Ende |
| duration_minutes | int nullable | Dauer |
| notes | text nullable | Notizen |

### 9.15 materials

| Feld | Typ | Beschreibung |
|---|---|---|
| id | text | UUID |
| tenant_id | text | Mandant |
| sku | text nullable | Artikelnummer |
| name | text | Material |
| unit | text | Stück, Meter, Liter |
| default_price | real nullable | Preis |
| is_active | bool | aktiv |

### 9.16 work_order_materials

| Feld | Typ | Beschreibung |
|---|---|---|
| id | text | UUID |
| tenant_id | text | Mandant |
| work_order_id | text | Auftrag |
| material_id | text nullable | Materialstamm |
| name | text | Bezeichnung |
| quantity | real | Menge |
| unit | text | Einheit |
| notes | text nullable | Notizen |

### 9.17 reports

| Feld | Typ | Beschreibung |
|---|---|---|
| id | text | UUID |
| tenant_id | text | Mandant |
| work_order_id | text | Auftrag |
| report_number | text | Rapportnummer |
| status | text | draft, generated, signed, sent, archived |
| pdf_local_path | text nullable | lokaler Pfad |
| pdf_remote_url | text nullable | Server-URL |
| generated_at | text nullable | Zeitpunkt |
| signed_at | text nullable | Zeitpunkt |
| customer_name_signed | text nullable | Name Unterzeichner |

### 9.18 outbox_entries

| Feld | Typ | Beschreibung |
|---|---|---|
| id | text | UUID |
| tenant_id | text | Mandant |
| entity_type | text | Tabelle/Entität |
| entity_id | text | Datensatz |
| operation | text | create, update, delete, upload_file |
| payload_json | text | Änderung |
| created_at | text | lokal erstellt |
| attempts | int | Versuche |
| last_attempt_at | text nullable | letzter Versuch |
| status | text | pending, processing, failed, done |
| error_message | text nullable | Fehler |

### 9.19 sync_state

| Feld | Typ | Beschreibung |
|---|---|---|
| id | text | key |
| tenant_id | text | Mandant |
| entity_type | text | Entität |
| last_pull_at | text nullable | letzter Pull |
| last_successful_sync_at | text nullable | letzter erfolgreicher Sync |
| cursor | text nullable | Server-Cursor |

---

## 10. Drift-Datenbank

### 10.1 Codex-Aufgaben

- [ ] `mobile/lib/data/db/app_database.dart` erstellen
- [ ] Drift Tabellen für alle Kernentitäten erstellen
- [ ] Gemeinsame Spalten über Mixins oder Hilfsmethoden abbilden
- [ ] Datenbank-Dateipfad über `path_provider` setzen
- [ ] Migration Strategy definieren
- [ ] `schemaVersion` starten bei 1
- [ ] DAO-Klassen je Modul erstellen
- [ ] Unit Tests für DB initialisieren
- [ ] Seed-Daten für Entwicklung erstellen

### 10.2 Mindest-DAOs

- [ ] `UserDao`
- [ ] `CustomerDao`
- [ ] `ObjectDao`
- [ ] `InstallationDao`
- [ ] `WorkOrderDao`
- [ ] `ChecklistDao`
- [ ] `MeasurementDao`
- [ ] `DefectDao`
- [ ] `PhotoDao`
- [ ] `ReportDao`
- [ ] `OutboxDao`
- [ ] `SyncStateDao`

### 10.3 Datenbankregeln

- [ ] Soft Delete verwenden: `deleted_at` statt physischem Löschen
- [ ] Queries filtern standardmässig `deleted_at IS NULL`
- [ ] Jede lokale Änderung setzt `sync_status = pending`
- [ ] Jede lokale Änderung erhöht `version`
- [ ] Jede lokale Änderung erzeugt Outbox-Eintrag
- [ ] Bulk-Operationen in Transaktionen ausführen

---

## 11. Backend API

Auch wenn zuerst nur die mobile App gebaut wird, muss die API-Struktur früh definiert werden.

### 11.1 REST Endpunkte

```text
POST   /auth/login
POST   /auth/refresh
POST   /auth/logout
GET    /me

GET    /sync/pull?since=<cursor>
POST   /sync/push
POST   /files/upload/init
PUT    /files/upload/:id
POST   /files/upload/complete

GET    /customers
POST   /customers
GET    /customers/:id
PATCH  /customers/:id
DELETE /customers/:id

GET    /objects
POST   /objects
GET    /objects/:id
PATCH  /objects/:id
DELETE /objects/:id

GET    /installations
POST   /installations
GET    /installations/:id
PATCH  /installations/:id
DELETE /installations/:id

GET    /work-orders
POST   /work-orders
GET    /work-orders/:id
PATCH  /work-orders/:id
DELETE /work-orders/:id

POST   /reports/generate
GET    /reports/:id
```

### 11.2 Sync Pull Response

```json
{
  "cursor": "server-cursor-123",
  "serverTime": "2026-01-01T10:00:00.000Z",
  "changes": {
    "customers": [],
    "objects": [],
    "installations": [],
    "workOrders": [],
    "checklistTemplates": [],
    "materials": []
  }
}
```

### 11.3 Sync Push Request

```json
{
  "deviceId": "uuid",
  "tenantId": "uuid",
  "entries": [
    {
      "outboxId": "uuid",
      "entityType": "workOrder",
      "entityId": "uuid",
      "operation": "update",
      "baseVersion": 3,
      "payload": {}
    }
  ]
}
```

### 11.4 Sync Push Response

```json
{
  "accepted": [
    {
      "outboxId": "uuid",
      "entityType": "workOrder",
      "entityId": "uuid",
      "serverVersion": 4
    }
  ],
  "rejected": [
    {
      "outboxId": "uuid",
      "entityType": "workOrder",
      "entityId": "uuid",
      "reason": "conflict",
      "serverRecord": {}
    }
  ]
}
```

---

## 12. Offline-first Synchronisation

### 12.1 Prinzipien

- App schreibt immer zuerst lokal.
- Internet ist optional.
- Sync ist wiederholbar und idempotent.
- Fehlerhafte Sync-Einträge bleiben in der Outbox.
- Sync darf keine lokalen Daten zerstören.
- Dateien/Fotos werden getrennt von JSON-Daten synchronisiert.
- Jede Änderung muss einem Benutzer und Gerät zuordenbar sein.

### 12.2 Sync-Ablauf

```text
1. App startet
2. Lokale DB öffnen
3. Auth Token prüfen
4. Netzwerkstatus prüfen
5. Pull: Serveränderungen seit letztem Cursor laden
6. In lokaler Transaktion übernehmen
7. Push: Outbox-Einträge hochladen
8. Serverantwort verarbeiten
9. Outbox-Einträge als done markieren
10. Dateien hochladen
11. Sync State aktualisieren
12. UI aktualisieren
```

### 12.3 Konfliktstrategie

| Entität | Strategie |
|---|---|
| User | Server gewinnt |
| Customer | Feldweise Merge, bei Konflikt Server gewinnt und Hinweis anzeigen |
| Object | Feldweise Merge |
| Installation | Feldweise Merge |
| WorkOrder Status | Statusmaschine, keine Rückwärtsbewegung ohne Admin |
| ChecklistAnswer | Letzte lokale Änderung pro Techniker gewinnt, Konflikt sichtbar markieren |
| Measurement | Append-only, selten überschreiben |
| Defect | Feldweise Merge, kritische Mängel nie löschen |
| Photo | Append-only |
| Report | Neue Version erzeugen, alte Version archivieren |

### 12.4 Outbox-Regeln

- [ ] Jeder lokale Create erzeugt `operation=create`
- [ ] Jedes lokale Update erzeugt `operation=update`
- [ ] Jedes lokale Delete erzeugt `operation=delete` und setzt `deleted_at`
- [ ] Foto-Uploads erzeugen `operation=upload_file`
- [ ] Mehrere Updates derselben Entität dürfen zusammengeführt werden, aber nur wenn sicher
- [ ] Nach erfolgreichem Push wird `sync_status=synced` gesetzt
- [ ] Nach Konflikt wird `sync_status=conflict` gesetzt
- [ ] Nach permanentem Fehler wird `sync_status=failed` gesetzt

### 12.5 Codex-Aufgaben Sync

- [ ] `SyncService` erstellen
- [ ] `SyncOrchestrator` erstellen
- [ ] `NetworkMonitor` erstellen
- [ ] `OutboxProcessor` erstellen
- [ ] `PullSyncService` erstellen
- [ ] `PushSyncService` erstellen
- [ ] `FileUploadSyncService` erstellen
- [ ] `ConflictResolver` erstellen
- [ ] Sync Status Provider erstellen
- [ ] UI für Sync-Status bauen
- [ ] Manuelles „Jetzt synchronisieren“ bauen
- [ ] Auto-Sync beim App-Start bauen
- [ ] Auto-Sync bei Netzwerk-Wiederkehr bauen
- [ ] Retry mit Backoff bauen
- [ ] Tests für erfolgreichen Sync schreiben
- [ ] Tests für Offline-Modus schreiben
- [ ] Tests für Konflikte schreiben
- [ ] Tests für Datei-Upload-Fehler schreiben

---

## 13. App Navigation

### 13.1 Routen

```text
/splash
/login
/sync-initial
/dashboard
/work-orders
/work-orders/:id
/work-orders/:id/checklist
/work-orders/:id/measurements
/work-orders/:id/defects
/work-orders/:id/photos
/work-orders/:id/time
/work-orders/:id/materials
/work-orders/:id/report
/customers
/customers/:id
/objects/:id
/installations/:id
/settings
/settings/sync
/settings/profile
```

### 13.2 Codex-Aufgaben Routing

- [x] GoRouter einrichten
- [ ] Auth Guard einrichten
- [ ] Offline-fähige Navigation sicherstellen
- [ ] Deep Links später vorbereiten
- [x] Fehlerseite erstellen
- [x] Loading/Splash Screen erstellen

---

## 14. UI/UX Grundregeln

- Große Buttons für Nutzung mit Arbeitshandschuhen
- Schnelle Erfassung mit möglichst wenigen Klicks
- Offline-Status jederzeit sichtbar
- Auftrag muss ohne Netz komplett abschließbar sein
- Techniker darf nie Daten verlieren
- Autosave für Formulare
- Pflichtfelder klar markieren
- Kritische Warnungen gut sichtbar
- Fotos direkt aus Auftrag, Mangel oder Anlage aufnehmen können
- Bericht vor Signatur als Vorschau anzeigen

### 14.1 Design-System

**Codex-Todos**

- [x] `AppTheme` erstellen
- [x] Farben definieren: Primary, Secondary, Warning, Error, Success, Neutral
- [x] Typografie definieren
- [x] Spacing-Konstanten definieren
- [x] Standard Buttons erstellen
- [x] Standard Cards erstellen
- [ ] Status Badges erstellen
- [x] Offline Banner erstellen
- [ ] Empty States erstellen
- [ ] Error States erstellen
- [ ] Loading Skeletons erstellen

---

## 15. Feature: Authentifizierung

### 15.1 Anforderungen

- Login mit E-Mail und Passwort
- Token sicher speichern
- Refresh Token unterstützen
- Logout löscht lokale Auth-Daten, aber nicht zwingend lokale Arbeitsdaten
- Optional später: Biometrische Entsperrung
- App darf offline weiter funktionieren, wenn bereits eingeloggt

### 15.2 Screens

- Login Screen
- Passwort vergessen Screen optional
- Profil Screen
- Session abgelaufen Dialog

### 15.3 Codex-Aufgaben

- [ ] `AuthApi` erstellen
- [ ] `AuthRepository` erstellen
- [ ] Secure Storage einrichten
- [ ] Login Use Case erstellen
- [ ] Logout Use Case erstellen
- [ ] Token Refresh Use Case erstellen
- [ ] Auth State Provider erstellen
- [x] Login Screen bauen (Platzhalter)
- [ ] Auth Guard in GoRouter einbauen
- [ ] Offline Login mit vorhandener Session erlauben
- [ ] Tests für Login Success schreiben
- [ ] Tests für Login Error schreiben
- [ ] Tests für abgelaufene Session schreiben

---

## 16. Feature: Initial Sync

### 16.1 Anforderungen

Nach erstem Login lädt die App die benötigten Daten für den Techniker:

- Benutzerprofil
- Mandantendaten
- eigene Aufträge
- relevante Kunden
- relevante Objekte
- relevante Anlagen
- aktive Checklisten-Vorlagen
- Materialstamm
- App-Konfiguration

### 16.2 Codex-Aufgaben

- [ ] `InitialSyncScreen` erstellen
- [ ] Fortschrittsanzeige erstellen
- [ ] Daten stufenweise laden
- [ ] Fehler mit Retry anzeigen
- [ ] Abbruch verhindern, solange keine Minimaldaten vorhanden sind
- [ ] Nach erfolgreichem Initial Sync zum Dashboard navigieren
- [ ] Tests für erfolgreichen Initial Sync schreiben
- [ ] Tests für Fehlerfälle schreiben

---

## 17. Feature: Dashboard

### 17.1 Inhalte

- Heutige Aufträge
- Nächster Auftrag
- Offene Synchronisationen
- Kritische Mängel
- Abgeschlossene, aber noch nicht synchronisierte Aufträge
- Schnellbutton: Synchronisieren
- Schnellbutton: Suche

### 17.2 Codex-Aufgaben

- [x] Dashboard Screen erstellen (Platzhalter)
- [ ] Heute-Query bauen
- [ ] Nächster-Auftrag-Card bauen
- [ ] Sync Status Widget einbauen
- [x] Offline Banner einbauen
- [ ] Schnellaktionen einbauen
- [x] Empty State für keine Aufträge bauen (Platzhalter im Dummy Dashboard)
- [x] Widget Tests schreiben (Splash -> Login -> Dashboard)

---

## 18. Feature: Auftragsliste

### 18.1 Anforderungen

- Liste der Aufträge
- Filter nach Status
- Filter nach Datum
- Suche nach Kunde, Adresse, Auftragsnummer
- Offline verfügbar
- Status-Badges
- Sortierung nach Terminzeit

### 18.2 Statusmodell

```text
draft -> scheduled -> in_progress -> paused -> completed -> synced
scheduled -> cancelled
in_progress -> paused
paused -> in_progress
completed -> synced
```

### 18.3 Codex-Aufgaben

- [ ] WorkOrder Entity erstellen
- [ ] WorkOrder DAO erstellen
- [ ] WorkOrder Repository erstellen
- [ ] WorkOrder List Provider erstellen
- [ ] WorkOrder List Screen erstellen
- [ ] Suchfeld bauen
- [ ] Filter-Chips bauen
- [ ] Pull-to-refresh mit Sync verbinden
- [ ] Offline-Filter testen
- [ ] Unit Tests für Statusmodell schreiben
- [ ] Widget Tests für Liste schreiben

---

## 19. Feature: Auftragsdetail

### 19.1 Inhalte

- Auftragstitel
- Kunde
- Adresse
- Telefon/E-Mail
- Objektinformationen
- Anlagenliste
- Terminzeit
- Status
- Zugangshinweise
- Sicherheitshinweise
- Notizen
- Buttons:
  - Navigation öffnen
  - Kunde anrufen
  - Auftrag starten
  - Auftrag pausieren
  - Auftrag abschließen
  - Checkliste öffnen
  - Messungen öffnen
  - Fotos öffnen
  - Mängel öffnen
  - Bericht öffnen

### 19.2 Codex-Aufgaben

- [ ] Detail Query mit Joins bauen
- [ ] Detail Screen erstellen
- [ ] Statusaktionen implementieren
- [ ] Startzeit automatisch setzen
- [ ] Endzeit automatisch setzen
- [ ] Zeitbuchung automatisch vorschlagen
- [ ] Validierung vor Abschluss implementieren
- [ ] „Navigation öffnen“ über System Maps implementieren
- [ ] „Anrufen“ über URL Launcher implementieren
- [ ] Tests für Statuswechsel schreiben

---

## 20. Feature: Kunden & Objekte

### 20.1 Anforderungen

- Kunde anzeigen
- Objekt anzeigen
- Historie früherer Aufträge anzeigen
- Anlagen anzeigen
- Kontaktinformationen verfügbar
- Notizen lokal änderbar

### 20.2 Codex-Aufgaben

- [ ] Customer Entity/DAO/Repository erstellen
- [ ] Object Entity/DAO/Repository erstellen
- [ ] Customer Detail Screen bauen
- [ ] Object Detail Screen bauen
- [ ] Historienliste bauen
- [ ] Suche nach Kunden bauen
- [ ] Editierbare Notizen bauen
- [ ] Änderungen in Outbox schreiben
- [ ] Tests schreiben

---

## 21. Feature: Anlagen / Feuerstätten

### 21.1 Anforderungen

- Anlagen pro Objekt anzeigen
- Details anzeigen
- Typ, Hersteller, Modell, Seriennummer, Brennstoff, Standort
- letzte Arbeiten und Messungen anzeigen
- Fotos und Mängel anzeigen
- Notizen ändern können

### 21.2 Codex-Aufgaben

- [ ] Installation Entity/DAO/Repository erstellen
- [ ] Installation List Screen bauen
- [ ] Installation Detail Screen bauen
- [ ] Anlagenhistorie anzeigen
- [ ] Notizen editierbar machen
- [ ] Fotos je Anlage anzeigen
- [ ] Tests schreiben

---

## 22. Feature: Checklisten

### 22.1 Anforderungen

- Checkliste aus Vorlage erzeugen
- Pflichtfelder unterstützen
- Ja/Nein, Text, Zahl, Auswahl, Mehrfachauswahl
- Kommentare pro Frage
- Foto erforderlich bei bestimmten Fragen
- Autosave
- Offline vollständig nutzbar

### 22.2 UX

- Fortschrittsanzeige: z. B. 7/12 erledigt
- Pflichtfragen sichtbar
- Fehler erst beim Abschluss aggressiv anzeigen, während Eingabe dezent
- Schnelle Ja/Nein Eingabe

### 22.3 Codex-Aufgaben

- [ ] Checklist Template Tabellen erstellen
- [ ] Checklist Answer Tabellen erstellen
- [ ] Repository erstellen
- [ ] Use Case „Create checklist from template“ erstellen
- [ ] Dynamic Form Renderer erstellen
- [ ] Answer Widgets erstellen:
  - [ ] Yes/No
  - [ ] Text
  - [ ] Number
  - [ ] Single Select
  - [ ] Multi Select
  - [ ] Photo Required
- [ ] Autosave implementieren
- [ ] Validierung implementieren
- [ ] Fortschrittsanzeige implementieren
- [ ] Tests für Pflichtfelder schreiben
- [ ] Tests für Autosave schreiben

---

## 23. Feature: Messungen

### 23.1 Anforderungen

- Messwerte manuell erfassen
- Typ und Einheit auswählen
- Anlage zuordnen
- Messzeit automatisch setzen
- Notizen erfassen
- Plausibilitätsprüfung
- Später optional: Bluetooth-Messgeräte anbinden

### 23.2 Standard-Messarten

- CO
- CO2
- O2
- Abgastemperatur
- Verbrennungslufttemperatur
- Kaminzug
- Russzahl
- Wirkungsgrad
- Druck
- Sonstige

### 23.3 Codex-Aufgaben

- [ ] Measurement Entity/DAO/Repository erstellen
- [ ] Messliste pro Auftrag bauen
- [ ] Messwert-Formular bauen
- [ ] Einheiten-Auswahl bauen
- [ ] Plausibilitätsregeln konfigurierbar machen
- [ ] Anlage-Auswahl integrieren
- [ ] Messwerte in PDF-Bericht aufnehmen
- [ ] Unit Tests für Validierung schreiben

---

## 24. Feature: Mängel

### 24.1 Anforderungen

- Mangel erfassen
- Schweregrad setzen
- Beschreibung erfassen
- empfohlene Maßnahme erfassen
- Frist setzen
- Fotos zuordnen
- Mangel im Bericht darstellen
- Kritische Mängel hervorheben

### 24.2 Schweregrade

```text
info
minor
major
critical
```

### 24.3 Codex-Aufgaben

- [ ] Defect Entity/DAO/Repository erstellen
- [ ] Mängelliste pro Auftrag bauen
- [ ] Mangel-Formular bauen
- [ ] Foto-Zuordnung bauen
- [ ] Validierung bauen
- [ ] Kritische Mängel im UI hervorheben
- [ ] Kritische Mängel im PDF hervorheben
- [ ] Tests schreiben

---

## 25. Feature: Fotos

### 25.1 Anforderungen

- Foto aufnehmen
- Foto aus Galerie wählen optional
- Foto lokal speichern
- Foto komprimieren
- Foto Auftrag/Objekt/Anlage/Mangel zuordnen
- Bildnotiz erfassen
- Upload später synchronisieren
- Fotos im Bericht einbinden

### 25.2 Dateiregeln

- Lokaler Pfad: App Documents Directory
- Struktur: `files/{tenantId}/{workOrderId}/{photoId}.jpg`
- Maximalgröße pro Bild definieren
- Original optional behalten, Standard komprimierte Version
- Upload Status tracken

### 25.3 Codex-Aufgaben

- [ ] Photo Entity/DAO/Repository erstellen
- [ ] FileStorageService erstellen
- [ ] Camera Permission Flow bauen
- [ ] Foto aufnehmen implementieren
- [ ] Foto komprimieren implementieren
- [ ] Foto-Metadaten speichern
- [ ] Foto-Galerie pro Auftrag bauen
- [ ] Foto-Detail Screen bauen
- [ ] Bildnotiz editierbar machen
- [ ] Upload über Outbox implementieren
- [ ] Tests für FileStorageService schreiben

---

## 26. Feature: Unterschrift

### 26.1 Anforderungen

- Kunde unterschreibt auf Gerät
- Name des Unterzeichners erfassen
- Signatur als PNG lokal speichern
- Signatur im Bericht einbetten
- Nach Unterschrift Bericht sperren oder neue Version erzeugen

### 26.2 Codex-Aufgaben

- [ ] Signature Screen erstellen
- [ ] Signatur-Pad integrieren
- [ ] Name-Unterzeichner-Feld erstellen
- [ ] Clear/Undo ermöglichen
- [ ] Signatur speichern
- [ ] Signatur als File-Metadatum erfassen
- [ ] Bericht nach Signatur aktualisieren
- [ ] Tests schreiben

---

## 27. Feature: Zeitrapport

### 27.1 Anforderungen

- Arbeitszeit erfassen
- Reisezeit erfassen
- Wartezeit erfassen
- Start/Stop Timer optional
- Manuelle Korrektur ermöglichen
- Zeiten im Bericht anzeigen

### 27.2 Codex-Aufgaben

- [ ] TimeEntry Entity/DAO/Repository erstellen
- [ ] Automatischen Eintrag bei Auftrag starten erstellen
- [ ] Automatischen Abschluss bei Auftrag abschließen erstellen
- [ ] Zeitliste bauen
- [ ] Zeitformular bauen
- [ ] Dauer automatisch berechnen
- [ ] Validierung gegen negative Dauer
- [ ] Tests schreiben

---

## 28. Feature: Materialverbrauch

### 28.1 Anforderungen

- Material aus Stamm auswählen
- Freitextmaterial erfassen
- Menge und Einheit erfassen
- Material im Rapport anzeigen
- Optional später Lagerbestand synchronisieren

### 28.2 Codex-Aufgaben

- [ ] Material Entity/DAO/Repository erstellen
- [ ] WorkOrderMaterial Entity/DAO/Repository erstellen
- [ ] Materialliste bauen
- [ ] Materialformular bauen
- [ ] Suche im Materialstamm bauen
- [ ] Freitextmaterial erlauben
- [ ] Validierung Menge > 0
- [ ] PDF-Integration bauen
- [ ] Tests schreiben

---

## 29. Feature: PDF-Bericht / Rapport

### 29.1 Anforderungen

PDF-Bericht enthält:

- Betriebslogo und Betriebsdaten
- Rapportnummer
- Auftragsnummer
- Kunde
- Objektadresse
- Anlagen
- Datum und Techniker
- durchgeführte Arbeiten
- Checklisten-Zusammenfassung
- Messwerte
- Mängel
- Fotos
- Material
- Zeiten
- Abschlussnotiz
- Name und Unterschrift Kunde

### 29.2 Bericht-Versionierung

- Entwurf vor Signatur
- finale Version nach Signatur
- bei Änderung nach Signatur neue Version erstellen
- alte Versionen behalten

### 29.3 Codex-Aufgaben

- [ ] Report Entity/DAO/Repository erstellen
- [ ] Report Data Aggregator bauen
- [ ] PDF Layout bauen
- [ ] Firmenlogo einbinden
- [ ] Tabellen für Messungen bauen
- [ ] Abschnitt Mängel bauen
- [ ] Foto-Anhang bauen
- [ ] Signatur einbinden
- [ ] PDF lokal speichern
- [ ] PDF Vorschau bauen
- [ ] PDF teilen/exportieren ermöglichen
- [ ] PDF Upload synchronisieren
- [ ] Tests für Report Data Aggregator schreiben
- [ ] Golden Test oder Snapshot-Test für PDF-Struktur vorbereiten

---

## 30. Feature: Auftrag abschließen

### 30.1 Abschlussvalidierung

Ein Auftrag darf abgeschlossen werden, wenn:

- Pflicht-Checklisten ausgefüllt sind
- Pflichtfotos vorhanden sind
- Messwerte bei relevanten Auftragstypen vorhanden sind
- Mängel korrekt dokumentiert sind
- Zeitrapport vorhanden ist
- Abschlussnotiz optional oder Pflicht je Konfiguration
- Signatur vorhanden ist, wenn erforderlich

### 30.2 Abschlussablauf

```text
1. Techniker klickt „Abschließen“
2. App validiert lokal
3. Fehlende Punkte anzeigen
4. Techniker ergänzt Daten
5. Berichtsvorschau anzeigen
6. Kunde unterschreibt
7. PDF generieren
8. Auftrag status=completed
9. Outbox-Einträge erzeugen
10. Später synchronisieren
```

### 30.3 Codex-Aufgaben

- [ ] CompletionValidator erstellen
- [ ] Abschluss-Screen erstellen
- [ ] Fehlende-Punkte-Liste bauen
- [ ] Berichtsvorschau integrieren
- [ ] Signatur integrieren
- [ ] Statuswechsel auf completed implementieren
- [ ] Completion Tests schreiben

---

## 31. Feature: Suche

### 31.1 Anforderungen

Offline-Suche über:

- Auftragsnummer
- Kunde
- Objektadresse
- Ort
- Anlage
- Seriennummer

### 31.2 Codex-Aufgaben

- [ ] Lokale Suchqueries bauen
- [ ] Suchscreen erstellen
- [ ] Debounce implementieren
- [ ] Ergebnisgruppen bauen
- [ ] Empty State bauen
- [ ] Tests schreiben

---

## 32. Feature: Einstellungen

### 32.1 Inhalte

- Benutzerprofil
- Mandant/Betrieb
- Sync-Status
- Speicherverbrauch
- Letzter erfolgreicher Sync
- App-Version
- Logout
- Debug-Logs exportieren optional

### 32.2 Codex-Aufgaben

- [ ] Settings Screen erstellen
- [ ] Profile Screen erstellen
- [ ] Sync Status Screen erstellen
- [ ] Storage Usage berechnen
- [ ] App Version anzeigen
- [ ] Logout Flow bauen
- [ ] Debug Export optional bauen

---

## 33. Fehlerbehandlung

### 33.1 Fehlerklassen

- NetworkError
- AuthError
- ValidationError
- DatabaseError
- SyncConflictError
- FileStorageError
- PermissionError
- UnexpectedError

### 33.2 Codex-Aufgaben

- [ ] Fehlerklassen erstellen
- [ ] Result/Either Pattern oder Exceptions sauber definieren
- [ ] Global Error Handler erstellen
- [ ] LoggingService erstellen
- [ ] User-freundliche Fehlermeldungen erstellen
- [ ] Retry-Möglichkeiten bei Sync-Fehlern einbauen
- [ ] Tests schreiben

---

## 34. Sicherheit & Datenschutz

### 34.1 Anforderungen

- Tokens in Secure Storage
- Keine Passwörter lokal speichern
- Lokale DB optional verschlüsseln, falls Kundendaten sensibel genug und Performance akzeptabel
- HTTPS erzwingen
- Mandantentrennung serverseitig erzwingen
- Rollen und Berechtigungen serverseitig prüfen
- Fotos und PDFs nicht öffentlich ablegen
- Export/Teilen nur bewusst durch Benutzer
- Logout: Token löschen
- Geräteverlust-Prozess vorsehen

### 34.2 Codex-Aufgaben

- [ ] Secure Storage implementieren
- [ ] API Client erzwingt HTTPS ausser in lokaler Entwicklung
- [ ] Keine Secrets committen
- [ ] `.env.example` erstellen
- [ ] Permission Handling sauber implementieren
- [ ] Datenschutz-Hinweise in docs/security.md dokumentieren
- [ ] Optional: DB-Verschlüsselung evaluieren und als späteres Ticket aufnehmen

---

## 35. Permissions

### 35.1 Benötigte Berechtigungen

- Kamera
- Fotos/Galerie optional
- Standort optional
- Dateien/Speicher indirekt über App-Verzeichnis
- Netzwerk

### 35.2 Codex-Aufgaben

- [ ] iOS Info.plist Permission Texte setzen
- [ ] Android Manifest Permissions setzen
- [ ] PermissionService bauen
- [ ] UI für verweigerte Berechtigung bauen
- [ ] Tests für PermissionService soweit möglich schreiben

---

## 36. Lokalisierung

### 36.1 Anforderungen

- Standardsprache Deutsch
- Schweizer Begriffe bevorzugen: Rapport, Objekt, Kaminfeger, Plz, Ort
- Später Französisch/Italienisch möglich

### 36.2 Codex-Aufgaben

- [ ] Flutter l10n einrichten
- [ ] `app_de.arb` erstellen
- [ ] Strings aus Widgets entfernen
- [ ] Datums-/Zahlenformatierung mit intl
- [ ] Vorbereitung für `app_fr.arb` und `app_it.arb`

---

## 37. Testing Strategie

### 37.1 Testarten

- Unit Tests für Use Cases
- Unit Tests für Validatoren
- Unit Tests für Sync
- Drift DB Tests
- Repository Tests
- Widget Tests für Screens
- Integration Tests für Kernflows

### 37.2 Kritische Testfälle

- [ ] App startet ohne Internet
- [ ] Login mit Internet funktioniert
- [ ] Nach Login funktioniert App offline
- [ ] Auftrag kann offline gestartet werden
- [ ] Checkliste speichert offline
- [ ] Messung speichert offline
- [ ] Foto speichert offline
- [ ] Mangel speichert offline
- [ ] Unterschrift speichert offline
- [ ] PDF wird offline generiert
- [ ] Auftrag wird offline abgeschlossen
- [ ] Sync lädt lokale Änderungen hoch
- [ ] Sync lädt Serveränderungen herunter
- [ ] Konflikt wird erkannt
- [ ] Fehlgeschlagener Foto-Upload wird wiederholt
- [ ] App-Abbruch verliert keine Daten

### 37.3 Codex-Aufgaben

- [ ] Test Utilities erstellen
- [ ] Fake API Client erstellen
- [ ] In-Memory Drift DB für Tests einrichten
- [ ] Mock Repositories erstellen
- [ ] Kern-Use-Cases testen
- [ ] CI Pipeline mit Tests vorbereiten

---

## 38. CI/CD

### 38.1 Anforderungen

- Code formatieren
- Static Analysis
- Tests
- Build Android
- Build iOS optional in Mac CI
- Keine Secrets im Log

### 38.2 GitHub Actions Beispiel

```yaml
name: mobile-ci

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          channel: stable
      - run: cd mobile && flutter pub get
      - run: cd mobile && dart format --set-exit-if-changed .
      - run: cd mobile && flutter analyze
      - run: cd mobile && flutter test
```

### 38.3 Codex-Aufgaben

- [x] `.github/workflows/mobile-ci.yml` erstellen
- [x] Format Check einrichten
- [x] Analyze einrichten
- [x] Test einrichten
- [ ] Android Build optional einrichten
- [ ] README Badge optional einrichten

---

## 39. Release Vorbereitung

### 39.1 Android

- [ ] App Name setzen
- [ ] Package Name setzen
- [ ] App Icon setzen
- [ ] Signing Config vorbereiten
- [ ] Proguard/R8 prüfen
- [ ] Version Code/Name definieren
- [ ] Internal Testing Track vorbereiten

### 39.2 iOS

- [ ] Bundle Identifier setzen
- [ ] App Name setzen
- [ ] App Icon setzen
- [ ] Launch Screen setzen
- [ ] Signing Team setzen
- [ ] Capabilities prüfen
- [ ] TestFlight Build vorbereiten

### 39.3 Codex-Aufgaben

- [ ] Release-Dokumentation in `docs/release.md`
- [ ] Flavor-Konzept für dev/staging/prod definieren
- [ ] Environment Config bauen
- [ ] Build Scripts erstellen

---

## 40. Backend Roadmap

Falls Codex auch Backend implementiert, soll es diese Reihenfolge nutzen.

### 40.1 Backend Setup

- [ ] `backend` Projekt erstellen
- [ ] Framework wählen: NestJS empfohlen
- [ ] PostgreSQL verbinden
- [ ] Migration Tool einrichten
- [ ] `.env.example` erstellen
- [ ] Healthcheck Endpoint erstellen
- [ ] Auth Modul erstellen
- [ ] Tenant Middleware erstellen

### 40.2 Backend Module

- [ ] Auth
- [ ] Tenants
- [ ] Users
- [ ] Customers
- [ ] Objects
- [ ] Installations
- [ ] WorkOrders
- [ ] Checklists
- [ ] Measurements
- [ ] Defects
- [ ] Photos/Files
- [ ] Reports
- [ ] Sync

### 40.3 Backend Sync

- [ ] Tabellen mit `version`, `updated_at`, `deleted_at`
- [ ] Sync Pull Endpoint
- [ ] Sync Push Endpoint
- [ ] Idempotency über Outbox IDs
- [ ] Konflikterkennung über Version
- [ ] File Upload Flow
- [ ] Audit Log
- [ ] Tests

---

## 41. MVP-Schnitt

### 41.1 MVP Muss-Funktionen

- Login
- Initial Sync
- Dashboard
- Auftragsliste
- Auftragsdetail
- Kunden-/Objektdaten lesen
- Anlagen lesen
- Checkliste bearbeiten
- Messwerte erfassen
- Mängel erfassen
- Fotos aufnehmen
- Zeit erfassen
- Material erfassen
- Unterschrift erfassen
- PDF Bericht generieren
- Auftrag abschließen
- Outbox Sync
- Sync Status UI

### 41.2 MVP Nicht zwingend

- Vollständige Disponenten-Web-App
- Lagerverwaltung
- Rechnungsstellung
- Bluetooth-Messgeräte
- Offline-Karten
- Mehrsprachigkeit ausser Deutsch
- Push Notifications
- Kalenderintegration

---

## 42. Milestones

### Milestone 1 — Projektbasis

- [x] Flutter App erstellt
- [x] Architekturordner erstellt
- [x] Theme und Routing aktiv
- [ ] CI läuft
- [x] Dummy Dashboard sichtbar

### Milestone 2 — Lokale DB

- [ ] Drift eingerichtet
- [ ] Kernentitäten als Tabellen vorhanden
- [ ] DAOs vorhanden
- [ ] Seed-Daten vorhanden
- [ ] Auftragsliste aus lokaler DB sichtbar

### Milestone 3 — Auftragsflow offline

- [ ] Auftrag starten
- [ ] Checkliste bearbeiten
- [ ] Messwerte erfassen
- [ ] Mängel erfassen
- [ ] Fotos aufnehmen
- [ ] Zeit erfassen
- [ ] Material erfassen
- [ ] Auftrag abschließen

### Milestone 4 — Bericht

- [ ] PDF erzeugen
- [ ] PDF Vorschau
- [ ] Signatur
- [ ] PDF lokal speichern
- [ ] PDF im Auftrag verknüpfen

### Milestone 5 — Sync

- [ ] Login API
- [ ] Initial Sync
- [ ] Pull Sync
- [ ] Push Sync
- [ ] Datei Upload
- [ ] Konfliktanzeige

### Milestone 6 — Qualität & Beta

- [ ] Tests für Kernflows
- [ ] Crash-/Fehlerlogging vorbereitet
- [ ] App Icons
- [ ] Staging Environment
- [ ] Android Internal Test
- [ ] iOS TestFlight

---

## 43. Codex Master-Todo Reihenfolge

Codex soll diese Reihenfolge strikt befolgen.

### Block A — Projekt initialisieren

- [x] Root-Repository erstellen
- [x] Flutter App erstellen
- [x] README erstellen
- [x] App starten
- [x] Analyze/Test grün machen

### Block B — Architekturgrundlage

- [x] Ordnerstruktur erstellen
- [x] Theme erstellen
- [x] Router erstellen
- [ ] Error Handling Grundlage
- [ ] Logging Grundlage
- [ ] Environment Config

### Block C — Lokale Datenbank

- [x] Drift installieren
- [ ] AppDatabase erstellen
- [ ] Tabellen erstellen
- [ ] DAOs erstellen
- [ ] Migrationen vorbereiten
- [ ] Seed Data erstellen
- [ ] DB Tests schreiben

### Block D — Repositories & Use Cases

- [ ] Domain Entities definieren
- [ ] Repository Interfaces definieren
- [ ] Repository Implementierungen bauen
- [ ] Use Cases für WorkOrders bauen
- [ ] Use Cases für Checklisten bauen
- [ ] Use Cases für Abschluss bauen
- [ ] Tests schreiben

### Block E — UI Kern

- [x] Login Screen (Platzhalter)
- [ ] Initial Sync Screen
- [x] Dashboard (Platzhalter)
- [ ] Auftragsliste
- [ ] Auftragsdetail
- [ ] Customer/Object Detail
- [ ] Settings

### Block F — Auftrag bearbeiten

- [ ] Statuswechsel
- [ ] Checklisten
- [ ] Messungen
- [ ] Mängel
- [ ] Fotos
- [ ] Zeiten
- [ ] Material
- [ ] Abschlussvalidator

### Block G — PDF & Signatur

- [ ] Signature Screen
- [ ] Report Data Aggregator
- [ ] PDF Generator
- [ ] PDF Preview
- [ ] PDF speichern
- [ ] PDF verknüpfen

### Block H — Sync

- [ ] API Client
- [ ] Auth Repository
- [ ] Initial Sync
- [ ] Pull Sync
- [ ] Outbox
- [ ] Push Sync
- [ ] File Upload Sync
- [ ] Conflict Resolver
- [ ] Sync UI

### Block I — Release-Härtung

- [ ] Permissions finalisieren
- [ ] Offline Tests
- [ ] Integration Tests
- [ ] CI finalisieren
- [ ] App Icons
- [ ] Build Flavors
- [ ] TestFlight/Android Internal Testing

---

## 44. Konkrete Codex-Prompts je Arbeitspaket

Diese Prompts können direkt an Codex gegeben werden.

### Prompt 1 — Projektbasis

```text
Lies app.md vollständig. Erstelle im Ordner mobile eine Flutter-App für iOS und Android. Entferne die Counter-Demo. Erstelle app.dart, core/theme, core/routing und einen einfachen Dashboard-Screen. Richte flutter_lints ein. Führe flutter analyze und flutter test aus. Ändere keine fachlichen Anforderungen.
```

### Prompt 2 — Dependencies

```text
Lies app.md. Ergänze die benötigten Flutter Dependencies für Riverpod, GoRouter, Drift, SQLite, Dio, Freezed, JSON Serialization, Connectivity, Secure Storage, Image Picker, Camera, PDF, Printing, Signature, Permissions und Path Provider. Achte auf kompatible Versionen. Führe pub get, build_runner, analyze und tests aus.
```

### Prompt 3 — Datenbank

```text
Lies app.md Abschnitt Datenmodell. Implementiere Drift AppDatabase mit Tabellen für tenants, users, customers, objects, installations, work_orders, work_order_installations, checklist_templates, checklist_template_items, checklist_answers, measurements, defects, photos, time_entries, materials, work_order_materials, reports, outbox_entries und sync_state. Erstelle DAOs für die Kernmodule. Schreibe Tests mit In-Memory-Datenbank.
```

### Prompt 4 — Seed Daten

```text
Erstelle lokale Seed-Daten für Entwicklung: 1 Mandant, 2 Techniker, 5 Kunden, 8 Objekte, 12 Anlagen, 10 Aufträge für heute und diese Woche, Checklisten-Vorlage, Materialstamm. Baue einen DevelopmentSeedService, der nur in dev aktiviert wird. Danach soll das Dashboard echte lokale Daten anzeigen.
```

### Prompt 5 — Auftragsliste

```text
Implementiere Auftragsliste und Auftragsdetail vollständig offline aus Drift. Liste mit Suche, Datumfilter und Statusfilter. Detailseite mit Kunde, Adresse, Objekt, Anlagen, Zugangshinweisen, Statusaktionen und Buttons zu Checkliste, Messungen, Mängeln, Fotos, Zeiten, Material und Bericht.
```

### Prompt 6 — Checklisten

```text
Implementiere das Checklistenmodul. Erzeuge Antworten aus einer Vorlage pro Auftrag. Baue einen dynamischen Formularrenderer mit answer_type yes_no, text, number, single_select, multi_select und photo_required. Implementiere Autosave, Pflichtfeldvalidierung und Fortschrittsanzeige. Jede Änderung muss lokal gespeichert und in die Outbox geschrieben werden.
```

### Prompt 7 — Messungen

```text
Implementiere Messwerterfassung pro Auftrag und optional pro Anlage. Unterstütze Messarten CO, CO2, O2, Temperatur, Zug, Russzahl, Wirkungsgrad und Sonstige. Baue Einheiten, Plausibilitätsvalidierung, Liste, Erstellen, Bearbeiten und Löschen per Soft Delete. Jede Änderung muss offline-first sein.
```

### Prompt 8 — Mängel und Fotos

```text
Implementiere Mängel mit Schweregrad, Beschreibung, Empfehlung, Frist und Fotozuordnung. Implementiere Fotoaufnahme, lokale Speicherung, Komprimierung, Metadaten und Galerie pro Auftrag. Fotos müssen offline verfügbar und später uploadbar sein. Jede Änderung muss Outbox-Einträge erzeugen.
```

### Prompt 9 — Zeit und Material

```text
Implementiere Zeitrapport und Materialverbrauch. Zeittypen: Reisezeit, Arbeitszeit, Wartezeit, Administration. Material kann aus Materialstamm oder als Freitext erfasst werden. Validierung: Dauer nicht negativ, Menge > 0. Daten müssen im Auftragsdetail und später im PDF verfügbar sein.
```

### Prompt 10 — Bericht und Signatur

```text
Implementiere Signaturerfassung und PDF-Bericht. Der PDF-Bericht enthält Betriebsdaten, Kunde, Objekt, Anlagen, Auftrag, Checkliste, Messwerte, Mängel, Fotos, Zeiten, Material, Abschlussnotiz und Kundensignatur. Speichere PDF lokal, verknüpfe es mit dem Auftrag und zeige eine Vorschau. Nach Signatur soll der Bericht als finale Version gelten.
```

### Prompt 11 — Abschlussflow

```text
Implementiere den Abschlussflow für Aufträge. Baue CompletionValidator mit Pflichtcheckliste, Pflichtfotos, Messwerten, Zeitrapport, Signatur und Bericht. Zeige fehlende Punkte. Erst nach erfolgreicher Validierung darf status=completed gesetzt werden. Alles muss offline funktionieren.
```

### Prompt 12 — Sync Engine

```text
Implementiere Offline-first Sync Engine gemäss app.md. Erstelle OutboxProcessor, PullSyncService, PushSyncService, FileUploadSyncService, ConflictResolver und SyncStatusProvider. Sync muss idempotent sein, Retry mit Backoff verwenden, Konflikte markieren und UI nicht blockieren. Baue manuelle und automatische Synchronisation.
```

### Prompt 13 — Auth und API

```text
Implementiere AuthApi, AuthRepository, Secure Token Storage, Login, Refresh, Logout und Auth Guard. App muss nach erfolgreichem Login offline weiter funktionieren. Erstelle API Client mit Dio, Interceptors für Auth, Fehlerbehandlung und Logging. Nutze Mock API, wenn Backend noch nicht verfügbar ist.
```

### Prompt 14 — Tests und Release

```text
Erstelle Tests für alle Kernflows: Offline Start, Auftrag starten, Checkliste speichern, Messung speichern, Foto speichern, Mangel speichern, Signatur speichern, PDF generieren, Auftrag abschliessen, Outbox Sync, Konfliktfall. Richte CI ein. Bereite Android und iOS Release-Konfigurationen für dev/staging/prod vor.
```

---

## 45. Akzeptanzkriterien für die komplette App

Die App gilt als fachlich fertig, wenn folgende Punkte erfüllt sind:

- [ ] Techniker kann sich anmelden
- [ ] Techniker kann Daten initial synchronisieren
- [ ] Techniker kann App danach offline nutzen
- [ ] Dashboard zeigt heutige Aufträge
- [ ] Auftrag kann gestartet werden
- [ ] Kunde, Objekt und Anlagen sind sichtbar
- [ ] Checklisten können offline ausgefüllt werden
- [ ] Messwerte können offline erfasst werden
- [ ] Mängel können offline erfasst werden
- [ ] Fotos können offline aufgenommen werden
- [ ] Zeiten können offline erfasst werden
- [ ] Material kann offline erfasst werden
- [ ] Kunde kann offline unterschreiben
- [ ] PDF kann offline generiert werden
- [ ] Auftrag kann offline abgeschlossen werden
- [ ] Sync lädt alle Änderungen später hoch
- [ ] Sync lädt neue Serverdaten herunter
- [ ] Konflikte zerstören keine Daten
- [ ] Fotos und PDFs werden synchronisiert
- [ ] App zeigt klar, was synchronisiert ist und was nicht
- [ ] App verliert keine Daten bei Neustart
- [ ] App läuft auf iOS und Android

---

## 46. Spätere Erweiterungen

### 46.1 Version 1.1

- [ ] Push Notifications für neue Aufträge
- [ ] Kalenderintegration
- [ ] Routenoptimierung
- [ ] Wiederkehrende Aufträge
- [ ] Erweiterte Auftragshistorie
- [ ] Bericht per E-Mail senden

### 46.2 Version 1.2

- [ ] Bluetooth-Messgeräte
- [ ] QR-/Barcode Scan für Anlagen
- [ ] Offline-Karten
- [ ] Lagerbestand
- [ ] Rechnungsintegration
- [ ] Web-Portal für Disposition

### 46.3 Version 2.0

- [ ] Mehrmandanten-SaaS
- [ ] Rollen-/Rechte-System fein granular
- [ ] Mandantenspezifische Berichtsvorlagen
- [ ] Mehrsprachigkeit Deutsch/Französisch/Italienisch
- [ ] Analytics und Auswertungen
- [ ] KI-gestützte Mangeltexte optional

---

## 47. Risiken

| Risiko | Gegenmaßnahme |
|---|---|
| Sync wird zu komplex | Outbox Pattern, kleine Entitäten, gute Tests |
| Datenverlust offline | Jede Eingabe sofort lokal speichern |
| Fotos/PDFs zu groß | Komprimieren, Upload Queue, Retry |
| Konflikte bei mehreren Technikern | Statusmodell, Versionierung, Konfliktanzeige |
| Unklare Fachregeln | Konfigurierbare Checklisten und Validierung |
| App zu langsam | Indizes, Pagination, keine großen Bilder in Listen |
| Backend nicht fertig | Mock API und lokale Seed-Daten |
| Store Release verzögert | Früh TestFlight/Internal Testing einrichten |

---

## 48. Performance-Vorgaben

- Dashboard lädt unter 1 Sekunde aus lokaler DB
- Auftragsliste mit 1.000 Aufträgen bleibt flüssig
- Fotos werden in Listen als Thumbnails angezeigt
- PDF-Erzeugung darf länger dauern, muss aber Fortschritt zeigen
- Sync läuft im Hintergrund und blockiert keine Eingabe
- Datenbankqueries müssen indiziert werden

### 48.1 Indizes

Codex soll mindestens Indizes anlegen auf:

- `tenant_id`
- `updated_at`
- `deleted_at`
- `sync_status`
- `work_orders.assigned_user_id`
- `work_orders.scheduled_start`
- `work_orders.status`
- `customers.display_name`
- `objects.customer_id`
- `installations.object_id`
- `checklist_answers.work_order_id`
- `measurements.work_order_id`
- `defects.work_order_id`
- `photos.work_order_id`
- `outbox_entries.status`

---

## 49. Definition of Done pro Codex-Task

Jeder Codex-Task ist erst fertig, wenn:

- [ ] Code kompiliert
- [ ] `dart format` ausgeführt wurde
- [ ] `flutter analyze` ohne relevante Fehler läuft
- [ ] Tests ergänzt oder begründet nicht nötig sind
- [ ] Offline-Verhalten nicht gebrochen wurde
- [ ] Keine Secrets hinzugefügt wurden
- [ ] README oder docs aktualisiert wurden, falls Setup betroffen ist
- [ ] Akzeptanzkriterien des Tasks erfüllt sind

---

## 50. Sofortiger nächster Schritt für Codex

Codex soll mit diesem konkreten Auftrag starten:

```text
Du bist Codex im Repository kaminfeger-app. Lies app.md vollständig. Beginne mit Block A aus Abschnitt 43. Erstelle das Root-Repository, die Flutter-App in mobile, die Basisordner, README, .gitignore, docs-Dateien und eine lauffähige leere App mit Theme, Router, Splash, Login-Platzhalter und Dashboard-Platzhalter. Danach führe flutter pub get, dart format, flutter analyze und flutter test aus. Erstelle eine kurze Zusammenfassung der erledigten Dateien und der nächsten Tasks. Keine fachlichen Anforderungen ändern.
```

**Status 2026-06-07: erledigt**

- Root-Repository wurde lokal mit Branch `main` initialisiert.
- Flutter-App wurde in `mobile/` mit iOS- und Android-Projektstruktur erzeugt.
- Counter-Demo wurde entfernt.
- App-Shell mit `ProviderScope`, `MaterialApp.router`, `AppTheme`, GoRouter, Splash, Login-Platzhalter und Dashboard-Platzhalter wurde erstellt.
- Basisordner für `core`, `data`, `domain`, `features`, `l10n`, `assets`, `backend`, `docs` und `scripts` wurden angelegt.
- README, `.gitignore`, `.env.example`, Docs, Scripts und `.github/workflows/mobile-ci.yml` wurden erstellt.
- Flutter Dependencies aus Abschnitt 6 wurden eingetragen und Build Runner wurde lauffähig konfiguriert.
- Validiert mit:
  - `flutter pub get`
  - `scripts/generate.sh`
  - `dart format --set-exit-if-changed .`
  - `flutter analyze`
  - `flutter test`
  - `flutter build apk --debug`
  - `flutter build ios --simulator --debug`
- Offen: Block C Drift/SQLite-Datenbank mit Schema, DAOs, Migrationen, Seed-Daten und DB-Tests.

---

## 51. Zusammenfassung der empfohlenen Umsetzung

Für diese Kaminfeger-Techniker-App ist die wichtigste Architekturentscheidung: **Offline-first ist der Standardzustand.** Deshalb wird die lokale SQLite-Datenbank zur primären Arbeitsdatenbank der App. Die API ist nur für Synchronisation, Authentifizierung, zentrale Verwaltung und Dateiablage zuständig.

Die App soll zuerst lokal vollständig funktionieren. Danach wird der Sync ergänzt. Diese Reihenfolge reduziert Risiko und stellt sicher, dass Techniker im Feld unabhängig von der Verbindung arbeiten können.

**Empfohlene Reihenfolge:**

1. Flutter App erstellen
2. Lokale DB und Seed-Daten bauen
3. Auftragsflow offline fertigstellen
4. PDF und Signatur bauen
5. Sync Engine bauen
6. Backend anbinden
7. Tests und Release-Härtung

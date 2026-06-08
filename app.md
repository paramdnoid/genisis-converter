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
- `url_launcher` wurde zusätzlich für Navigation-/Telefon-Aktionen im Auftragsdetail ergänzt.
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

- [x] `mobile/lib/data/db/app_database.dart` erstellen
- [x] Drift Tabellen für alle Kernentitäten erstellen
- [x] Gemeinsame Spalten über Mixins oder Hilfsmethoden abbilden
- [x] Datenbank-Dateipfad über `path_provider` setzen
- [x] Migration Strategy definieren
- [x] `schemaVersion` starten bei 1
- [x] DAO-Klassen je Modul erstellen
- [x] Unit Tests für DB initialisieren
- [x] Seed-Daten für Entwicklung erstellen

### 10.2 Mindest-DAOs

- [x] `UserDao`
- [x] `CustomerDao`
- [x] `ObjectDao`
- [x] `InstallationDao`
- [x] `WorkOrderDao`
- [x] `ChecklistDao`
- [x] `MeasurementDao`
- [x] `DefectDao`
- [x] `PhotoDao`
- [x] `ReportDao`
- [x] `OutboxDao`
- [x] `SyncStateDao`

### 10.3 Datenbankregeln

- [x] Soft Delete verwenden: `deleted_at` statt physischem Löschen
- [x] Queries filtern standardmässig `deleted_at IS NULL`
- [x] Jede lokale Änderung setzt `sync_status = pending`
- [x] Jede lokale Änderung erhöht `version`
- [x] Jede lokale Änderung erzeugt Outbox-Eintrag
- [x] Bulk-Operationen in Transaktionen ausführen

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

- [x] Jeder lokale Create erzeugt `operation=create`
- [x] Jedes lokale Update erzeugt `operation=update`
- [x] Jedes lokale Delete erzeugt `operation=delete` und setzt `deleted_at`
- [x] Foto-Uploads erzeugen `operation=upload_file`
- [x] Mehrere Updates derselben Entität dürfen zusammengeführt werden, aber nur wenn sicher
- [x] Nach erfolgreichem Push wird `sync_status=synced` gesetzt
- [x] Nach Konflikt wird `sync_status=conflict` gesetzt
- [x] Nach permanentem Fehler wird `sync_status=failed` gesetzt

### 12.5 Codex-Aufgaben Sync

- [x] `SyncService` erstellen
- [x] `SyncOrchestrator` erstellen
- [x] `NetworkMonitor` erstellen
- [x] `OutboxProcessor` erstellen
- [x] `PullSyncService` erstellen
- [x] `PushSyncService` erstellen
- [x] `FileUploadSyncService` erstellen
- [x] `ConflictResolver` erstellen
- [x] Sync Status Provider erstellen
- [x] UI für Sync-Status bauen
- [x] Manuelles „Jetzt synchronisieren“ bauen
- [x] Auto-Sync beim App-Start bauen
- [x] Auto-Sync bei Netzwerk-Wiederkehr bauen
- [x] Retry mit Backoff bauen
- [x] Tests für erfolgreichen Sync schreiben
- [x] Tests für Offline-Modus schreiben
- [x] Tests für Konflikte schreiben
- [x] Tests für Datei-Upload-Fehler schreiben

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
- [x] Auth Guard einrichten
- [x] Offline-fähige Navigation sicherstellen
- [x] Deep Links später vorbereiten
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
- [x] Status Badges erstellen
- [x] Offline Banner erstellen
- [x] Empty States erstellen
- [x] Error States erstellen
- [x] Loading Skeletons erstellen

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

- [x] `AuthApi` erstellen
- [x] `AuthRepository` erstellen
- [x] Secure Storage einrichten
- [x] Login Use Case erstellen
- [x] Logout Use Case erstellen
- [x] Token Refresh Use Case erstellen
- [x] Auth State Provider erstellen
- [x] Login Screen bauen (Platzhalter)
- [x] Auth Guard in GoRouter einbauen
- [x] Offline Login mit vorhandener Session erlauben
- [x] Tests für Login Success schreiben
- [x] Tests für Login Error schreiben
- [x] Tests für abgelaufene Session schreiben

**Status 2026-06-08**

- `AuthApi` mappt HTTP-Fehler bei Login und Token Refresh auf `AuthError`.
- Repository-Tests prüfen, dass fehlgeschlagene Logins keine Secure-Storage-Sitzung schreiben.
- Repository-Tests prüfen, dass abgelaufene Refresh-Sessions als Auth-Fehler sichtbar werden und vorhandene lokale Sitzungsdaten nicht zerstören.
- Validiert mit `flutter test test/data/repositories/secure_auth_repository_test.dart`.

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

- [x] `InitialSyncScreen` erstellen
- [x] Fortschrittsanzeige erstellen
- [x] Daten stufenweise laden
- [x] Fehler mit Retry anzeigen
- [x] Abbruch verhindern, solange keine Minimaldaten vorhanden sind
- [x] Nach erfolgreichem Initial Sync zum Dashboard navigieren
- [x] Tests für erfolgreichen Initial Sync schreiben
- [x] Tests für Fehlerfälle schreiben

**Status 2026-06-08**

- Initial-Sync-Fehlerfall ist per Widget-Test abgedeckt: Fehlertext, Retry-Button und kein Dashboard-Wechsel.
- Retry invalidiert `databaseReadyProvider`, damit ein fehlgeschlagener Initial Sync wirklich erneut ausgeführt wird.
- Retry-nach-Fehler-und-danach-Erfolg ist per Widget-Test abgedeckt.
- Validiert mit `flutter test test/features/sync_status/initial_sync_screen_test.dart`.

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
- [x] Heute-Query bauen
- [x] Nächster-Auftrag-Card bauen
- [x] Sync Status Widget einbauen
- [x] Offline Banner einbauen
- [x] Schnellaktionen einbauen
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

- [x] WorkOrder Entity erstellen
- [x] WorkOrder DAO erstellen
- [x] WorkOrder Repository erstellen
- [x] WorkOrder List Provider erstellen
- [x] WorkOrder List Screen erstellen
- [x] Suchfeld bauen
- [x] Filter-Chips bauen
- [x] Pull-to-refresh mit Sync verbinden
- [x] Offline-Filter testen
- [x] Unit Tests für Statusmodell schreiben
- [x] Widget Tests für Liste schreiben

**Status 2026-06-08**

- Offline-Filter sind per dediziertem Widget-Test mit In-Memory-Drift-Datenbank abgedeckt.
- Statusfilter `In Arbeit` und `Geplant` werden gegen lokale Daten geprüft.
- Kombinierte Suche + Statusfilter inklusive Empty State und Filter-Reset ist abgedeckt.
- Validiert mit `flutter test test/features/work_orders/work_order_list_screen_test.dart`.

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

- [x] Detail Query mit Joins bauen
- [x] Detail Screen erstellen
- [x] Statusaktionen implementieren
- [x] Startzeit automatisch setzen
- [x] Endzeit automatisch setzen
- [x] Zeitbuchung automatisch vorschlagen
- [x] Validierung vor Abschluss implementieren
- [x] „Navigation öffnen“ über System Maps implementieren
- [x] „Anrufen“ über URL Launcher implementieren
- [x] Tests für Statuswechsel schreiben

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

- [x] Customer Entity/DAO/Repository erstellen
- [x] Object Entity/DAO/Repository erstellen
- [x] Customer Detail Screen bauen
- [x] Object Detail Screen bauen
- [x] Historienliste bauen
- [x] Suche nach Kunden bauen
- [x] Editierbare Notizen bauen
- [x] Änderungen in Outbox schreiben
- [x] Tests schreiben

**Status 2026-06-08**

- Customer/Object-Repository-Interfaces und Drift-Implementierungen wurden ergänzt.
- Customer- und Object-Detail-Aggregate liefern Domain-Entities statt Drift-Rows an die UI.
- Customer-/Object-Screens nutzen Application Provider und speichern Notizen über Repositories.
- Repository-Tests prüfen lokale Detail-Aggregate und Outbox-Einträge bei Notizänderungen.
- Validiert mit `flutter test test/data/repositories/customer_repositories_test.dart`.

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

- [x] Installation Entity/DAO/Repository erstellen
- [x] Installation List Screen bauen
- [x] Installation Detail Screen bauen
- [x] Anlagenhistorie anzeigen
- [x] Notizen editierbar machen
- [x] Fotos je Anlage anzeigen
- [x] Tests schreiben

**Status 2026-06-08**

- Installation-Repository-Interface und Drift-Implementierung wurden ergänzt.
- Installation-Detail-Aggregat liefert Anlage, Historie und Fotos als Domain-Entities.
- Installation-Listen-/Detail-Screens nutzen Application Provider und speichern Notizen über das Repository.
- Repository-Tests prüfen lokale Listen, Detail-Aggregate mit Fotos und Outbox-Einträge bei Notizänderungen.
- Validiert mit `flutter test test/data/repositories/installation_repository_test.dart`.

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

- [x] Checklist Template Tabellen erstellen
- [x] Checklist Answer Tabellen erstellen
- [x] Repository erstellen
- [x] Use Case „Create checklist from template“ erstellen
- [x] Dynamic Form Renderer erstellen
- [x] Answer Widgets erstellen:
  - [x] Yes/No
  - [x] Text
  - [x] Number
  - [x] Single Select
  - [x] Multi Select
  - [x] Photo Required
- [x] Autosave implementieren
- [x] Validierung implementieren
- [x] Fortschrittsanzeige implementieren
- [x] Tests für Pflichtfelder schreiben
- [x] Tests für Autosave schreiben

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

- [x] Measurement Entity/DAO/Repository erstellen
- [x] Messliste pro Auftrag bauen
- [x] Messwert-Formular bauen
- [x] Einheiten-Auswahl bauen
- [x] Plausibilitätsregeln konfigurierbar machen
- [x] Anlage-Auswahl integrieren
- [x] Messwerte in PDF-Bericht aufnehmen
- [x] Unit Tests für Validierung schreiben

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

- [x] Defect Entity/DAO/Repository erstellen
- [x] Mängelliste pro Auftrag bauen
- [x] Mangel-Formular bauen
- [x] Foto-Zuordnung bauen
- [x] Validierung bauen
- [x] Kritische Mängel im UI hervorheben
- [x] Kritische Mängel im PDF hervorheben
- [x] Tests schreiben

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

- [x] Photo Entity/DAO/Repository erstellen
- [x] FileStorageService erstellen
- [x] Camera Permission Flow bauen
- [x] Foto aufnehmen implementieren
- [x] Foto komprimieren implementieren
- [x] Foto-Metadaten speichern
- [x] Foto-Galerie pro Auftrag bauen
- [x] Foto-Detail Screen bauen
- [x] Bildnotiz editierbar machen
- [x] Upload über Outbox implementieren
- [x] Tests für FileStorageService schreiben

**Status 2026-06-08**

- FileStorageService-Tests nutzen eine isolierte Fake-App-Documents-Directory.
- Getestet sind Pfadstruktur `files/{tenantId}/{workOrderId}`, Byte-Schreiben, Datei-Kopieren, rekursive Speicherberechnung und Fehler-Mapping auf `FileStorageError`.
- Validiert mit `flutter test test/core/files/file_storage_service_test.dart`.

---

## 26. Feature: Unterschrift

### 26.1 Anforderungen

- Kunde unterschreibt auf Gerät
- Name des Unterzeichners erfassen
- Signatur als PNG lokal speichern
- Signatur im Bericht einbetten
- Nach Unterschrift Bericht sperren oder neue Version erzeugen

### 26.2 Codex-Aufgaben

- [x] Signature Screen erstellen
- [x] Signatur-Pad integrieren
- [x] Name-Unterzeichner-Feld erstellen
- [x] Clear/Undo ermöglichen
- [x] Signatur speichern
- [x] Signatur als File-Metadatum erfassen
- [x] Bericht nach Signatur aktualisieren
- [x] Tests schreiben

**Status 2026-06-08**

- Signatur-Persistenz ist per Feature-Test abgedeckt: Foto-Metadatum, WorkOrder-Verknüpfung und Outbox-Update.
- Finaler signierter Rapport wird mit Status `signed`, `signed_at`, Unterzeichnername, WorkOrder-Verknüpfung und Upload-Outbox geprüft.
- Validiert mit `flutter test test/features/signatures/signature_persistence_test.dart`.

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

- [x] TimeEntry Entity/DAO/Repository erstellen
- [x] Automatischen Eintrag bei Auftrag starten erstellen
- [x] Automatischen Abschluss bei Auftrag abschließen erstellen
- [x] Zeitliste bauen
- [x] Zeitformular bauen
- [x] Dauer automatisch berechnen
- [x] Validierung gegen negative Dauer
- [x] Tests schreiben

---

## 28. Feature: Materialverbrauch

### 28.1 Anforderungen

- Material aus Stamm auswählen
- Freitextmaterial erfassen
- Menge und Einheit erfassen
- Material im Rapport anzeigen
- Optional später Lagerbestand synchronisieren

### 28.2 Codex-Aufgaben

- [x] Material Entity/DAO/Repository erstellen
- [x] WorkOrderMaterial Entity/DAO/Repository erstellen
- [x] Materialliste bauen
- [x] Materialformular bauen
- [x] Suche im Materialstamm bauen
- [x] Freitextmaterial erlauben
- [x] Validierung Menge > 0
- [x] PDF-Integration bauen
- [x] Tests schreiben

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

- [x] Report Entity/DAO/Repository erstellen
- [x] Report Data Aggregator bauen
- [x] PDF Layout bauen
- [x] Firmenlogo einbinden
- [x] Tabellen für Messungen bauen
- [x] Abschnitt Mängel bauen
- [x] Foto-Anhang bauen
- [x] Signatur einbinden
- [x] PDF lokal speichern
- [x] PDF Vorschau bauen
- [x] PDF teilen/exportieren ermöglichen
- [x] PDF Upload synchronisieren
- [x] Tests für Report Data Aggregator schreiben
- [x] Golden Test oder Snapshot-Test für PDF-Struktur vorbereiten

**Status 2026-06-08**

- ReportDataAggregator-Tests laden einen vollständigen lokalen Rapportdatensatz mit Header, Mandant, Anlage, Messung, Mangel, Fotos, Signatur, Zeit und Material.
- Null-Fälle für fehlenden Auftrag oder Mandant sind abgedeckt.
- PDF-Struktur-Snapshot prüft PDF-Header, EOF, Page Tree, MediaBox, Contents, Page-Objekte und Mindestgröße.
- Validiert mit `flutter test test/features/reports/application/report_data_aggregator_test.dart` und `flutter test test/features/reports/application/pdf_report_generator_test.dart`.

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

- [x] CompletionValidator erstellen
- [x] Abschluss-Screen erstellen
- [x] Fehlende-Punkte-Liste bauen
- [x] Berichtsvorschau integrieren
- [x] Signatur integrieren
- [x] Statuswechsel auf completed implementieren
- [x] Completion Tests schreiben

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

- [x] Lokale Suchqueries bauen
- [x] Suchscreen erstellen
- [x] Debounce implementieren
- [x] Ergebnisgruppen bauen
- [x] Empty State bauen
- [x] Tests schreiben

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

- [x] Settings Screen erstellen
- [x] Profile Screen erstellen
- [x] Sync Status Screen erstellen
- [x] Storage Usage berechnen
- [x] App Version anzeigen
- [x] Logout Flow bauen
- [x] Debug Export optional bauen

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

- [x] Fehlerklassen erstellen
- [x] Result/Either Pattern oder Exceptions sauber definieren
- [x] Global Error Handler erstellen
- [x] LoggingService erstellen
- [x] User-freundliche Fehlermeldungen erstellen
- [x] Retry-Möglichkeiten bei Sync-Fehlern einbauen
- [x] Tests schreiben

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

- [x] Secure Storage implementieren
- [x] API Client erzwingt HTTPS ausser in lokaler Entwicklung
- [x] Keine Secrets committen
- [x] `.env.example` erstellen
- [x] Permission Handling sauber implementieren
- [x] Datenschutz-Hinweise in docs/security.md dokumentieren
- [x] Optional: DB-Verschlüsselung evaluieren und als späteres Ticket aufnehmen

---

## 35. Permissions

### 35.1 Benötigte Berechtigungen

- Kamera
- Fotos/Galerie optional
- Standort optional
- Dateien/Speicher indirekt über App-Verzeichnis
- Netzwerk

### 35.2 Codex-Aufgaben

- [x] iOS Info.plist Permission Texte setzen
- [x] Android Manifest Permissions setzen
- [x] PermissionService bauen
- [x] UI für verweigerte Berechtigung bauen
- [x] Tests für PermissionService soweit möglich schreiben

---

## 36. Lokalisierung

### 36.1 Anforderungen

- Standardsprache Deutsch
- Schweizer Begriffe bevorzugen: Rapport, Objekt, Kaminfeger, Plz, Ort
- Später Französisch/Italienisch möglich

### 36.2 Codex-Aufgaben

- [x] Flutter l10n einrichten
- [x] `app_de.arb` erstellen
- [x] Strings aus Widgets entfernen
- [x] Datums-/Zahlenformatierung mit intl
- [x] Vorbereitung für `app_fr.arb` und `app_it.arb`

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

- [x] App startet ohne Internet
- [x] Login mit Internet funktioniert
- [x] Nach Login funktioniert App offline
- [x] Auftrag kann offline gestartet werden
- [x] Checkliste speichert offline
- [x] Messung speichert offline
- [x] Foto speichert offline
- [x] Mangel speichert offline
- [x] Unterschrift speichert offline
- [x] PDF wird offline generiert
- [x] Auftrag wird offline abgeschlossen
- [x] Sync lädt lokale Änderungen hoch
- [x] Sync lädt Serveränderungen herunter
- [x] Konflikt wird erkannt
- [x] Fehlgeschlagener Foto-Upload wird wiederholt
- [x] App-Abbruch verliert keine Daten

### 37.3 Codex-Aufgaben

- [x] Test Utilities erstellen
- [x] Fake API Client erstellen
- [x] In-Memory Drift DB für Tests einrichten
- [x] Mock Repositories erstellen
- [x] Kern-Use-Cases testen
- [x] CI Pipeline mit Tests vorbereiten

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
- [x] Android Build optional einrichten
- [x] README Badge optional einrichten

---

## 39. Release Vorbereitung

### 39.1 Android

- [x] App Name setzen
- [x] Package Name setzen
- [x] App Icon setzen
- [x] Signing Config vorbereiten
- [x] Proguard/R8 prüfen
- [x] Version Code/Name definieren
- [x] Internal Testing Track vorbereiten

### 39.2 iOS

- [x] Bundle Identifier setzen
- [x] App Name setzen
- [x] App Icon setzen
- [x] Launch Screen setzen
- [x] Signing Team setzen
- [x] Capabilities prüfen
- [x] TestFlight Build vorbereiten

### 39.3 Codex-Aufgaben

- [x] Release-Dokumentation in `docs/release.md`
- [x] Flavor-Konzept für dev/staging/prod definieren
- [x] Environment Config bauen
- [x] Build Scripts erstellen

---

## 40. Backend Roadmap

Falls Codex auch Backend implementiert, soll es diese Reihenfolge nutzen.

### 40.1 Backend Setup

- [x] `backend` Projekt erstellen
- [x] Framework wählen: NestJS empfohlen
- [x] PostgreSQL verbinden
- [x] Migration Tool einrichten
- [x] `.env.example` erstellen
- [x] Healthcheck Endpoint erstellen
- [x] Auth Modul erstellen
- [x] Tenant Middleware erstellen

### 40.2 Backend Module

- [x] Auth
- [x] Tenants
- [x] Users
- [x] Customers
- [x] Objects
- [x] Installations
- [x] WorkOrders
- [x] Checklists
- [x] Measurements
- [x] Defects
- [x] Photos/Files
- [x] Reports
- [x] Sync

### 40.3 Backend Sync

- [x] Tabellen mit `version`, `updated_at`, `deleted_at`
- [x] Sync Pull Endpoint
- [x] Sync Push Endpoint
- [x] Idempotency über Outbox IDs
- [x] Konflikterkennung über Version
- [x] File Upload Flow
- [x] Audit Log
- [x] Tests

**Status 2026-06-08**

- `backend/` ist als NestJS-Projekt mit Prisma/PostgreSQL, initialer Migration, JWT-Auth, globalem Guard, Tenant Middleware, Healthcheck und Backend-`.env.example` implementiert.
- Prisma-Schema deckt Mandanten, Benutzer, Kunden, Objekte, Anlagen, Aufträge, Checklisten, Messungen, Mängel, Fotos, Zeiten, Material, Rapporte, Uploads, Sync-Outbox-Idempotency und Audit Logs ab.
- Tenant-scoped REST-CRUD ist für alle Backend-Module aus Abschnitt 40.2 verfügbar; Reports haben zusätzlich `POST /reports/generate`.
- Sync unterstützt entity-spezifisches Pull-Format für die bestehende mobile App, den Roadmap-Pull über Collections, idempotentes Push-Replay, Konflikterkennung per `baseVersion`, Soft Delete und Audit Logs.
- File Upload Flow ist über `POST /files/upload/init`, `PUT /files/upload/:id` und `POST /files/upload/complete` implementiert.
- Validiert mit `cd backend && npm run prisma:generate`, `npm run build` und `npm test`.

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
- [x] CI läuft
- [x] Dummy Dashboard sichtbar

### Milestone 2 — Lokale DB

- [x] Drift eingerichtet
- [x] Kernentitäten als Tabellen vorhanden
- [x] DAOs vorhanden
- [x] Seed-Daten vorhanden
- [x] Auftragsliste aus lokaler DB sichtbar

### Milestone 3 — Auftragsflow offline

- [x] Auftrag starten
- [x] Checkliste bearbeiten
- [x] Messwerte erfassen
- [x] Mängel erfassen
- [x] Fotos aufnehmen
- [x] Zeit erfassen
- [x] Material erfassen
- [x] Auftrag abschließen

### Milestone 4 — Bericht

- [x] PDF erzeugen
- [x] PDF Vorschau
- [x] Signatur
- [x] PDF lokal speichern
- [x] PDF im Auftrag verknüpfen

### Milestone 5 — Sync

- [x] Login API
- [x] Initial Sync
- [x] Pull Sync
- [x] Push Sync
- [x] Datei Upload
- [x] Konfliktanzeige

### Milestone 6 — Qualität & Beta

- [x] Tests für Kernflows
- [x] Crash-/Fehlerlogging vorbereitet
- [x] App Icons
- [x] Staging Environment
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
- [x] Error Handling Grundlage
- [x] Logging Grundlage
- [x] Environment Config

### Block C — Lokale Datenbank

- [x] Drift installieren
- [x] AppDatabase erstellen
- [x] Tabellen erstellen
- [x] DAOs erstellen
- [x] Migrationen vorbereiten
- [x] Seed Data erstellen
- [x] DB Tests schreiben

### Block D — Repositories & Use Cases

- [x] Domain Entities definieren
- [x] Repository Interfaces definieren
- [x] Repository Implementierungen bauen
- [x] Use Cases für WorkOrders bauen
- [x] Use Cases für Checklisten bauen
- [x] Use Cases für Abschluss bauen
- [x] Tests schreiben

### Block E — UI Kern

- [x] Login Screen (Platzhalter)
- [x] Initial Sync Screen
- [x] Dashboard (Platzhalter)
- [x] Auftragsliste
- [x] Auftragsdetail
- [x] Customer/Object Detail
- [x] Settings

### Block F — Auftrag bearbeiten

- [x] Statuswechsel
- [x] Checklisten
- [x] Messungen
- [x] Mängel
- [x] Fotos
- [x] Zeiten
- [x] Material
- [x] Abschlussvalidator

### Block G — PDF & Signatur

- [x] Signature Screen
- [x] Report Data Aggregator
- [x] PDF Generator
- [x] PDF Preview
- [x] PDF speichern
- [x] PDF verknüpfen

### Block H — Sync

- [x] API Client
- [x] Auth Repository
- [x] Initial Sync
- [x] Pull Sync
- [x] Outbox
- [x] Push Sync
- [x] File Upload Sync
- [x] Conflict Resolver
- [x] Sync UI

### Block I — Release-Härtung

- [x] Permissions finalisieren
- [x] Offline Tests
- [ ] Integration Tests
- [x] CI finalisieren
- [x] App Icons
- [x] Build Flavors
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

- [x] Techniker kann sich anmelden
- [x] Techniker kann Daten initial synchronisieren
- [x] Techniker kann App danach offline nutzen
- [x] Dashboard zeigt heutige Aufträge
- [x] Auftrag kann gestartet werden
- [x] Kunde, Objekt und Anlagen sind sichtbar
- [x] Checklisten können offline ausgefüllt werden
- [x] Messwerte können offline erfasst werden
- [x] Mängel können offline erfasst werden
- [x] Fotos können offline aufgenommen werden
- [x] Zeiten können offline erfasst werden
- [x] Material kann offline erfasst werden
- [x] Kunde kann offline unterschreiben
- [x] PDF kann offline generiert werden
- [x] Auftrag kann offline abgeschlossen werden
- [x] Sync lädt alle Änderungen später hoch
- [x] Sync lädt neue Serverdaten herunter
- [x] Konflikte zerstören keine Daten
- [x] Fotos und PDFs werden synchronisiert
- [x] App zeigt klar, was synchronisiert ist und was nicht
- [x] App verliert keine Daten bei Neustart
- [x] App läuft auf iOS und Android

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

- [x] Code kompiliert
- [x] `dart format` ausgeführt wurde
- [x] `flutter analyze` ohne relevante Fehler läuft
- [x] Tests ergänzt oder begründet nicht nötig sind
- [x] Offline-Verhalten nicht gebrochen wurde
- [x] Keine Secrets hinzugefügt wurden
- [x] README oder docs aktualisiert wurden, falls Setup betroffen ist
- [x] Akzeptanzkriterien des Tasks erfüllt sind

**Status 2026-06-08**

- Gilt für die bisher abgeschlossenen Tasks Block A, Prompt 2, Block C, den WorkOrder-Listen/Detail/Status-Slice, das Offline-Checklistenmodul und die Offline-Messwerterfassung.
- Validierung Block A/Prompt 2 wurde lokal abgeschlossen: `scripts/generate.sh`, `dart format --set-exit-if-changed .`, `flutter analyze`, `flutter test`, `flutter build apk --debug`, `flutter build ios --simulator --debug`.
- Validierung Block C/WorkOrder/Checklisten/Messwerte-Slice wurde lokal abgeschlossen: `dart run build_runner build`, `dart format .`, `flutter analyze`, `flutter test`.
- Bisheriger Scaffold-Stand wurde committed: `ae3db8d Initial Flutter app scaffold`; der aktuelle Block-C/WorkOrder/Checklisten/Messwerte-Slice ist lokal validiert und noch nicht committed.
- Remote-CI-Lauf ist noch nicht bestätigt; deshalb bleibt `CI läuft` in Milestone 1 offen.
- Zusatzpass 2026-06-08: Kunden-/Objekt-/Anlagenhistorien, editierbare Notizen mit Outbox, Foto-Detail/Bildnotizen, Mangel-Foto-Zuordnung, Signatur erzeugt finalen Rapport, PDF-Upload-Outbox, Konfliktstatus, Retry-Backoff, Profil, Debug-Export, Release-Flavors und Build-Scripts ergänzt.
- Zusatzpass validiert mit `scripts/generate.sh`, `dart format .`, `flutter analyze`, `flutter test`, `flutter build apk --debug` und `flutter build ios --simulator --debug`.

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
- Änderungen wurden committed: `ae3db8d Initial Flutter app scaffold`.
- Validiert mit:
  - `flutter pub get`
  - `scripts/generate.sh`
  - `dart format --set-exit-if-changed .`
  - `flutter analyze`
  - `flutter test`
  - `flutter build apk --debug`
  - `flutter build ios --simulator --debug`
- Offen als nächste sinnvolle Schritte: Initial Sync/Auth, Mängel/Fotos, Zeit-/Material-UI, Report/PDF/Signatur und die vollständige Sync Engine.

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

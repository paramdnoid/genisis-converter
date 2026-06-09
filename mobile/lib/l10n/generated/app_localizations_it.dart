// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Tecnico spazzacamino';

  @override
  String get dashboardTitle => 'Oggi';

  @override
  String get syncActionTooltip => 'Sincronizza';

  @override
  String get dashboardLoadErrorTitle =>
      'Non e stato possibile caricare gli ordini locali';

  @override
  String get dashboardEmptyTodayTitle => 'Nessun ordine per oggi';

  @override
  String get dashboardEmptyTodayMessage =>
      'I nuovi dati saranno disponibili localmente dopo la prossima sincronizzazione.';

  @override
  String get dashboardOpenAllOrders => 'Apri tutti gli ordini';

  @override
  String get offlineReadyMessage =>
      'Pronto offline. I dati locali sono sincronizzati.';

  @override
  String pendingLocalChangesMessage(int count) {
    return '$count modifica/modifiche locali in attesa di sincronizzazione.';
  }

  @override
  String get ordersMetricLabel => 'Ordini';

  @override
  String get openSyncsMetricLabel => 'Sync aperte';

  @override
  String get urgentMetricLabel => 'Urgente';

  @override
  String get nextOrderTitle => 'Prossimo ordine';

  @override
  String get routeOptimizationTitle => 'Giro giornaliero';

  @override
  String routeOptimizationReadyMessage(int count) {
    return '$count fermata/e del giorno pronta/e per il percorso.';
  }

  @override
  String get routeOptimizationCoordinateMode => 'Ottimizzato con coordinate';

  @override
  String get routeOptimizationScheduleMode => 'Ordine degli appuntamenti';

  @override
  String get routeOptimizationNoStopsMessage =>
      'Nessuna fermata del giorno con indirizzo disponibile.';

  @override
  String get routeOptimizationOpenAction => 'Apri percorso ottimizzato';

  @override
  String get routeOptimizationOpenError =>
      'Impossibile aprire il percorso ottimizzato.';

  @override
  String get offlineRouteMapTitle => 'Mappa offline';

  @override
  String get offlineRouteMapAction => 'Mappa offline';

  @override
  String offlineRouteMapSubtitle(int count) {
    return '$count fermata/e disegnata/e localmente dalle coordinate.';
  }

  @override
  String get offlineRouteMapEmptyTitle => 'Nessun percorso offline';

  @override
  String get offlineRouteMapNoCoordinatesTitle => 'Nessuna coordinata';

  @override
  String get offlineRouteMapNoCoordinatesMessage =>
      'La mappa locale richiede almeno una fermata del giorno con coordinate salvate.';

  @override
  String get offlineRouteMapStopsTitle => 'Fermate';

  @override
  String get offlineRouteMapUnmappedTitle => 'Senza coordinate';

  @override
  String get recurringWorkOrdersTitle => 'Ordini ricorrenti';

  @override
  String recurringWorkOrdersDueCount(int count) {
    return '$count in scadenza';
  }

  @override
  String recurringWorkOrdersReadyMessage(int count) {
    return '$count impianto/i richiede/richiedono un nuovo ordine.';
  }

  @override
  String get recurringWorkOrdersEmptyMessage =>
      'Nessun ordine ricorrente in scadenza.';

  @override
  String get recurringWorkOrdersCreateAction => 'Crea ordini in scadenza';

  @override
  String recurringWorkOrdersCreatedMessage(int count) {
    return '$count ordine/i ricorrente/i creato/i localmente.';
  }

  @override
  String recurringWorkOrdersErrorMessage(String error) {
    return 'Impossibile creare gli ordini ricorrenti: $error';
  }

  @override
  String get startOrderAction => 'Avvia';

  @override
  String get pauseOrderAction => 'Pausieren';

  @override
  String get resumeOrderAction => 'Fortsetzen';

  @override
  String get allOrdersTooltip => 'Tutti gli ordini';

  @override
  String get syncStatusTitle => 'Stato sync';

  @override
  String get syncNowTooltip => 'Jetzt synchronisieren';

  @override
  String get syncStatusCleanMessage => 'Nessuna modifica locale nell\'outbox.';

  @override
  String get syncStatusWaitingMessage =>
      'L\'outbox attende la prossima connessione.';

  @override
  String get syncStatusSynchronized => 'Sincronizzato';

  @override
  String syncStatusOpenCount(int count) {
    return '$count aperto/i';
  }

  @override
  String get quickActionsTitle => 'Azioni rapide';

  @override
  String get searchAction => 'Cerca';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get noAppointment => 'senza appuntamento';

  @override
  String get noDate => 'senza data';

  @override
  String get searchTitle => 'Cerca';

  @override
  String get searchFieldLabel => 'Cerca ordine, cliente, indirizzo o impianto';

  @override
  String get searchNoResultsTitle => 'Nessun risultato';

  @override
  String get searchNoResultsMessage => 'Inserire almeno due caratteri.';

  @override
  String get searchGroupOrders => 'Ordini';

  @override
  String get searchGroupCustomers => 'Clienti';

  @override
  String get searchGroupObjects => 'Oggetti';

  @override
  String get searchGroupInstallations => 'Impianti';

  @override
  String get retryAction => 'Riprova';

  @override
  String get notFoundTitle => 'Pagina non trovata';

  @override
  String get backToDashboardAction => 'Vai alla dashboard';

  @override
  String get localRecordMissingMessage =>
      'Der lokale Datensatz ist nicht vorhanden.';

  @override
  String get localWorkOrderMissingMessage =>
      'Der lokale Auftrag ist nicht vorhanden.';

  @override
  String get workOrdersTitle => 'Aufträge';

  @override
  String get workOrdersLoadErrorTitle =>
      'Aufträge konnten nicht geladen werden';

  @override
  String get workOrdersSearchLabel => 'Aufträge suchen';

  @override
  String get workOrdersEmptyFilteredTitle => 'Keine passenden Aufträge';

  @override
  String get workOrdersEmptyFilteredMessage =>
      'Passe Suche oder Statusfilter an.';

  @override
  String get resetFilterAction => 'Filter zurücksetzen';

  @override
  String get allFilterLabel => 'Alle';

  @override
  String get locallyChangedStatus => 'Lokal geändert';

  @override
  String get completeOrderTooltip => 'Abschließen';

  @override
  String get workOrderDetailTitle => 'Auftragsdetail';

  @override
  String get workOrderLoadErrorTitle => 'Auftrag konnte nicht geladen werden';

  @override
  String get workOrderNotFoundTitle => 'Auftrag nicht gefunden';

  @override
  String get actualTimeLabel => 'Ist-Zeit';

  @override
  String get navigationOpenError => 'Navigation konnte nicht geöffnet werden.';

  @override
  String get callOpenError => 'Anruf konnte nicht gestartet werden.';

  @override
  String get navigationAction => 'Navigation';

  @override
  String get callAction => 'Anrufen';

  @override
  String get calendarShareAction => 'Calendario';

  @override
  String get calendarShareSuccessMessage =>
      'L\'evento di calendario e stato passato alla condivisione.';

  @override
  String get calendarShareCancelledMessage =>
      'Condivisione calendario annullata.';

  @override
  String calendarShareErrorMessage(String error) {
    return 'Impossibile condividere l\'evento di calendario: $error';
  }

  @override
  String get phoneLabel => 'Telefon';

  @override
  String get addressLabel => 'Adresse';

  @override
  String get customerTypeLabel => 'Typ';

  @override
  String get billingAddressLabel => 'Rechnungsadresse';

  @override
  String get customerTitle => 'Kunde';

  @override
  String get customerOpenAction => 'Kunde öffnen';

  @override
  String get objectTitle => 'Objekt';

  @override
  String get objectOpenAction => 'Objekt öffnen';

  @override
  String get installationsTitle => 'Anlagen';

  @override
  String get noLinkedInstallations => 'Keine Anlagen verknüpft.';

  @override
  String get processingSectionTitle => 'Bearbeitung';

  @override
  String get checklistTitle => 'Checkliste';

  @override
  String get measurementsTitle => 'Messungen';

  @override
  String get defectsTitle => 'Mängel';

  @override
  String get photosTitle => 'Fotos';

  @override
  String get noPhotosTitle => 'Keine Fotos';

  @override
  String get timeEntriesTitle => 'Zeiten';

  @override
  String get materialTitle => 'Material';

  @override
  String get reportTitle => 'Rapport';

  @override
  String get signatureTitle => 'Unterschrift';

  @override
  String get completeWorkOrderTitle => 'Auftrag abschließen';

  @override
  String get completionLoadErrorTitle =>
      'Abschluss konnte nicht geladen werden';

  @override
  String get completionCheckTitle => 'Abschlussprüfung';

  @override
  String get readyStatus => 'Bereit';

  @override
  String get openStatus => 'Offen';

  @override
  String get completionReadyMessage =>
      'Alle lokalen Mindestdaten sind vorhanden.';

  @override
  String get saveLocallyCompleteAction => 'Lokal abschließen';

  @override
  String get reportsLoadErrorTitle => 'Rapporte konnten nicht geladen werden';

  @override
  String get localReportFilesTitle => 'Lokale Rapportdateien';

  @override
  String get pdfReportTitle => 'PDF-Bericht';

  @override
  String get pdfReportSourceMessage =>
      'Rapportdaten werden aus der lokalen Datenbank geladen.';

  @override
  String get pdfSignerLabel => 'Unterzeichner';

  @override
  String get pdfNoSignatureMessage => 'Keine Signatur gespeichert.';

  @override
  String get pdfNoEntriesMessage => 'Keine Einträge.';

  @override
  String get reportNoPdfTitle => 'Noch kein PDF erzeugt';

  @override
  String get reportNoPdfMessage => 'Der Rapport kann offline generiert werden.';

  @override
  String get reportSavePdfAction => 'PDF lokal speichern';

  @override
  String get reportPdfSavedMessage => 'PDF lokal gespeichert.';

  @override
  String get reportEmailShareAction => 'Invia rapporto via e-mail';

  @override
  String get reportEmailShareSuccessMessage =>
      'Il rapporto e stato passato alla condivisione.';

  @override
  String get reportEmailShareCancelledMessage => 'Condivisione annullata.';

  @override
  String reportEmailShareErrorMessage(String error) {
    return 'Impossibile condividere il rapporto: $error';
  }

  @override
  String get invoiceExportAction => 'Esporta bozza fattura';

  @override
  String get invoiceExportSuccessMessage =>
      'La bozza fattura e stata passata alla condivisione.';

  @override
  String get invoiceExportCancelledMessage => 'Esportazione fattura annullata.';

  @override
  String invoiceExportErrorMessage(String error) {
    return 'Impossibile esportare la bozza fattura: $error';
  }

  @override
  String reportEmailSubject(String orderNumber, String customerName) {
    return 'Rapporto $orderNumber - $customerName';
  }

  @override
  String reportEmailBody(String customerName, String orderNumber) {
    return 'Buongiorno\n\nIn allegato trova il rapporto $orderNumber per $customerName.\n\nCordiali saluti';
  }

  @override
  String get reportPreviewErrorTitle => 'Vorschau konnte nicht erstellt werden';

  @override
  String get reportNoPreviewTitle => 'Keine Vorschau';

  @override
  String get reportNoPreviewMessage => 'Der Auftrag ist lokal nicht vorhanden.';

  @override
  String get measurementsUnavailableTitle => 'Keine Messungen möglich';

  @override
  String get measurementsLoadErrorTitle =>
      'Messungen konnten nicht geladen werden';

  @override
  String get measurementsEmptyTitle => 'Keine Messwerte erfasst';

  @override
  String get measurementsEmptyMessage =>
      'Neue Messwerte werden lokal gespeichert.';

  @override
  String get recordedMeasurementsTitle => 'Erfasste Messungen';

  @override
  String get measurementTypeLabel => 'Messart';

  @override
  String get noInstallationOption => 'Keine Anlage';

  @override
  String get installationFieldLabel => 'Anlage';

  @override
  String get valueFieldLabel => 'Wert';

  @override
  String get unitFieldLabel => 'Einheit';

  @override
  String get notesFieldLabel => 'Notizen';

  @override
  String get notesSectionTitle => 'Notizen';

  @override
  String get saveMeasurementAction => 'Messwert speichern';

  @override
  String get bluetoothMeasurementTitle => 'Bluetooth-Messgerät';

  @override
  String get bluetoothMeasurementSubtitle =>
      'BLE-Messgeräte scannen, verbinden und Messwerte direkt lokal übernehmen.';

  @override
  String get startBluetoothScanAction => 'Scan starten';

  @override
  String get stopBluetoothScanAction => 'Scan stoppen';

  @override
  String get bluetoothDevicesEmptyMessage => 'Noch kein Messgerät gefunden.';

  @override
  String get bluetoothDeviceConnectingStatus => 'Verbinden...';

  @override
  String get bluetoothReadingSaveAction => 'Messwert übernehmen';

  @override
  String get bluetoothReadingSavedMessage =>
      'Bluetooth-Messwert lokal gespeichert.';

  @override
  String get measurementDeviceLabel => 'Gerät';

  @override
  String get photosLoadErrorTitle => 'Fotos konnten nicht geladen werden';

  @override
  String get photosEmptyTitle => 'Keine Fotos gespeichert';

  @override
  String get photosEmptyMessage =>
      'Fotos werden lokal im App-Verzeichnis abgelegt.';

  @override
  String get photoAddTitle => 'Foto hinzufügen';

  @override
  String get cameraAction => 'Kamera';

  @override
  String get galleryAction => 'Galerie';

  @override
  String get photoSavedMessage => 'Foto lokal gespeichert.';

  @override
  String get photoTitle => 'Foto';

  @override
  String get photoLoadErrorTitle => 'Foto konnte nicht geladen werden';

  @override
  String get photoNotFoundTitle => 'Foto nicht gefunden';

  @override
  String get photoMetadataMissingMessage =>
      'Die lokale Fotometadatei ist nicht vorhanden.';

  @override
  String get photoCaptionLabel => 'Bildnotiz';

  @override
  String get savePhotoCaptionAction => 'Bildnotiz speichern';

  @override
  String get photoCaptionSavedMessage => 'Bildnotiz lokal gespeichert.';

  @override
  String get uploadPendingStatus => 'Upload offen';

  @override
  String get uploadedStatus => 'Uploaded';

  @override
  String get defectAssignedStatus => 'Mangel zugeordnet';

  @override
  String get objectLoadErrorTitle => 'Objekt konnte nicht geladen werden';

  @override
  String get objectNotFoundTitle => 'Objekt nicht gefunden';

  @override
  String get accessNotesLabel => 'Zugang';

  @override
  String get safetyNotesLabel => 'Sicherheit';

  @override
  String get objectNotesLabel => 'Notizen zum Objekt';

  @override
  String get saveNotesAction => 'Notizen speichern';

  @override
  String get objectNotesSavedMessage => 'Objektnotizen lokal gespeichert.';

  @override
  String get objectHistoryTitle => 'Objekthistorie';

  @override
  String get objectNotesTitle => 'Objektnotizen';

  @override
  String get installationListSearchLabel => 'Anlage suchen';

  @override
  String get installationScanTooltip => 'Scansiona QR/codice a barre';

  @override
  String get installationScanTitle => 'Scansiona impianto';

  @override
  String get installationScanManualLabel => 'ID impianto o numero di serie';

  @override
  String get installationScanManualAction => 'Cerca codice';

  @override
  String installationScanNoMatchMessage(String code) {
    return 'Nessun impianto locale trovato per \"$code\".';
  }

  @override
  String get installationScanCameraError =>
      'Impossibile avviare la fotocamera. Inserisci manualmente l\'ID impianto o il numero di serie.';

  @override
  String get installationsLoadErrorTitle =>
      'Anlagen konnten nicht geladen werden';

  @override
  String get installationsEmptyTitle => 'Keine Anlagen';

  @override
  String get installationsEmptyMessage =>
      'Die Anlagen werden aus der lokalen DB geladen.';

  @override
  String get installationTitle => 'Anlage';

  @override
  String get installationLoadErrorTitle => 'Anlage konnte nicht geladen werden';

  @override
  String get installationNotFoundTitle => 'Anlage nicht gefunden';

  @override
  String get typeLabel => 'Typ';

  @override
  String get fuelTypeLabel => 'Brennstoff';

  @override
  String get locationLabel => 'Standort';

  @override
  String get serialNumberLabel => 'Seriennummer';

  @override
  String get lastServiceLabel => 'Letzte Arbeit';

  @override
  String get nextServiceLabel => 'Nächste Arbeit';

  @override
  String get installationNotesLabel => 'Notizen zur Anlage';

  @override
  String get installationNotesTitle => 'Anlagennotizen';

  @override
  String get installationNotesSavedMessage =>
      'Anlagennotizen lokal gespeichert.';

  @override
  String get installationPhotosTitle => 'Fotos zur Anlage';

  @override
  String get installationPhotosEmptyTitle => 'Keine Anlagenfotos';

  @override
  String get installationHistoryTitle => 'Anlagenhistorie';

  @override
  String get loginTitle => 'Anmeldung';

  @override
  String get loginAccessTitle => 'Technikerzugang';

  @override
  String get loginAccessMessage =>
      'Lokale Sitzungen bleiben später auch ohne Verbindung nutzbar.';

  @override
  String get emailFieldLabel => 'E-Mail';

  @override
  String get passwordFieldLabel => 'Passwort';

  @override
  String get openDemoSessionAction => 'Demo-Sitzung öffnen';

  @override
  String get continueOfflineAction => 'Offline fortfahren';

  @override
  String get syncStatusLoadErrorTitle =>
      'Sync-Status konnte nicht geladen werden';

  @override
  String get syncEntriesEmptyTitle => 'Keine offenen Sync-Einträge';

  @override
  String get syncEntriesEmptyMessage => 'Lokale Änderungen sind abgearbeitet.';

  @override
  String get signerNameLabel => 'Name Unterzeichner';

  @override
  String get clearAction => 'Leeren';

  @override
  String get undoAction => 'Undo';

  @override
  String get saveSignatureAction => 'Signatur speichern';

  @override
  String get timeEntriesLoadErrorTitle => 'Zeiten konnten nicht geladen werden';

  @override
  String get timeEntriesEmptyTitle => 'Keine Zeiten erfasst';

  @override
  String get timeEntriesEmptyMessage =>
      'Start/Stop-Zeiten werden lokal gespeichert.';

  @override
  String get timeEntryTypeLabel => 'Zeittyp';

  @override
  String get durationMinutesLabel => 'Dauer in Minuten';

  @override
  String get saveTimeEntryAction => 'Zeit speichern';

  @override
  String get goToLoginAction => 'Zur Anmeldung';

  @override
  String get defectsUnavailableTitle => 'Keine Mängel möglich';

  @override
  String get defectsLoadErrorTitle => 'Mängel konnten nicht geladen werden';

  @override
  String get defectsEmptyTitle => 'Keine Mängel erfasst';

  @override
  String get defectsEmptyMessage => 'Neue Mängel werden lokal gespeichert.';

  @override
  String get recordedDefectsTitle => 'Erfasste Mängel';

  @override
  String get defectAddTitle => 'Mangel erfassen';

  @override
  String get severityLabel => 'Schweregrad';

  @override
  String get titleFieldLabel => 'Titel';

  @override
  String get descriptionFieldLabel => 'Beschreibung';

  @override
  String get recommendedActionLabel => 'Empfohlene Massnahme';

  @override
  String get saveDefectAction => 'Mangel speichern';

  @override
  String get measureLabel => 'Massnahme';

  @override
  String get assignPhotoAction => 'Foto zuordnen';

  @override
  String get resolveAction => 'Erledigen';

  @override
  String get resolvedStatus => 'Erledigt';

  @override
  String get noPhotosInOrderMessage => 'Noch keine Fotos im Auftrag.';

  @override
  String get materialLoadErrorTitle => 'Material konnte nicht geladen werden';

  @override
  String get materialCatalogLoadErrorTitle =>
      'Materialstamm konnte nicht geladen werden';

  @override
  String get materialEmptyTitle => 'Kein Material erfasst';

  @override
  String get materialEmptyMessage =>
      'Verbrauch wird lokal am Auftrag gespeichert.';

  @override
  String get materialAddTitle => 'Material erfassen';

  @override
  String get freeTextOption => 'Freitext';

  @override
  String get materialCatalogFieldLabel => 'Materialstamm';

  @override
  String get materialStockSectionTitle => 'Lagerbestand';

  @override
  String materialStockAvailable(Object quantity, Object unit) {
    return 'Bestand: $quantity $unit';
  }

  @override
  String materialStockMinimum(Object quantity, Object unit) {
    return 'Minimum: $quantity $unit';
  }

  @override
  String get materialLowStockLabel => 'Knapp';

  @override
  String get materialSufficientStockLabel => 'OK';

  @override
  String get nameFieldLabel => 'Bezeichnung';

  @override
  String get quantityFieldLabel => 'Menge';

  @override
  String get saveMaterialAction => 'Material speichern';

  @override
  String get profileTitle => 'Profil';

  @override
  String get storageTitle => 'Speicher';

  @override
  String get appVersionTitle => 'App-Version';

  @override
  String get calculatingStatus => 'wird berechnet';

  @override
  String get demoTechnician => 'Demo-Techniker';

  @override
  String get openSyncStatusAction => 'Sync-Status öffnen';

  @override
  String get createDebugExportAction => 'Debug Export erstellen';

  @override
  String get logoutAction => 'Logout';

  @override
  String debugExportMessage(String path) {
    return 'Debug Export: $path';
  }

  @override
  String get profileLoadErrorTitle => 'Profil konnte nicht geladen werden';

  @override
  String get profileUnavailableTitle => 'Profil nicht verfügbar';

  @override
  String get profileUnavailableMessage => 'Die lokalen Stammdaten fehlen.';

  @override
  String get roleLabel => 'Rolle';

  @override
  String get cityLabel => 'Ort';

  @override
  String get countryLabel => 'Land';

  @override
  String get customersTitle => 'Kunden';

  @override
  String get customersLoadErrorTitle => 'Kunden konnten nicht geladen werden';

  @override
  String get customersEmptyTitle => 'Keine Kunden';

  @override
  String get customersEmptyMessage =>
      'Kundendaten werden nach dem Sync lokal sichtbar.';

  @override
  String get customerLoadErrorTitle => 'Kunde konnte nicht geladen werden';

  @override
  String get customerNotFoundTitle => 'Kunde nicht gefunden';

  @override
  String get customerNotesLabel => 'Kundennotizen';

  @override
  String get customerNotesSavedMessage => 'Kundennotizen lokal gespeichert.';

  @override
  String get objectsTitle => 'Objekte';

  @override
  String get objectsEmptyTitle => 'Keine Objekte';

  @override
  String get orderHistoryTitle => 'Auftragshistorie';

  @override
  String get historyTotalMetricLabel => 'Totale';

  @override
  String get historyCompletedMetricLabel => 'Completati';

  @override
  String get historyOpenMetricLabel => 'Aperti';

  @override
  String get historyOverdueMetricLabel => 'In ritardo';

  @override
  String get historyLocalMetricLabel => 'Locale';

  @override
  String get historyLastCompletedLabel => 'Ultima chiusura';

  @override
  String get historyNextScheduledLabel => 'Prossimo appuntamento';

  @override
  String get historyNoCompletedOrders => 'nessuna chiusura';

  @override
  String get historyNoUpcomingOrders => 'nessun appuntamento aperto';

  @override
  String get previousOrdersEmptyTitle => 'Keine früheren Aufträge';

  @override
  String get ordersEmptyTitle => 'Keine Aufträge';

  @override
  String get checklistLoadErrorTitle =>
      'Checkliste konnte nicht geladen werden';

  @override
  String get checklistUnavailableTitle => 'Keine Checkliste verfügbar';

  @override
  String get checklistTemplateMissingTitle => 'Keine Vorlage gefunden';

  @override
  String get checklistMissingTemplateMessage =>
      'Für diesen Auftragstyp existiert lokal keine aktive Vorlage.';

  @override
  String get commentFieldLabel => 'Kommentar';

  @override
  String get yesOption => 'Ja';

  @override
  String get noOption => 'Nein';

  @override
  String get answerFieldLabel => 'Antwort';

  @override
  String get numberFieldLabel => 'Zahl';

  @override
  String get selectionFieldLabel => 'Auswahl';

  @override
  String get photoRequiredRecordedTitle => 'Fotopflicht notiert';

  @override
  String get unknownAnswerTypeMessage => 'Unbekannter Antworttyp.';

  @override
  String get locallySavedStatus => 'Lokal gespeichert';

  @override
  String get initialSyncTitle => 'Initialer Sync';

  @override
  String get initialSyncReadyLabel => 'Bereit';

  @override
  String get initialSyncLoadTitle => 'Arbeitsdaten laden';

  @override
  String get initialSyncLoadMinimalAction => 'Minimaldaten laden';

  @override
  String get initialSyncOpenDatabaseStep => 'Lokale Datenbank öffnen';

  @override
  String get initialSyncProfileStep => 'Benutzerprofil prüfen';

  @override
  String get initialSyncOrdersStep => 'Aufträge und Kunden bereitstellen';

  @override
  String get initialSyncObjectsStep => 'Objekte und Anlagen bereitstellen';

  @override
  String get initialSyncChecklistStep =>
      'Checklisten und Materialstamm bereitstellen';

  @override
  String get initialSyncFailedLabel => 'Initialer Sync fehlgeschlagen';

  @override
  String get customerSignatureTitle => 'Kundenunterschrift';

  @override
  String get timeEntryAddTitle => 'Zeit erfassen';

  @override
  String get durationPositiveError => 'Dauer muss groesser als 0 sein.';

  @override
  String get splashTagline =>
      'Einsätze, Rapporte und lokale Arbeitsdaten für den Feldalltag.';
}

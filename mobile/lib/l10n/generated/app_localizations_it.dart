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
  String get pauseOrderAction => 'Metti in pausa';

  @override
  String get resumeOrderAction => 'Riprendi';

  @override
  String get allOrdersTooltip => 'Tutti gli ordini';

  @override
  String get syncStatusTitle => 'Stato sync';

  @override
  String get syncNowTooltip => 'Sincronizza ora';

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
  String get languageTitle => 'Lingua';

  @override
  String get languageSystemOption => 'Sistema';

  @override
  String get languageGermanOption => 'Deutsch';

  @override
  String get languageFrenchOption => 'Français';

  @override
  String get languageItalianOption => 'Italiano';

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
  String get localRecordMissingMessage => 'Il record locale non e disponibile.';

  @override
  String get localWorkOrderMissingMessage =>
      'L\'ordine locale non e disponibile.';

  @override
  String get workOrdersTitle => 'Ordini';

  @override
  String get workOrdersLoadErrorTitle =>
      'Non e stato possibile caricare gli ordini';

  @override
  String get workOrdersSearchLabel => 'Cerca ordini';

  @override
  String get workOrdersEmptyFilteredTitle => 'Nessun ordine corrispondente';

  @override
  String get workOrdersEmptyFilteredMessage =>
      'Adatta la ricerca o il filtro di stato.';

  @override
  String get resetFilterAction => 'Reimposta filtro';

  @override
  String get allFilterLabel => 'Tutti';

  @override
  String get locallyChangedStatus => 'Modificato localmente';

  @override
  String get completeOrderTooltip => 'Chiudi';

  @override
  String get workOrderDetailTitle => 'Dettaglio ordine';

  @override
  String get workOrderLoadErrorTitle =>
      'Non e stato possibile caricare l\'ordine';

  @override
  String get workOrderNotFoundTitle => 'Ordine non trovato';

  @override
  String get actualTimeLabel => 'Tempo effettivo';

  @override
  String get navigationOpenError => 'Impossibile aprire la navigazione.';

  @override
  String get callOpenError => 'Impossibile avviare la chiamata.';

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
  String get phoneLabel => 'Telefono';

  @override
  String get addressLabel => 'Indirizzo';

  @override
  String get customerTypeLabel => 'Tipo';

  @override
  String get billingAddressLabel => 'Indirizzo di fatturazione';

  @override
  String get customerTitle => 'Cliente';

  @override
  String get customerOpenAction => 'Apri cliente';

  @override
  String get objectTitle => 'Oggetto';

  @override
  String get objectOpenAction => 'Apri oggetto';

  @override
  String get installationsTitle => 'Impianti';

  @override
  String get noLinkedInstallations => 'Nessun impianto collegato.';

  @override
  String get processingSectionTitle => 'Lavorazione';

  @override
  String get checklistTitle => 'Checkliste';

  @override
  String get measurementsTitle => 'Misurazioni';

  @override
  String get defectsTitle => 'Difetti';

  @override
  String get photosTitle => 'Fotos';

  @override
  String get noPhotosTitle => 'Nessuna foto';

  @override
  String get timeEntriesTitle => 'Tempi';

  @override
  String get materialTitle => 'Material';

  @override
  String get reportTitle => 'Rapport';

  @override
  String get signatureTitle => 'Firma';

  @override
  String get completeWorkOrderTitle => 'Chiudi ordine';

  @override
  String get completionLoadErrorTitle =>
      'Non e stato possibile caricare la chiusura';

  @override
  String get completionCheckTitle => 'Controllo finale';

  @override
  String get readyStatus => 'Pronto';

  @override
  String get openStatus => 'Offen';

  @override
  String get completionReadyMessage =>
      'Tutti i dati minimi locali sono disponibili.';

  @override
  String get saveLocallyCompleteAction => 'Chiudi localmente';

  @override
  String get reportsLoadErrorTitle =>
      'Non e stato possibile caricare i rapporti';

  @override
  String get localReportFilesTitle => 'File rapporto locali';

  @override
  String get pdfReportTitle => 'Rapporto PDF';

  @override
  String get pdfReportSourceMessage =>
      'I dati del rapporto vengono caricati dal database locale.';

  @override
  String get pdfSignerLabel => 'Firmatario';

  @override
  String get pdfNoSignatureMessage => 'Nessuna firma salvata.';

  @override
  String get pdfNoEntriesMessage => 'Nessuna voce.';

  @override
  String get reportNoPdfTitle => 'Nessun PDF creato';

  @override
  String get reportNoPdfMessage => 'Il rapporto puo essere generato offline.';

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
  String get reportPreviewErrorTitle => 'Impossibile creare l\'anteprima';

  @override
  String get reportNoPreviewTitle => 'Nessuna anteprima';

  @override
  String get reportNoPreviewMessage =>
      'L\'ordine non e disponibile localmente.';

  @override
  String get measurementsUnavailableTitle => 'Misurazioni non possibili';

  @override
  String get measurementsLoadErrorTitle =>
      'Non e stato possibile caricare le misurazioni';

  @override
  String get measurementsEmptyTitle => 'Nessuna misurazione registrata';

  @override
  String get measurementsEmptyMessage =>
      'Le nuove misurazioni vengono salvate localmente.';

  @override
  String get recordedMeasurementsTitle => 'Misurazioni registrate';

  @override
  String get measurementTypeLabel => 'Tipo di misurazione';

  @override
  String get noInstallationOption => 'Nessun impianto';

  @override
  String get installationFieldLabel => 'Impianto';

  @override
  String get valueFieldLabel => 'Valore';

  @override
  String get unitFieldLabel => 'Unita';

  @override
  String get notesFieldLabel => 'Note';

  @override
  String get notesSectionTitle => 'Note';

  @override
  String get saveMeasurementAction => 'Salva misurazione';

  @override
  String get bluetoothMeasurementTitle => 'Misuratore Bluetooth';

  @override
  String get bluetoothMeasurementSubtitle =>
      'Scansiona e collega dispositivi BLE per salvare direttamente le misurazioni locali.';

  @override
  String get startBluetoothScanAction => 'Avvia scansione';

  @override
  String get stopBluetoothScanAction => 'Ferma scansione';

  @override
  String get bluetoothDevicesEmptyMessage => 'Nessun misuratore trovato.';

  @override
  String get bluetoothDeviceConnectingStatus => 'Connessione...';

  @override
  String get bluetoothReadingSaveAction => 'Acquisisci misurazione';

  @override
  String get bluetoothReadingSavedMessage =>
      'Misurazione Bluetooth salvata localmente.';

  @override
  String get measurementDeviceLabel => 'Dispositivo';

  @override
  String get photosLoadErrorTitle => 'Non e stato possibile caricare le foto';

  @override
  String get photosEmptyTitle => 'Nessuna foto salvata';

  @override
  String get photosEmptyMessage =>
      'Le foto vengono salvate localmente nella cartella dell\'app.';

  @override
  String get photoAddTitle => 'Aggiungi foto';

  @override
  String get cameraAction => 'Fotocamera';

  @override
  String get galleryAction => 'Galleria';

  @override
  String get photoSavedMessage => 'Foto salvata localmente.';

  @override
  String get photoTitle => 'Foto';

  @override
  String get photoLoadErrorTitle => 'Foto konnte nicht geladen werden';

  @override
  String get photoNotFoundTitle => 'Foto nicht gefunden';

  @override
  String get photoMetadataMissingMessage =>
      'I metadati locali della foto non sono disponibili.';

  @override
  String get photoCaptionLabel => 'Nota foto';

  @override
  String get savePhotoCaptionAction => 'Salva nota foto';

  @override
  String get photoCaptionSavedMessage => 'Nota foto salvata localmente.';

  @override
  String get uploadPendingStatus => 'Upload offen';

  @override
  String get uploadedStatus => 'Uploaded';

  @override
  String get defectAssignedStatus => 'Difetto assegnato';

  @override
  String get objectLoadErrorTitle =>
      'Non e stato possibile caricare l\'oggetto';

  @override
  String get objectNotFoundTitle => 'Oggetto non trovato';

  @override
  String get accessNotesLabel => 'Accesso';

  @override
  String get safetyNotesLabel => 'Sicurezza';

  @override
  String get objectNotesLabel => 'Note sull\'oggetto';

  @override
  String get saveNotesAction => 'Salva note';

  @override
  String get objectNotesSavedMessage => 'Note oggetto salvate localmente.';

  @override
  String get objectHistoryTitle => 'Storico oggetto';

  @override
  String get objectNotesTitle => 'Note oggetto';

  @override
  String get installationListSearchLabel => 'Cerca impianto';

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
      'Non e stato possibile caricare gli impianti';

  @override
  String get installationsEmptyTitle => 'Nessun impianto';

  @override
  String get installationsEmptyMessage =>
      'Gli impianti vengono caricati dal database locale.';

  @override
  String get installationTitle => 'Impianto';

  @override
  String get installationLoadErrorTitle =>
      'Non e stato possibile caricare l\'impianto';

  @override
  String get installationNotFoundTitle => 'Impianto non trovato';

  @override
  String get typeLabel => 'Tipo';

  @override
  String get fuelTypeLabel => 'Combustibile';

  @override
  String get locationLabel => 'Posizione';

  @override
  String get serialNumberLabel => 'Numero di serie';

  @override
  String get lastServiceLabel => 'Ultimo intervento';

  @override
  String get nextServiceLabel => 'Prossimo intervento';

  @override
  String get installationNotesLabel => 'Note sull\'impianto';

  @override
  String get installationNotesTitle => 'Note impianto';

  @override
  String get installationNotesSavedMessage =>
      'Note impianto salvate localmente.';

  @override
  String get installationPhotosTitle => 'Foto dell\'impianto';

  @override
  String get installationPhotosEmptyTitle => 'Nessuna foto impianto';

  @override
  String get installationHistoryTitle => 'Storico impianto';

  @override
  String get loginTitle => 'Accesso';

  @override
  String get loginAccessTitle => 'Accesso tecnico';

  @override
  String get loginAccessMessage =>
      'Le sessioni locali resteranno utilizzabili anche senza connessione.';

  @override
  String get emailFieldLabel => 'E-Mail';

  @override
  String get passwordFieldLabel => 'Passwort';

  @override
  String get openDemoSessionAction => 'Apri sessione demo';

  @override
  String get continueOfflineAction => 'Continua offline';

  @override
  String get syncStatusLoadErrorTitle =>
      'Non e stato possibile caricare lo stato sync';

  @override
  String get syncEntriesEmptyTitle => 'Nessuna voce sync aperta';

  @override
  String get syncEntriesEmptyMessage => 'Le modifiche locali sono completate.';

  @override
  String get signerNameLabel => 'Nome firmatario';

  @override
  String get clearAction => 'Cancella';

  @override
  String get undoAction => 'Annulla';

  @override
  String get saveSignatureAction => 'Salva firma';

  @override
  String get timeEntriesLoadErrorTitle =>
      'Non e stato possibile caricare i tempi';

  @override
  String get timeEntriesEmptyTitle => 'Nessun tempo registrato';

  @override
  String get timeEntriesEmptyMessage =>
      'I tempi start/stop vengono salvati localmente.';

  @override
  String get timeEntryTypeLabel => 'Tipo di tempo';

  @override
  String get durationMinutesLabel => 'Durata in minuti';

  @override
  String get saveTimeEntryAction => 'Salva tempo';

  @override
  String get goToLoginAction => 'Vai all\'accesso';

  @override
  String get defectsUnavailableTitle => 'Difetti non possibili';

  @override
  String get defectsLoadErrorTitle =>
      'Non e stato possibile caricare i difetti';

  @override
  String get defectsEmptyTitle => 'Nessun difetto registrato';

  @override
  String get defectsEmptyMessage =>
      'I nuovi difetti vengono salvati localmente.';

  @override
  String get recordedDefectsTitle => 'Difetti registrati';

  @override
  String get defectAddTitle => 'Registra difetto';

  @override
  String get severityLabel => 'Gravita';

  @override
  String get titleFieldLabel => 'Titolo';

  @override
  String get descriptionFieldLabel => 'Descrizione';

  @override
  String get recommendedActionLabel => 'Azione consigliata';

  @override
  String get saveDefectAction => 'Salva difetto';

  @override
  String get measureLabel => 'Azione';

  @override
  String get assignPhotoAction => 'Assegna foto';

  @override
  String get resolveAction => 'Completa';

  @override
  String get resolvedStatus => 'Completato';

  @override
  String get noPhotosInOrderMessage => 'Nessuna foto nell\'ordine.';

  @override
  String get materialLoadErrorTitle =>
      'Non e stato possibile caricare il materiale';

  @override
  String get materialCatalogLoadErrorTitle =>
      'Non e stato possibile caricare il catalogo materiali';

  @override
  String get materialEmptyTitle => 'Nessun materiale registrato';

  @override
  String get materialEmptyMessage =>
      'Il consumo viene salvato localmente sull\'ordine.';

  @override
  String get materialAddTitle => 'Registra materiale';

  @override
  String get freeTextOption => 'Testo libero';

  @override
  String get materialCatalogFieldLabel => 'Catalogo materiali';

  @override
  String get materialStockSectionTitle => 'Giacenza';

  @override
  String materialStockAvailable(Object quantity, Object unit) {
    return 'Giacenza: $quantity $unit';
  }

  @override
  String materialStockMinimum(Object quantity, Object unit) {
    return 'Minimum: $quantity $unit';
  }

  @override
  String get materialLowStockLabel => 'Scarso';

  @override
  String get materialSufficientStockLabel => 'OK';

  @override
  String get nameFieldLabel => 'Descrizione';

  @override
  String get quantityFieldLabel => 'Quantita';

  @override
  String get saveMaterialAction => 'Salva materiale';

  @override
  String get profileTitle => 'Profil';

  @override
  String get storageTitle => 'Memoria';

  @override
  String get appVersionTitle => 'App-Version';

  @override
  String get calculatingStatus => 'calcolo in corso';

  @override
  String get demoTechnician => 'Tecnico demo';

  @override
  String get openSyncStatusAction => 'Apri stato sync';

  @override
  String get createDebugExportAction => 'Crea export debug';

  @override
  String get logoutAction => 'Logout';

  @override
  String debugExportMessage(String path) {
    return 'Debug Export: $path';
  }

  @override
  String get profileLoadErrorTitle =>
      'Non e stato possibile caricare il profilo';

  @override
  String get profileUnavailableTitle => 'Profilo non disponibile';

  @override
  String get profileUnavailableMessage => 'I dati locali di base mancano.';

  @override
  String get roleLabel => 'Ruolo';

  @override
  String get cityLabel => 'Localita';

  @override
  String get countryLabel => 'Paese';

  @override
  String get customersTitle => 'Clienti';

  @override
  String get customersLoadErrorTitle =>
      'Non e stato possibile caricare i clienti';

  @override
  String get customersEmptyTitle => 'Nessun cliente';

  @override
  String get customersEmptyMessage =>
      'I clienti saranno disponibili localmente dopo il sync.';

  @override
  String get customerLoadErrorTitle =>
      'Non e stato possibile caricare il cliente';

  @override
  String get customerNotFoundTitle => 'Cliente non trovato';

  @override
  String get customerNotesLabel => 'Note cliente';

  @override
  String get customerNotesSavedMessage => 'Note cliente salvate localmente.';

  @override
  String get objectsTitle => 'Oggetti';

  @override
  String get objectsEmptyTitle => 'Nessun oggetto';

  @override
  String get orderHistoryTitle => 'Storico ordini';

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
  String get previousOrdersEmptyTitle => 'Nessun ordine precedente';

  @override
  String get ordersEmptyTitle => 'Nessun ordine';

  @override
  String get checklistLoadErrorTitle =>
      'Non e stato possibile caricare la checklist';

  @override
  String get checklistUnavailableTitle => 'Nessuna checklist disponibile';

  @override
  String get checklistTemplateMissingTitle => 'Nessun modello trovato';

  @override
  String get checklistMissingTemplateMessage =>
      'Per questo tipo di ordine non esiste un modello locale attivo.';

  @override
  String get commentFieldLabel => 'Commento';

  @override
  String get yesOption => 'Si';

  @override
  String get noOption => 'Nein';

  @override
  String get answerFieldLabel => 'Risposta';

  @override
  String get numberFieldLabel => 'Numero';

  @override
  String get selectionFieldLabel => 'Selezione';

  @override
  String get photoRequiredRecordedTitle => 'Obbligo foto annotato';

  @override
  String get unknownAnswerTypeMessage => 'Tipo di risposta sconosciuto.';

  @override
  String get locallySavedStatus => 'Salvato localmente';

  @override
  String get initialSyncTitle => 'Sync iniziale';

  @override
  String get initialSyncReadyLabel => 'Pronto';

  @override
  String get initialSyncLoadTitle => 'Carica dati di lavoro';

  @override
  String get initialSyncLoadMinimalAction => 'Carica dati minimi';

  @override
  String get initialSyncOpenDatabaseStep => 'Aprire database locale';

  @override
  String get initialSyncProfileStep => 'Verificare profilo utente';

  @override
  String get initialSyncOrdersStep => 'Preparare ordini e clienti';

  @override
  String get initialSyncObjectsStep => 'Preparare oggetti e impianti';

  @override
  String get initialSyncChecklistStep => 'Preparare checklist e materiali';

  @override
  String get initialSyncFailedLabel => 'Sync iniziale fallito';

  @override
  String get customerSignatureTitle => 'Firma cliente';

  @override
  String get timeEntryAddTitle => 'Registra tempo';

  @override
  String get durationPositiveError => 'La durata deve essere maggiore di 0.';

  @override
  String get splashTagline =>
      'Interventi, rapporti e dati locali per il lavoro sul campo.';
}

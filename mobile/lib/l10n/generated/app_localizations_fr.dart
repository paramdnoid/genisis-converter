// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Technicien ramoneur';

  @override
  String get dashboardTitle => 'Aujourd\'hui';

  @override
  String get syncActionTooltip => 'Synchroniser';

  @override
  String get dashboardLoadErrorTitle =>
      'Les ordres locaux n\'ont pas pu etre charges';

  @override
  String get dashboardEmptyTodayTitle => 'Aucun ordre pour aujourd\'hui';

  @override
  String get dashboardEmptyTodayMessage =>
      'Les nouvelles donnees seront disponibles localement apres la prochaine synchronisation.';

  @override
  String get dashboardOpenAllOrders => 'Ouvrir tous les ordres';

  @override
  String get offlineReadyMessage =>
      'Pret hors ligne. Les donnees locales sont synchronisees.';

  @override
  String pendingLocalChangesMessage(int count) {
    return '$count modification(s) locale(s) en attente de synchronisation.';
  }

  @override
  String get ordersMetricLabel => 'Ordres';

  @override
  String get openSyncsMetricLabel => 'Syncs ouvertes';

  @override
  String get urgentMetricLabel => 'Urgent';

  @override
  String get nextOrderTitle => 'Prochain ordre';

  @override
  String get routeOptimizationTitle => 'Tournee du jour';

  @override
  String routeOptimizationReadyMessage(int count) {
    return '$count arret(s) du jour pret(s) pour la route.';
  }

  @override
  String get routeOptimizationCoordinateMode => 'Optimise par coordonnees';

  @override
  String get routeOptimizationScheduleMode => 'Ordre des rendez-vous';

  @override
  String get routeOptimizationNoStopsMessage =>
      'Aucun arret du jour avec adresse disponible.';

  @override
  String get routeOptimizationOpenAction => 'Ouvrir la route optimisee';

  @override
  String get routeOptimizationOpenError =>
      'La route optimisee n\'a pas pu etre ouverte.';

  @override
  String get offlineRouteMapTitle => 'Carte hors ligne';

  @override
  String get offlineRouteMapAction => 'Carte hors ligne';

  @override
  String offlineRouteMapSubtitle(int count) {
    return '$count arret(s) dessine(s) localement a partir des coordonnees.';
  }

  @override
  String get offlineRouteMapEmptyTitle => 'Aucune route hors ligne';

  @override
  String get offlineRouteMapNoCoordinatesTitle => 'Aucune coordonnee';

  @override
  String get offlineRouteMapNoCoordinatesMessage =>
      'La carte locale necessite au moins un arret du jour avec des coordonnees enregistrees.';

  @override
  String get offlineRouteMapStopsTitle => 'Arrets';

  @override
  String get offlineRouteMapUnmappedTitle => 'Sans coordonnees';

  @override
  String get recurringWorkOrdersTitle => 'Ordres recurrents';

  @override
  String recurringWorkOrdersDueCount(int count) {
    return '$count echu(s)';
  }

  @override
  String recurringWorkOrdersReadyMessage(int count) {
    return '$count installation(s) sont echues pour un nouvel ordre.';
  }

  @override
  String get recurringWorkOrdersEmptyMessage => 'Aucun ordre recurrent echu.';

  @override
  String get recurringWorkOrdersCreateAction => 'Creer les ordres echus';

  @override
  String recurringWorkOrdersCreatedMessage(int count) {
    return '$count ordre(s) recurrent(s) cree(s) localement.';
  }

  @override
  String recurringWorkOrdersErrorMessage(String error) {
    return 'Les ordres recurrents n\'ont pas pu etre crees: $error';
  }

  @override
  String get startOrderAction => 'Demarrer';

  @override
  String get pauseOrderAction => 'Pause';

  @override
  String get resumeOrderAction => 'Reprendre';

  @override
  String get allOrdersTooltip => 'Tous les ordres';

  @override
  String get syncStatusTitle => 'Statut de sync';

  @override
  String get syncNowTooltip => 'Synchroniser maintenant';

  @override
  String get syncStatusCleanMessage =>
      'Aucune modification locale dans l\'outbox.';

  @override
  String get syncStatusWaitingMessage =>
      'L\'outbox attend la prochaine connexion.';

  @override
  String get syncStatusSynchronized => 'Synchronise';

  @override
  String syncStatusOpenCount(int count) {
    return '$count ouvert(s)';
  }

  @override
  String get quickActionsTitle => 'Actions rapides';

  @override
  String get searchAction => 'Recherche';

  @override
  String get settingsTitle => 'Parametres';

  @override
  String get languageTitle => 'Langue';

  @override
  String get languageSystemOption => 'Systeme';

  @override
  String get languageGermanOption => 'Deutsch';

  @override
  String get languageFrenchOption => 'Français';

  @override
  String get languageItalianOption => 'Italiano';

  @override
  String get noAppointment => 'sans rendez-vous';

  @override
  String get noDate => 'sans date';

  @override
  String get searchTitle => 'Recherche';

  @override
  String get searchFieldLabel =>
      'Rechercher ordre, client, adresse ou installation';

  @override
  String get searchNoResultsTitle => 'Aucun resultat';

  @override
  String get searchNoResultsMessage => 'Saisir au moins deux caracteres.';

  @override
  String get searchGroupOrders => 'Ordres';

  @override
  String get searchGroupCustomers => 'Clients';

  @override
  String get searchGroupObjects => 'Objets';

  @override
  String get searchGroupInstallations => 'Installations';

  @override
  String get retryAction => 'Reessayer';

  @override
  String get notFoundTitle => 'Page introuvable';

  @override
  String get backToDashboardAction => 'Retour au tableau de bord';

  @override
  String get localRecordMissingMessage =>
      'L\'enregistrement local est introuvable.';

  @override
  String get localWorkOrderMissingMessage => 'L\'ordre local est introuvable.';

  @override
  String get workOrdersTitle => 'Ordres';

  @override
  String get workOrdersLoadErrorTitle =>
      'Les ordres n\'ont pas pu etre charges';

  @override
  String get workOrdersSearchLabel => 'Rechercher des ordres';

  @override
  String get workOrdersEmptyFilteredTitle => 'Aucun ordre correspondant';

  @override
  String get workOrdersEmptyFilteredMessage =>
      'Adapte la recherche ou le filtre de statut.';

  @override
  String get resetFilterAction => 'Reinitialiser le filtre';

  @override
  String get allFilterLabel => 'Tous';

  @override
  String get locallyChangedStatus => 'Modifie localement';

  @override
  String get completeOrderTooltip => 'Cloturer';

  @override
  String get workOrderDetailTitle => 'Detail de l\'ordre';

  @override
  String get workOrderLoadErrorTitle => 'L\'ordre n\'a pas pu etre charge';

  @override
  String get workOrderNotFoundTitle => 'Ordre introuvable';

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
  String get calendarShareAction => 'Calendrier';

  @override
  String get calendarShareSuccessMessage =>
      'L\'evenement de calendrier a ete transmis au partage.';

  @override
  String get calendarShareCancelledMessage =>
      'Le partage du calendrier a ete annule.';

  @override
  String calendarShareErrorMessage(String error) {
    return 'L\'evenement de calendrier n\'a pas pu etre partage: $error';
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
  String get installationsTitle => 'Installations';

  @override
  String get noLinkedInstallations => 'Aucune installation liee.';

  @override
  String get processingSectionTitle => 'Bearbeitung';

  @override
  String get checklistTitle => 'Checkliste';

  @override
  String get measurementsTitle => 'Messungen';

  @override
  String get defectsTitle => 'Defauts';

  @override
  String get photosTitle => 'Fotos';

  @override
  String get noPhotosTitle => 'Aucune photo';

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
  String get pdfNoSignatureMessage => 'Aucune signature enregistree.';

  @override
  String get pdfNoEntriesMessage => 'Aucune entree.';

  @override
  String get reportNoPdfTitle => 'Noch kein PDF erzeugt';

  @override
  String get reportNoPdfMessage => 'Der Rapport kann offline generiert werden.';

  @override
  String get reportSavePdfAction => 'PDF lokal speichern';

  @override
  String get reportPdfSavedMessage => 'PDF lokal gespeichert.';

  @override
  String get reportEmailShareAction => 'Envoyer le rapport par e-mail';

  @override
  String get reportEmailShareSuccessMessage =>
      'Le rapport a ete transmis au partage.';

  @override
  String get reportEmailShareCancelledMessage => 'Le partage a ete annule.';

  @override
  String reportEmailShareErrorMessage(String error) {
    return 'Le rapport n\'a pas pu etre partage: $error';
  }

  @override
  String get invoiceExportAction => 'Rechnungsentwurf exportieren';

  @override
  String get invoiceExportSuccessMessage =>
      'Rechnungsentwurf wurde an die Freigabe übergeben.';

  @override
  String get invoiceExportCancelledMessage =>
      'Rechnungsexport wurde abgebrochen.';

  @override
  String invoiceExportErrorMessage(String error) {
    return 'Rechnungsentwurf konnte nicht exportiert werden: $error';
  }

  @override
  String reportEmailSubject(String orderNumber, String customerName) {
    return 'Rapport $orderNumber - $customerName';
  }

  @override
  String reportEmailBody(String customerName, String orderNumber) {
    return 'Bonjour\n\nVous trouverez en piece jointe le rapport $orderNumber pour $customerName.\n\nMeilleures salutations';
  }

  @override
  String get reportPreviewErrorTitle => 'L\'apercu n\'a pas pu etre cree';

  @override
  String get reportNoPreviewTitle => 'Aucun apercu';

  @override
  String get reportNoPreviewMessage => 'L\'ordre n\'existe pas localement.';

  @override
  String get measurementsUnavailableTitle => 'Mesures impossibles';

  @override
  String get measurementsLoadErrorTitle =>
      'Les mesures n\'ont pas pu etre chargees';

  @override
  String get measurementsEmptyTitle => 'Aucune mesure saisie';

  @override
  String get measurementsEmptyMessage =>
      'Les nouvelles mesures sont enregistrees localement.';

  @override
  String get recordedMeasurementsTitle => 'Mesures saisies';

  @override
  String get measurementTypeLabel => 'Messart';

  @override
  String get noInstallationOption => 'Aucune installation';

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
  String get photosLoadErrorTitle => 'Les photos n\'ont pas pu etre chargees';

  @override
  String get photosEmptyTitle => 'Aucune photo enregistree';

  @override
  String get photosEmptyMessage =>
      'Les photos sont stockees localement dans le dossier de l\'app.';

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
      'Les metadonnees locales de la photo sont introuvables.';

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
  String get defectAssignedStatus => 'Defaut lie';

  @override
  String get objectLoadErrorTitle => 'L\'objet n\'a pas pu etre charge';

  @override
  String get objectNotFoundTitle => 'Objet introuvable';

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
  String get installationScanTooltip => 'Scanner QR/code-barres';

  @override
  String get installationScanTitle => 'Scanner l\'installation';

  @override
  String get installationScanManualLabel =>
      'ID installation ou numero de serie';

  @override
  String get installationScanManualAction => 'Rechercher le code';

  @override
  String installationScanNoMatchMessage(String code) {
    return 'Aucune installation locale trouvee pour \"$code\".';
  }

  @override
  String get installationScanCameraError =>
      'La camera n\'a pas pu demarrer. Saisis l\'ID de l\'installation ou le numero de serie manuellement.';

  @override
  String get installationsLoadErrorTitle =>
      'Les installations n\'ont pas pu etre chargees';

  @override
  String get installationsEmptyTitle => 'Aucune installation';

  @override
  String get installationsEmptyMessage =>
      'Les installations sont chargees depuis la base locale.';

  @override
  String get installationTitle => 'Installation';

  @override
  String get installationLoadErrorTitle =>
      'L\'installation n\'a pas pu etre chargee';

  @override
  String get installationNotFoundTitle => 'Installation introuvable';

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
  String get historyTotalMetricLabel => 'Total';

  @override
  String get historyCompletedMetricLabel => 'Termines';

  @override
  String get historyOpenMetricLabel => 'Ouverts';

  @override
  String get historyOverdueMetricLabel => 'En retard';

  @override
  String get historyLocalMetricLabel => 'Local';

  @override
  String get historyLastCompletedLabel => 'Derniere cloture';

  @override
  String get historyNextScheduledLabel => 'Prochain rendez-vous';

  @override
  String get historyNoCompletedOrders => 'aucune cloture';

  @override
  String get historyNoUpcomingOrders => 'aucun rendez-vous ouvert';

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

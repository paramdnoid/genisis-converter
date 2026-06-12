import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('fr'),
    Locale('it'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In de, this message translates to:
  /// **'Kaminfeger Techniker'**
  String get appTitle;

  /// No description provided for @dashboardTitle.
  ///
  /// In de, this message translates to:
  /// **'Heute'**
  String get dashboardTitle;

  /// No description provided for @syncActionTooltip.
  ///
  /// In de, this message translates to:
  /// **'Synchronisieren'**
  String get syncActionTooltip;

  /// No description provided for @dashboardLoadErrorTitle.
  ///
  /// In de, this message translates to:
  /// **'Lokale Aufträge konnten nicht geladen werden'**
  String get dashboardLoadErrorTitle;

  /// No description provided for @dashboardEmptyTodayTitle.
  ///
  /// In de, this message translates to:
  /// **'Keine Aufträge für heute'**
  String get dashboardEmptyTodayTitle;

  /// No description provided for @dashboardEmptyTodayMessage.
  ///
  /// In de, this message translates to:
  /// **'Neue Daten werden nach dem nächsten Sync lokal sichtbar.'**
  String get dashboardEmptyTodayMessage;

  /// No description provided for @dashboardOpenAllOrders.
  ///
  /// In de, this message translates to:
  /// **'Alle Aufträge öffnen'**
  String get dashboardOpenAllOrders;

  /// No description provided for @offlineReadyMessage.
  ///
  /// In de, this message translates to:
  /// **'Offline bereit. Lokale Daten sind synchron.'**
  String get offlineReadyMessage;

  /// No description provided for @pendingLocalChangesMessage.
  ///
  /// In de, this message translates to:
  /// **'{count} lokale Änderung(en) warten auf Sync.'**
  String pendingLocalChangesMessage(int count);

  /// No description provided for @ordersMetricLabel.
  ///
  /// In de, this message translates to:
  /// **'Aufträge'**
  String get ordersMetricLabel;

  /// No description provided for @openSyncsMetricLabel.
  ///
  /// In de, this message translates to:
  /// **'Offene Syncs'**
  String get openSyncsMetricLabel;

  /// No description provided for @urgentMetricLabel.
  ///
  /// In de, this message translates to:
  /// **'Dringend'**
  String get urgentMetricLabel;

  /// No description provided for @nextOrderTitle.
  ///
  /// In de, this message translates to:
  /// **'Nächster Auftrag'**
  String get nextOrderTitle;

  /// No description provided for @routeOptimizationTitle.
  ///
  /// In de, this message translates to:
  /// **'Tagesroute'**
  String get routeOptimizationTitle;

  /// No description provided for @routeOptimizationReadyMessage.
  ///
  /// In de, this message translates to:
  /// **'{count} Tagesstopp(s) für die Route bereit.'**
  String routeOptimizationReadyMessage(int count);

  /// No description provided for @routeOptimizationCoordinateMode.
  ///
  /// In de, this message translates to:
  /// **'Koordinatenoptimiert'**
  String get routeOptimizationCoordinateMode;

  /// No description provided for @routeOptimizationScheduleMode.
  ///
  /// In de, this message translates to:
  /// **'Terminreihenfolge'**
  String get routeOptimizationScheduleMode;

  /// No description provided for @routeOptimizationNoStopsMessage.
  ///
  /// In de, this message translates to:
  /// **'Keine Tagesstopps mit Adresse vorhanden.'**
  String get routeOptimizationNoStopsMessage;

  /// No description provided for @routeOptimizationOpenAction.
  ///
  /// In de, this message translates to:
  /// **'Optimierte Route öffnen'**
  String get routeOptimizationOpenAction;

  /// No description provided for @routeOptimizationOpenError.
  ///
  /// In de, this message translates to:
  /// **'Optimierte Route konnte nicht geöffnet werden.'**
  String get routeOptimizationOpenError;

  /// No description provided for @offlineRouteMapTitle.
  ///
  /// In de, this message translates to:
  /// **'Offline-Karte'**
  String get offlineRouteMapTitle;

  /// No description provided for @offlineRouteMapAction.
  ///
  /// In de, this message translates to:
  /// **'Offline-Karte'**
  String get offlineRouteMapAction;

  /// No description provided for @offlineRouteMapSubtitle.
  ///
  /// In de, this message translates to:
  /// **'{count} Stopp(s) lokal aus Koordinaten gezeichnet.'**
  String offlineRouteMapSubtitle(int count);

  /// No description provided for @offlineRouteMapEmptyTitle.
  ///
  /// In de, this message translates to:
  /// **'Keine Offline-Route'**
  String get offlineRouteMapEmptyTitle;

  /// No description provided for @offlineRouteMapNoCoordinatesTitle.
  ///
  /// In de, this message translates to:
  /// **'Keine Koordinaten'**
  String get offlineRouteMapNoCoordinatesTitle;

  /// No description provided for @offlineRouteMapNoCoordinatesMessage.
  ///
  /// In de, this message translates to:
  /// **'Für die lokale Karte braucht mindestens ein Tagesstopp gespeicherte Koordinaten.'**
  String get offlineRouteMapNoCoordinatesMessage;

  /// No description provided for @offlineRouteMapStopsTitle.
  ///
  /// In de, this message translates to:
  /// **'Stopps'**
  String get offlineRouteMapStopsTitle;

  /// No description provided for @offlineRouteMapUnmappedTitle.
  ///
  /// In de, this message translates to:
  /// **'Ohne Koordinaten'**
  String get offlineRouteMapUnmappedTitle;

  /// No description provided for @recurringWorkOrdersTitle.
  ///
  /// In de, this message translates to:
  /// **'Wiederkehrende Aufträge'**
  String get recurringWorkOrdersTitle;

  /// No description provided for @recurringWorkOrdersDueCount.
  ///
  /// In de, this message translates to:
  /// **'{count} fällig'**
  String recurringWorkOrdersDueCount(int count);

  /// No description provided for @recurringWorkOrdersReadyMessage.
  ///
  /// In de, this message translates to:
  /// **'{count} Anlage(n) sind für einen neuen Auftrag fällig.'**
  String recurringWorkOrdersReadyMessage(int count);

  /// No description provided for @recurringWorkOrdersEmptyMessage.
  ///
  /// In de, this message translates to:
  /// **'Keine fälligen Intervallaufträge.'**
  String get recurringWorkOrdersEmptyMessage;

  /// No description provided for @recurringWorkOrdersCreateAction.
  ///
  /// In de, this message translates to:
  /// **'Fällige Aufträge erstellen'**
  String get recurringWorkOrdersCreateAction;

  /// No description provided for @recurringWorkOrdersCreatedMessage.
  ///
  /// In de, this message translates to:
  /// **'{count} wiederkehrende Auftrag/Aufträge lokal erstellt.'**
  String recurringWorkOrdersCreatedMessage(int count);

  /// No description provided for @recurringWorkOrdersErrorMessage.
  ///
  /// In de, this message translates to:
  /// **'Wiederkehrende Aufträge konnten nicht erstellt werden: {error}'**
  String recurringWorkOrdersErrorMessage(String error);

  /// No description provided for @startOrderAction.
  ///
  /// In de, this message translates to:
  /// **'Starten'**
  String get startOrderAction;

  /// No description provided for @pauseOrderAction.
  ///
  /// In de, this message translates to:
  /// **'Pausieren'**
  String get pauseOrderAction;

  /// No description provided for @resumeOrderAction.
  ///
  /// In de, this message translates to:
  /// **'Fortsetzen'**
  String get resumeOrderAction;

  /// No description provided for @allOrdersTooltip.
  ///
  /// In de, this message translates to:
  /// **'Alle Aufträge'**
  String get allOrdersTooltip;

  /// No description provided for @syncStatusTitle.
  ///
  /// In de, this message translates to:
  /// **'Sync-Status'**
  String get syncStatusTitle;

  /// No description provided for @syncNowTooltip.
  ///
  /// In de, this message translates to:
  /// **'Jetzt synchronisieren'**
  String get syncNowTooltip;

  /// No description provided for @syncStatusCleanMessage.
  ///
  /// In de, this message translates to:
  /// **'Keine lokalen Änderungen in der Outbox.'**
  String get syncStatusCleanMessage;

  /// No description provided for @syncStatusWaitingMessage.
  ///
  /// In de, this message translates to:
  /// **'Outbox wartet auf die nächste Verbindung.'**
  String get syncStatusWaitingMessage;

  /// No description provided for @syncStatusSynchronized.
  ///
  /// In de, this message translates to:
  /// **'Synchron'**
  String get syncStatusSynchronized;

  /// No description provided for @syncStatusOpenCount.
  ///
  /// In de, this message translates to:
  /// **'{count} offen'**
  String syncStatusOpenCount(int count);

  /// No description provided for @quickActionsTitle.
  ///
  /// In de, this message translates to:
  /// **'Schnellaktionen'**
  String get quickActionsTitle;

  /// No description provided for @searchAction.
  ///
  /// In de, this message translates to:
  /// **'Suche'**
  String get searchAction;

  /// No description provided for @settingsTitle.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen'**
  String get settingsTitle;

  /// No description provided for @languageTitle.
  ///
  /// In de, this message translates to:
  /// **'Sprache'**
  String get languageTitle;

  /// No description provided for @languageSystemOption.
  ///
  /// In de, this message translates to:
  /// **'System'**
  String get languageSystemOption;

  /// No description provided for @languageGermanOption.
  ///
  /// In de, this message translates to:
  /// **'Deutsch'**
  String get languageGermanOption;

  /// No description provided for @languageFrenchOption.
  ///
  /// In de, this message translates to:
  /// **'Français'**
  String get languageFrenchOption;

  /// No description provided for @languageItalianOption.
  ///
  /// In de, this message translates to:
  /// **'Italiano'**
  String get languageItalianOption;

  /// No description provided for @noAppointment.
  ///
  /// In de, this message translates to:
  /// **'ohne Termin'**
  String get noAppointment;

  /// No description provided for @noDate.
  ///
  /// In de, this message translates to:
  /// **'ohne Datum'**
  String get noDate;

  /// No description provided for @searchTitle.
  ///
  /// In de, this message translates to:
  /// **'Suche'**
  String get searchTitle;

  /// No description provided for @searchFieldLabel.
  ///
  /// In de, this message translates to:
  /// **'Auftrag, Kunde, Adresse oder Anlage suchen'**
  String get searchFieldLabel;

  /// No description provided for @searchNoResultsTitle.
  ///
  /// In de, this message translates to:
  /// **'Keine Treffer'**
  String get searchNoResultsTitle;

  /// No description provided for @searchNoResultsMessage.
  ///
  /// In de, this message translates to:
  /// **'Mindestens zwei Zeichen eingeben.'**
  String get searchNoResultsMessage;

  /// No description provided for @searchGroupOrders.
  ///
  /// In de, this message translates to:
  /// **'Aufträge'**
  String get searchGroupOrders;

  /// No description provided for @searchGroupCustomers.
  ///
  /// In de, this message translates to:
  /// **'Kunden'**
  String get searchGroupCustomers;

  /// No description provided for @searchGroupObjects.
  ///
  /// In de, this message translates to:
  /// **'Objekte'**
  String get searchGroupObjects;

  /// No description provided for @searchGroupInstallations.
  ///
  /// In de, this message translates to:
  /// **'Anlagen'**
  String get searchGroupInstallations;

  /// No description provided for @retryAction.
  ///
  /// In de, this message translates to:
  /// **'Erneut versuchen'**
  String get retryAction;

  /// No description provided for @notFoundTitle.
  ///
  /// In de, this message translates to:
  /// **'Seite nicht gefunden'**
  String get notFoundTitle;

  /// No description provided for @backToDashboardAction.
  ///
  /// In de, this message translates to:
  /// **'Zum Dashboard'**
  String get backToDashboardAction;

  /// No description provided for @localRecordMissingMessage.
  ///
  /// In de, this message translates to:
  /// **'Der lokale Datensatz ist nicht vorhanden.'**
  String get localRecordMissingMessage;

  /// No description provided for @localWorkOrderMissingMessage.
  ///
  /// In de, this message translates to:
  /// **'Der lokale Auftrag ist nicht vorhanden.'**
  String get localWorkOrderMissingMessage;

  /// No description provided for @workOrdersTitle.
  ///
  /// In de, this message translates to:
  /// **'Aufträge'**
  String get workOrdersTitle;

  /// No description provided for @workOrdersLoadErrorTitle.
  ///
  /// In de, this message translates to:
  /// **'Aufträge konnten nicht geladen werden'**
  String get workOrdersLoadErrorTitle;

  /// No description provided for @workOrdersSearchLabel.
  ///
  /// In de, this message translates to:
  /// **'Aufträge suchen'**
  String get workOrdersSearchLabel;

  /// No description provided for @workOrdersEmptyFilteredTitle.
  ///
  /// In de, this message translates to:
  /// **'Keine passenden Aufträge'**
  String get workOrdersEmptyFilteredTitle;

  /// No description provided for @workOrdersEmptyFilteredMessage.
  ///
  /// In de, this message translates to:
  /// **'Passe Suche oder Statusfilter an.'**
  String get workOrdersEmptyFilteredMessage;

  /// No description provided for @resetFilterAction.
  ///
  /// In de, this message translates to:
  /// **'Filter zurücksetzen'**
  String get resetFilterAction;

  /// No description provided for @allFilterLabel.
  ///
  /// In de, this message translates to:
  /// **'Alle'**
  String get allFilterLabel;

  /// No description provided for @locallyChangedStatus.
  ///
  /// In de, this message translates to:
  /// **'Lokal geändert'**
  String get locallyChangedStatus;

  /// No description provided for @completeOrderTooltip.
  ///
  /// In de, this message translates to:
  /// **'Abschließen'**
  String get completeOrderTooltip;

  /// No description provided for @workOrderDetailTitle.
  ///
  /// In de, this message translates to:
  /// **'Auftragsdetail'**
  String get workOrderDetailTitle;

  /// No description provided for @workOrderLoadErrorTitle.
  ///
  /// In de, this message translates to:
  /// **'Auftrag konnte nicht geladen werden'**
  String get workOrderLoadErrorTitle;

  /// No description provided for @workOrderNotFoundTitle.
  ///
  /// In de, this message translates to:
  /// **'Auftrag nicht gefunden'**
  String get workOrderNotFoundTitle;

  /// No description provided for @actualTimeLabel.
  ///
  /// In de, this message translates to:
  /// **'Ist-Zeit'**
  String get actualTimeLabel;

  /// No description provided for @navigationOpenError.
  ///
  /// In de, this message translates to:
  /// **'Navigation konnte nicht geöffnet werden.'**
  String get navigationOpenError;

  /// No description provided for @callOpenError.
  ///
  /// In de, this message translates to:
  /// **'Anruf konnte nicht gestartet werden.'**
  String get callOpenError;

  /// No description provided for @navigationAction.
  ///
  /// In de, this message translates to:
  /// **'Navigation'**
  String get navigationAction;

  /// No description provided for @callAction.
  ///
  /// In de, this message translates to:
  /// **'Anrufen'**
  String get callAction;

  /// No description provided for @calendarShareAction.
  ///
  /// In de, this message translates to:
  /// **'Kalender'**
  String get calendarShareAction;

  /// No description provided for @calendarShareSuccessMessage.
  ///
  /// In de, this message translates to:
  /// **'Kalendereintrag wurde an die Freigabe übergeben.'**
  String get calendarShareSuccessMessage;

  /// No description provided for @calendarShareCancelledMessage.
  ///
  /// In de, this message translates to:
  /// **'Kalenderfreigabe wurde abgebrochen.'**
  String get calendarShareCancelledMessage;

  /// No description provided for @calendarShareErrorMessage.
  ///
  /// In de, this message translates to:
  /// **'Kalendereintrag konnte nicht geteilt werden: {error}'**
  String calendarShareErrorMessage(String error);

  /// No description provided for @phoneLabel.
  ///
  /// In de, this message translates to:
  /// **'Telefon'**
  String get phoneLabel;

  /// No description provided for @addressLabel.
  ///
  /// In de, this message translates to:
  /// **'Adresse'**
  String get addressLabel;

  /// No description provided for @customerTypeLabel.
  ///
  /// In de, this message translates to:
  /// **'Typ'**
  String get customerTypeLabel;

  /// No description provided for @billingAddressLabel.
  ///
  /// In de, this message translates to:
  /// **'Rechnungsadresse'**
  String get billingAddressLabel;

  /// No description provided for @customerTitle.
  ///
  /// In de, this message translates to:
  /// **'Kunde'**
  String get customerTitle;

  /// No description provided for @customerOpenAction.
  ///
  /// In de, this message translates to:
  /// **'Kunde öffnen'**
  String get customerOpenAction;

  /// No description provided for @objectTitle.
  ///
  /// In de, this message translates to:
  /// **'Objekt'**
  String get objectTitle;

  /// No description provided for @objectOpenAction.
  ///
  /// In de, this message translates to:
  /// **'Objekt öffnen'**
  String get objectOpenAction;

  /// No description provided for @installationsTitle.
  ///
  /// In de, this message translates to:
  /// **'Anlagen'**
  String get installationsTitle;

  /// No description provided for @noLinkedInstallations.
  ///
  /// In de, this message translates to:
  /// **'Keine Anlagen verknüpft.'**
  String get noLinkedInstallations;

  /// No description provided for @processingSectionTitle.
  ///
  /// In de, this message translates to:
  /// **'Bearbeitung'**
  String get processingSectionTitle;

  /// No description provided for @checklistTitle.
  ///
  /// In de, this message translates to:
  /// **'Checkliste'**
  String get checklistTitle;

  /// No description provided for @measurementsTitle.
  ///
  /// In de, this message translates to:
  /// **'Messungen'**
  String get measurementsTitle;

  /// No description provided for @defectsTitle.
  ///
  /// In de, this message translates to:
  /// **'Mängel'**
  String get defectsTitle;

  /// No description provided for @photosTitle.
  ///
  /// In de, this message translates to:
  /// **'Fotos'**
  String get photosTitle;

  /// No description provided for @noPhotosTitle.
  ///
  /// In de, this message translates to:
  /// **'Keine Fotos'**
  String get noPhotosTitle;

  /// No description provided for @timeEntriesTitle.
  ///
  /// In de, this message translates to:
  /// **'Zeiten'**
  String get timeEntriesTitle;

  /// No description provided for @materialTitle.
  ///
  /// In de, this message translates to:
  /// **'Material'**
  String get materialTitle;

  /// No description provided for @reportTitle.
  ///
  /// In de, this message translates to:
  /// **'Rapport'**
  String get reportTitle;

  /// No description provided for @signatureTitle.
  ///
  /// In de, this message translates to:
  /// **'Unterschrift'**
  String get signatureTitle;

  /// No description provided for @completeWorkOrderTitle.
  ///
  /// In de, this message translates to:
  /// **'Auftrag abschließen'**
  String get completeWorkOrderTitle;

  /// No description provided for @completionLoadErrorTitle.
  ///
  /// In de, this message translates to:
  /// **'Abschluss konnte nicht geladen werden'**
  String get completionLoadErrorTitle;

  /// No description provided for @completionCheckTitle.
  ///
  /// In de, this message translates to:
  /// **'Abschlussprüfung'**
  String get completionCheckTitle;

  /// No description provided for @readyStatus.
  ///
  /// In de, this message translates to:
  /// **'Bereit'**
  String get readyStatus;

  /// No description provided for @openStatus.
  ///
  /// In de, this message translates to:
  /// **'Offen'**
  String get openStatus;

  /// No description provided for @completionReadyMessage.
  ///
  /// In de, this message translates to:
  /// **'Alle lokalen Mindestdaten sind vorhanden.'**
  String get completionReadyMessage;

  /// No description provided for @saveLocallyCompleteAction.
  ///
  /// In de, this message translates to:
  /// **'Lokal abschließen'**
  String get saveLocallyCompleteAction;

  /// No description provided for @reportsLoadErrorTitle.
  ///
  /// In de, this message translates to:
  /// **'Rapporte konnten nicht geladen werden'**
  String get reportsLoadErrorTitle;

  /// No description provided for @localReportFilesTitle.
  ///
  /// In de, this message translates to:
  /// **'Lokale Rapportdateien'**
  String get localReportFilesTitle;

  /// No description provided for @pdfReportTitle.
  ///
  /// In de, this message translates to:
  /// **'PDF-Bericht'**
  String get pdfReportTitle;

  /// No description provided for @pdfReportSourceMessage.
  ///
  /// In de, this message translates to:
  /// **'Rapportdaten werden aus der lokalen Datenbank geladen.'**
  String get pdfReportSourceMessage;

  /// No description provided for @pdfSignerLabel.
  ///
  /// In de, this message translates to:
  /// **'Unterzeichner'**
  String get pdfSignerLabel;

  /// No description provided for @pdfNoSignatureMessage.
  ///
  /// In de, this message translates to:
  /// **'Keine Signatur gespeichert.'**
  String get pdfNoSignatureMessage;

  /// No description provided for @pdfNoEntriesMessage.
  ///
  /// In de, this message translates to:
  /// **'Keine Einträge.'**
  String get pdfNoEntriesMessage;

  /// No description provided for @reportNoPdfTitle.
  ///
  /// In de, this message translates to:
  /// **'Noch kein PDF erzeugt'**
  String get reportNoPdfTitle;

  /// No description provided for @reportNoPdfMessage.
  ///
  /// In de, this message translates to:
  /// **'Der Rapport kann offline generiert werden.'**
  String get reportNoPdfMessage;

  /// No description provided for @reportSavePdfAction.
  ///
  /// In de, this message translates to:
  /// **'PDF lokal speichern'**
  String get reportSavePdfAction;

  /// No description provided for @reportPdfSavedMessage.
  ///
  /// In de, this message translates to:
  /// **'PDF lokal gespeichert.'**
  String get reportPdfSavedMessage;

  /// No description provided for @reportEmailShareAction.
  ///
  /// In de, this message translates to:
  /// **'Rapport per E-Mail senden'**
  String get reportEmailShareAction;

  /// No description provided for @reportEmailShareSuccessMessage.
  ///
  /// In de, this message translates to:
  /// **'Rapport wurde an die Freigabe übergeben.'**
  String get reportEmailShareSuccessMessage;

  /// No description provided for @reportEmailShareCancelledMessage.
  ///
  /// In de, this message translates to:
  /// **'Freigabe wurde abgebrochen.'**
  String get reportEmailShareCancelledMessage;

  /// No description provided for @reportEmailShareErrorMessage.
  ///
  /// In de, this message translates to:
  /// **'Rapport konnte nicht geteilt werden: {error}'**
  String reportEmailShareErrorMessage(String error);

  /// No description provided for @invoiceExportAction.
  ///
  /// In de, this message translates to:
  /// **'Rechnungsentwurf exportieren'**
  String get invoiceExportAction;

  /// No description provided for @invoiceExportSuccessMessage.
  ///
  /// In de, this message translates to:
  /// **'Rechnungsentwurf wurde an die Freigabe übergeben.'**
  String get invoiceExportSuccessMessage;

  /// No description provided for @invoiceExportCancelledMessage.
  ///
  /// In de, this message translates to:
  /// **'Rechnungsexport wurde abgebrochen.'**
  String get invoiceExportCancelledMessage;

  /// No description provided for @invoiceExportErrorMessage.
  ///
  /// In de, this message translates to:
  /// **'Rechnungsentwurf konnte nicht exportiert werden: {error}'**
  String invoiceExportErrorMessage(String error);

  /// No description provided for @reportEmailSubject.
  ///
  /// In de, this message translates to:
  /// **'Rapport {orderNumber} - {customerName}'**
  String reportEmailSubject(String orderNumber, String customerName);

  /// No description provided for @reportEmailBody.
  ///
  /// In de, this message translates to:
  /// **'Guten Tag\n\nIm Anhang finden Sie den Rapport {orderNumber} für {customerName}.\n\nFreundliche Grüsse'**
  String reportEmailBody(String customerName, String orderNumber);

  /// No description provided for @reportPreviewErrorTitle.
  ///
  /// In de, this message translates to:
  /// **'Vorschau konnte nicht erstellt werden'**
  String get reportPreviewErrorTitle;

  /// No description provided for @reportNoPreviewTitle.
  ///
  /// In de, this message translates to:
  /// **'Keine Vorschau'**
  String get reportNoPreviewTitle;

  /// No description provided for @reportNoPreviewMessage.
  ///
  /// In de, this message translates to:
  /// **'Der Auftrag ist lokal nicht vorhanden.'**
  String get reportNoPreviewMessage;

  /// No description provided for @measurementsUnavailableTitle.
  ///
  /// In de, this message translates to:
  /// **'Keine Messungen möglich'**
  String get measurementsUnavailableTitle;

  /// No description provided for @measurementsLoadErrorTitle.
  ///
  /// In de, this message translates to:
  /// **'Messungen konnten nicht geladen werden'**
  String get measurementsLoadErrorTitle;

  /// No description provided for @measurementsEmptyTitle.
  ///
  /// In de, this message translates to:
  /// **'Keine Messwerte erfasst'**
  String get measurementsEmptyTitle;

  /// No description provided for @measurementsEmptyMessage.
  ///
  /// In de, this message translates to:
  /// **'Neue Messwerte werden lokal gespeichert.'**
  String get measurementsEmptyMessage;

  /// No description provided for @recordedMeasurementsTitle.
  ///
  /// In de, this message translates to:
  /// **'Erfasste Messungen'**
  String get recordedMeasurementsTitle;

  /// No description provided for @measurementTypeLabel.
  ///
  /// In de, this message translates to:
  /// **'Messart'**
  String get measurementTypeLabel;

  /// No description provided for @noInstallationOption.
  ///
  /// In de, this message translates to:
  /// **'Keine Anlage'**
  String get noInstallationOption;

  /// No description provided for @installationFieldLabel.
  ///
  /// In de, this message translates to:
  /// **'Anlage'**
  String get installationFieldLabel;

  /// No description provided for @valueFieldLabel.
  ///
  /// In de, this message translates to:
  /// **'Wert'**
  String get valueFieldLabel;

  /// No description provided for @unitFieldLabel.
  ///
  /// In de, this message translates to:
  /// **'Einheit'**
  String get unitFieldLabel;

  /// No description provided for @notesFieldLabel.
  ///
  /// In de, this message translates to:
  /// **'Notizen'**
  String get notesFieldLabel;

  /// No description provided for @notesSectionTitle.
  ///
  /// In de, this message translates to:
  /// **'Notizen'**
  String get notesSectionTitle;

  /// No description provided for @saveMeasurementAction.
  ///
  /// In de, this message translates to:
  /// **'Messwert speichern'**
  String get saveMeasurementAction;

  /// No description provided for @bluetoothMeasurementTitle.
  ///
  /// In de, this message translates to:
  /// **'Bluetooth-Messgerät'**
  String get bluetoothMeasurementTitle;

  /// No description provided for @bluetoothMeasurementSubtitle.
  ///
  /// In de, this message translates to:
  /// **'BLE-Messgeräte scannen, verbinden und Messwerte direkt lokal übernehmen.'**
  String get bluetoothMeasurementSubtitle;

  /// No description provided for @startBluetoothScanAction.
  ///
  /// In de, this message translates to:
  /// **'Scan starten'**
  String get startBluetoothScanAction;

  /// No description provided for @stopBluetoothScanAction.
  ///
  /// In de, this message translates to:
  /// **'Scan stoppen'**
  String get stopBluetoothScanAction;

  /// No description provided for @bluetoothDevicesEmptyMessage.
  ///
  /// In de, this message translates to:
  /// **'Noch kein Messgerät gefunden.'**
  String get bluetoothDevicesEmptyMessage;

  /// No description provided for @bluetoothDeviceConnectingStatus.
  ///
  /// In de, this message translates to:
  /// **'Verbinden...'**
  String get bluetoothDeviceConnectingStatus;

  /// No description provided for @bluetoothReadingSaveAction.
  ///
  /// In de, this message translates to:
  /// **'Messwert übernehmen'**
  String get bluetoothReadingSaveAction;

  /// No description provided for @bluetoothReadingSavedMessage.
  ///
  /// In de, this message translates to:
  /// **'Bluetooth-Messwert lokal gespeichert.'**
  String get bluetoothReadingSavedMessage;

  /// No description provided for @measurementDeviceLabel.
  ///
  /// In de, this message translates to:
  /// **'Gerät'**
  String get measurementDeviceLabel;

  /// No description provided for @photosLoadErrorTitle.
  ///
  /// In de, this message translates to:
  /// **'Fotos konnten nicht geladen werden'**
  String get photosLoadErrorTitle;

  /// No description provided for @photosEmptyTitle.
  ///
  /// In de, this message translates to:
  /// **'Keine Fotos gespeichert'**
  String get photosEmptyTitle;

  /// No description provided for @photosEmptyMessage.
  ///
  /// In de, this message translates to:
  /// **'Fotos werden lokal im App-Verzeichnis abgelegt.'**
  String get photosEmptyMessage;

  /// No description provided for @photoAddTitle.
  ///
  /// In de, this message translates to:
  /// **'Foto hinzufügen'**
  String get photoAddTitle;

  /// No description provided for @cameraAction.
  ///
  /// In de, this message translates to:
  /// **'Kamera'**
  String get cameraAction;

  /// No description provided for @galleryAction.
  ///
  /// In de, this message translates to:
  /// **'Galerie'**
  String get galleryAction;

  /// No description provided for @photoSavedMessage.
  ///
  /// In de, this message translates to:
  /// **'Foto lokal gespeichert.'**
  String get photoSavedMessage;

  /// No description provided for @photoTitle.
  ///
  /// In de, this message translates to:
  /// **'Foto'**
  String get photoTitle;

  /// No description provided for @photoLoadErrorTitle.
  ///
  /// In de, this message translates to:
  /// **'Foto konnte nicht geladen werden'**
  String get photoLoadErrorTitle;

  /// No description provided for @photoNotFoundTitle.
  ///
  /// In de, this message translates to:
  /// **'Foto nicht gefunden'**
  String get photoNotFoundTitle;

  /// No description provided for @photoMetadataMissingMessage.
  ///
  /// In de, this message translates to:
  /// **'Die lokale Fotometadatei ist nicht vorhanden.'**
  String get photoMetadataMissingMessage;

  /// No description provided for @photoCaptionLabel.
  ///
  /// In de, this message translates to:
  /// **'Bildnotiz'**
  String get photoCaptionLabel;

  /// No description provided for @savePhotoCaptionAction.
  ///
  /// In de, this message translates to:
  /// **'Bildnotiz speichern'**
  String get savePhotoCaptionAction;

  /// No description provided for @photoCaptionSavedMessage.
  ///
  /// In de, this message translates to:
  /// **'Bildnotiz lokal gespeichert.'**
  String get photoCaptionSavedMessage;

  /// No description provided for @uploadPendingStatus.
  ///
  /// In de, this message translates to:
  /// **'Upload offen'**
  String get uploadPendingStatus;

  /// No description provided for @uploadedStatus.
  ///
  /// In de, this message translates to:
  /// **'Uploaded'**
  String get uploadedStatus;

  /// No description provided for @defectAssignedStatus.
  ///
  /// In de, this message translates to:
  /// **'Mangel zugeordnet'**
  String get defectAssignedStatus;

  /// No description provided for @objectLoadErrorTitle.
  ///
  /// In de, this message translates to:
  /// **'Objekt konnte nicht geladen werden'**
  String get objectLoadErrorTitle;

  /// No description provided for @objectNotFoundTitle.
  ///
  /// In de, this message translates to:
  /// **'Objekt nicht gefunden'**
  String get objectNotFoundTitle;

  /// No description provided for @accessNotesLabel.
  ///
  /// In de, this message translates to:
  /// **'Zugang'**
  String get accessNotesLabel;

  /// No description provided for @safetyNotesLabel.
  ///
  /// In de, this message translates to:
  /// **'Sicherheit'**
  String get safetyNotesLabel;

  /// No description provided for @objectNotesLabel.
  ///
  /// In de, this message translates to:
  /// **'Notizen zum Objekt'**
  String get objectNotesLabel;

  /// No description provided for @saveNotesAction.
  ///
  /// In de, this message translates to:
  /// **'Notizen speichern'**
  String get saveNotesAction;

  /// No description provided for @objectNotesSavedMessage.
  ///
  /// In de, this message translates to:
  /// **'Objektnotizen lokal gespeichert.'**
  String get objectNotesSavedMessage;

  /// No description provided for @objectHistoryTitle.
  ///
  /// In de, this message translates to:
  /// **'Objekthistorie'**
  String get objectHistoryTitle;

  /// No description provided for @objectNotesTitle.
  ///
  /// In de, this message translates to:
  /// **'Objektnotizen'**
  String get objectNotesTitle;

  /// No description provided for @installationListSearchLabel.
  ///
  /// In de, this message translates to:
  /// **'Anlage suchen'**
  String get installationListSearchLabel;

  /// No description provided for @installationScanTooltip.
  ///
  /// In de, this message translates to:
  /// **'QR-/Barcode scannen'**
  String get installationScanTooltip;

  /// No description provided for @installationScanTitle.
  ///
  /// In de, this message translates to:
  /// **'Anlage scannen'**
  String get installationScanTitle;

  /// No description provided for @installationScanManualLabel.
  ///
  /// In de, this message translates to:
  /// **'Anlagen-ID oder Seriennummer'**
  String get installationScanManualLabel;

  /// No description provided for @installationScanManualAction.
  ///
  /// In de, this message translates to:
  /// **'Code suchen'**
  String get installationScanManualAction;

  /// No description provided for @installationScanNoMatchMessage.
  ///
  /// In de, this message translates to:
  /// **'Keine lokale Anlage für \"{code}\" gefunden.'**
  String installationScanNoMatchMessage(String code);

  /// No description provided for @installationScanCameraError.
  ///
  /// In de, this message translates to:
  /// **'Kamera konnte nicht gestartet werden. Gib die Anlagen-ID oder Seriennummer manuell ein.'**
  String get installationScanCameraError;

  /// No description provided for @installationsLoadErrorTitle.
  ///
  /// In de, this message translates to:
  /// **'Anlagen konnten nicht geladen werden'**
  String get installationsLoadErrorTitle;

  /// No description provided for @installationsEmptyTitle.
  ///
  /// In de, this message translates to:
  /// **'Keine Anlagen'**
  String get installationsEmptyTitle;

  /// No description provided for @installationsEmptyMessage.
  ///
  /// In de, this message translates to:
  /// **'Die Anlagen werden aus der lokalen DB geladen.'**
  String get installationsEmptyMessage;

  /// No description provided for @installationTitle.
  ///
  /// In de, this message translates to:
  /// **'Anlage'**
  String get installationTitle;

  /// No description provided for @installationLoadErrorTitle.
  ///
  /// In de, this message translates to:
  /// **'Anlage konnte nicht geladen werden'**
  String get installationLoadErrorTitle;

  /// No description provided for @installationNotFoundTitle.
  ///
  /// In de, this message translates to:
  /// **'Anlage nicht gefunden'**
  String get installationNotFoundTitle;

  /// No description provided for @typeLabel.
  ///
  /// In de, this message translates to:
  /// **'Typ'**
  String get typeLabel;

  /// No description provided for @fuelTypeLabel.
  ///
  /// In de, this message translates to:
  /// **'Brennstoff'**
  String get fuelTypeLabel;

  /// No description provided for @locationLabel.
  ///
  /// In de, this message translates to:
  /// **'Standort'**
  String get locationLabel;

  /// No description provided for @serialNumberLabel.
  ///
  /// In de, this message translates to:
  /// **'Seriennummer'**
  String get serialNumberLabel;

  /// No description provided for @lastServiceLabel.
  ///
  /// In de, this message translates to:
  /// **'Letzte Arbeit'**
  String get lastServiceLabel;

  /// No description provided for @nextServiceLabel.
  ///
  /// In de, this message translates to:
  /// **'Nächste Arbeit'**
  String get nextServiceLabel;

  /// No description provided for @installationNotesLabel.
  ///
  /// In de, this message translates to:
  /// **'Notizen zur Anlage'**
  String get installationNotesLabel;

  /// No description provided for @installationNotesTitle.
  ///
  /// In de, this message translates to:
  /// **'Anlagennotizen'**
  String get installationNotesTitle;

  /// No description provided for @installationNotesSavedMessage.
  ///
  /// In de, this message translates to:
  /// **'Anlagennotizen lokal gespeichert.'**
  String get installationNotesSavedMessage;

  /// No description provided for @installationPhotosTitle.
  ///
  /// In de, this message translates to:
  /// **'Fotos zur Anlage'**
  String get installationPhotosTitle;

  /// No description provided for @installationPhotosEmptyTitle.
  ///
  /// In de, this message translates to:
  /// **'Keine Anlagenfotos'**
  String get installationPhotosEmptyTitle;

  /// No description provided for @installationHistoryTitle.
  ///
  /// In de, this message translates to:
  /// **'Anlagenhistorie'**
  String get installationHistoryTitle;

  /// No description provided for @loginTitle.
  ///
  /// In de, this message translates to:
  /// **'Anmeldung'**
  String get loginTitle;

  /// No description provided for @loginAccessTitle.
  ///
  /// In de, this message translates to:
  /// **'Technikerzugang'**
  String get loginAccessTitle;

  /// No description provided for @loginAccessMessage.
  ///
  /// In de, this message translates to:
  /// **'Lokale Sitzungen bleiben später auch ohne Verbindung nutzbar.'**
  String get loginAccessMessage;

  /// No description provided for @emailFieldLabel.
  ///
  /// In de, this message translates to:
  /// **'E-Mail'**
  String get emailFieldLabel;

  /// No description provided for @passwordFieldLabel.
  ///
  /// In de, this message translates to:
  /// **'Passwort'**
  String get passwordFieldLabel;

  /// No description provided for @openDemoSessionAction.
  ///
  /// In de, this message translates to:
  /// **'Demo-Sitzung öffnen'**
  String get openDemoSessionAction;

  /// No description provided for @continueOfflineAction.
  ///
  /// In de, this message translates to:
  /// **'Offline fortfahren'**
  String get continueOfflineAction;

  /// No description provided for @syncStatusLoadErrorTitle.
  ///
  /// In de, this message translates to:
  /// **'Sync-Status konnte nicht geladen werden'**
  String get syncStatusLoadErrorTitle;

  /// No description provided for @syncEntriesEmptyTitle.
  ///
  /// In de, this message translates to:
  /// **'Keine offenen Sync-Einträge'**
  String get syncEntriesEmptyTitle;

  /// No description provided for @syncEntriesEmptyMessage.
  ///
  /// In de, this message translates to:
  /// **'Lokale Änderungen sind abgearbeitet.'**
  String get syncEntriesEmptyMessage;

  /// No description provided for @signerNameLabel.
  ///
  /// In de, this message translates to:
  /// **'Name Unterzeichner'**
  String get signerNameLabel;

  /// No description provided for @clearAction.
  ///
  /// In de, this message translates to:
  /// **'Leeren'**
  String get clearAction;

  /// No description provided for @undoAction.
  ///
  /// In de, this message translates to:
  /// **'Undo'**
  String get undoAction;

  /// No description provided for @saveSignatureAction.
  ///
  /// In de, this message translates to:
  /// **'Signatur speichern'**
  String get saveSignatureAction;

  /// No description provided for @timeEntriesLoadErrorTitle.
  ///
  /// In de, this message translates to:
  /// **'Zeiten konnten nicht geladen werden'**
  String get timeEntriesLoadErrorTitle;

  /// No description provided for @timeEntriesEmptyTitle.
  ///
  /// In de, this message translates to:
  /// **'Keine Zeiten erfasst'**
  String get timeEntriesEmptyTitle;

  /// No description provided for @timeEntriesEmptyMessage.
  ///
  /// In de, this message translates to:
  /// **'Start/Stop-Zeiten werden lokal gespeichert.'**
  String get timeEntriesEmptyMessage;

  /// No description provided for @timeEntryTypeLabel.
  ///
  /// In de, this message translates to:
  /// **'Zeittyp'**
  String get timeEntryTypeLabel;

  /// No description provided for @durationMinutesLabel.
  ///
  /// In de, this message translates to:
  /// **'Dauer in Minuten'**
  String get durationMinutesLabel;

  /// No description provided for @saveTimeEntryAction.
  ///
  /// In de, this message translates to:
  /// **'Zeit speichern'**
  String get saveTimeEntryAction;

  /// No description provided for @goToLoginAction.
  ///
  /// In de, this message translates to:
  /// **'Zur Anmeldung'**
  String get goToLoginAction;

  /// No description provided for @defectsUnavailableTitle.
  ///
  /// In de, this message translates to:
  /// **'Keine Mängel möglich'**
  String get defectsUnavailableTitle;

  /// No description provided for @defectsLoadErrorTitle.
  ///
  /// In de, this message translates to:
  /// **'Mängel konnten nicht geladen werden'**
  String get defectsLoadErrorTitle;

  /// No description provided for @defectsEmptyTitle.
  ///
  /// In de, this message translates to:
  /// **'Keine Mängel erfasst'**
  String get defectsEmptyTitle;

  /// No description provided for @defectsEmptyMessage.
  ///
  /// In de, this message translates to:
  /// **'Neue Mängel werden lokal gespeichert.'**
  String get defectsEmptyMessage;

  /// No description provided for @recordedDefectsTitle.
  ///
  /// In de, this message translates to:
  /// **'Erfasste Mängel'**
  String get recordedDefectsTitle;

  /// No description provided for @defectAddTitle.
  ///
  /// In de, this message translates to:
  /// **'Mangel erfassen'**
  String get defectAddTitle;

  /// No description provided for @severityLabel.
  ///
  /// In de, this message translates to:
  /// **'Schweregrad'**
  String get severityLabel;

  /// No description provided for @titleFieldLabel.
  ///
  /// In de, this message translates to:
  /// **'Titel'**
  String get titleFieldLabel;

  /// No description provided for @descriptionFieldLabel.
  ///
  /// In de, this message translates to:
  /// **'Beschreibung'**
  String get descriptionFieldLabel;

  /// No description provided for @recommendedActionLabel.
  ///
  /// In de, this message translates to:
  /// **'Empfohlene Massnahme'**
  String get recommendedActionLabel;

  /// No description provided for @saveDefectAction.
  ///
  /// In de, this message translates to:
  /// **'Mangel speichern'**
  String get saveDefectAction;

  /// No description provided for @measureLabel.
  ///
  /// In de, this message translates to:
  /// **'Massnahme'**
  String get measureLabel;

  /// No description provided for @assignPhotoAction.
  ///
  /// In de, this message translates to:
  /// **'Foto zuordnen'**
  String get assignPhotoAction;

  /// No description provided for @resolveAction.
  ///
  /// In de, this message translates to:
  /// **'Erledigen'**
  String get resolveAction;

  /// No description provided for @resolvedStatus.
  ///
  /// In de, this message translates to:
  /// **'Erledigt'**
  String get resolvedStatus;

  /// No description provided for @noPhotosInOrderMessage.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Fotos im Auftrag.'**
  String get noPhotosInOrderMessage;

  /// No description provided for @materialLoadErrorTitle.
  ///
  /// In de, this message translates to:
  /// **'Material konnte nicht geladen werden'**
  String get materialLoadErrorTitle;

  /// No description provided for @materialCatalogLoadErrorTitle.
  ///
  /// In de, this message translates to:
  /// **'Materialstamm konnte nicht geladen werden'**
  String get materialCatalogLoadErrorTitle;

  /// No description provided for @materialEmptyTitle.
  ///
  /// In de, this message translates to:
  /// **'Kein Material erfasst'**
  String get materialEmptyTitle;

  /// No description provided for @materialEmptyMessage.
  ///
  /// In de, this message translates to:
  /// **'Verbrauch wird lokal am Auftrag gespeichert.'**
  String get materialEmptyMessage;

  /// No description provided for @materialAddTitle.
  ///
  /// In de, this message translates to:
  /// **'Material erfassen'**
  String get materialAddTitle;

  /// No description provided for @freeTextOption.
  ///
  /// In de, this message translates to:
  /// **'Freitext'**
  String get freeTextOption;

  /// No description provided for @materialCatalogFieldLabel.
  ///
  /// In de, this message translates to:
  /// **'Materialstamm'**
  String get materialCatalogFieldLabel;

  /// No description provided for @materialStockSectionTitle.
  ///
  /// In de, this message translates to:
  /// **'Lagerbestand'**
  String get materialStockSectionTitle;

  /// No description provided for @materialStockAvailable.
  ///
  /// In de, this message translates to:
  /// **'Bestand: {quantity} {unit}'**
  String materialStockAvailable(Object quantity, Object unit);

  /// No description provided for @materialStockMinimum.
  ///
  /// In de, this message translates to:
  /// **'Minimum: {quantity} {unit}'**
  String materialStockMinimum(Object quantity, Object unit);

  /// No description provided for @materialLowStockLabel.
  ///
  /// In de, this message translates to:
  /// **'Knapp'**
  String get materialLowStockLabel;

  /// No description provided for @materialSufficientStockLabel.
  ///
  /// In de, this message translates to:
  /// **'OK'**
  String get materialSufficientStockLabel;

  /// No description provided for @nameFieldLabel.
  ///
  /// In de, this message translates to:
  /// **'Bezeichnung'**
  String get nameFieldLabel;

  /// No description provided for @quantityFieldLabel.
  ///
  /// In de, this message translates to:
  /// **'Menge'**
  String get quantityFieldLabel;

  /// No description provided for @saveMaterialAction.
  ///
  /// In de, this message translates to:
  /// **'Material speichern'**
  String get saveMaterialAction;

  /// No description provided for @profileTitle.
  ///
  /// In de, this message translates to:
  /// **'Profil'**
  String get profileTitle;

  /// No description provided for @storageTitle.
  ///
  /// In de, this message translates to:
  /// **'Speicher'**
  String get storageTitle;

  /// No description provided for @appVersionTitle.
  ///
  /// In de, this message translates to:
  /// **'App-Version'**
  String get appVersionTitle;

  /// No description provided for @calculatingStatus.
  ///
  /// In de, this message translates to:
  /// **'wird berechnet'**
  String get calculatingStatus;

  /// No description provided for @demoTechnician.
  ///
  /// In de, this message translates to:
  /// **'Demo-Techniker'**
  String get demoTechnician;

  /// No description provided for @openSyncStatusAction.
  ///
  /// In de, this message translates to:
  /// **'Sync-Status öffnen'**
  String get openSyncStatusAction;

  /// No description provided for @createDebugExportAction.
  ///
  /// In de, this message translates to:
  /// **'Debug Export erstellen'**
  String get createDebugExportAction;

  /// No description provided for @logoutAction.
  ///
  /// In de, this message translates to:
  /// **'Logout'**
  String get logoutAction;

  /// No description provided for @debugExportMessage.
  ///
  /// In de, this message translates to:
  /// **'Debug Export: {path}'**
  String debugExportMessage(String path);

  /// No description provided for @profileLoadErrorTitle.
  ///
  /// In de, this message translates to:
  /// **'Profil konnte nicht geladen werden'**
  String get profileLoadErrorTitle;

  /// No description provided for @profileUnavailableTitle.
  ///
  /// In de, this message translates to:
  /// **'Profil nicht verfügbar'**
  String get profileUnavailableTitle;

  /// No description provided for @profileUnavailableMessage.
  ///
  /// In de, this message translates to:
  /// **'Die lokalen Stammdaten fehlen.'**
  String get profileUnavailableMessage;

  /// No description provided for @roleLabel.
  ///
  /// In de, this message translates to:
  /// **'Rolle'**
  String get roleLabel;

  /// No description provided for @cityLabel.
  ///
  /// In de, this message translates to:
  /// **'Ort'**
  String get cityLabel;

  /// No description provided for @countryLabel.
  ///
  /// In de, this message translates to:
  /// **'Land'**
  String get countryLabel;

  /// No description provided for @customersTitle.
  ///
  /// In de, this message translates to:
  /// **'Kunden'**
  String get customersTitle;

  /// No description provided for @customersLoadErrorTitle.
  ///
  /// In de, this message translates to:
  /// **'Kunden konnten nicht geladen werden'**
  String get customersLoadErrorTitle;

  /// No description provided for @customersEmptyTitle.
  ///
  /// In de, this message translates to:
  /// **'Keine Kunden'**
  String get customersEmptyTitle;

  /// No description provided for @customersEmptyMessage.
  ///
  /// In de, this message translates to:
  /// **'Kundendaten werden nach dem Sync lokal sichtbar.'**
  String get customersEmptyMessage;

  /// No description provided for @customerLoadErrorTitle.
  ///
  /// In de, this message translates to:
  /// **'Kunde konnte nicht geladen werden'**
  String get customerLoadErrorTitle;

  /// No description provided for @customerNotFoundTitle.
  ///
  /// In de, this message translates to:
  /// **'Kunde nicht gefunden'**
  String get customerNotFoundTitle;

  /// No description provided for @customerNotesLabel.
  ///
  /// In de, this message translates to:
  /// **'Kundennotizen'**
  String get customerNotesLabel;

  /// No description provided for @customerNotesSavedMessage.
  ///
  /// In de, this message translates to:
  /// **'Kundennotizen lokal gespeichert.'**
  String get customerNotesSavedMessage;

  /// No description provided for @objectsTitle.
  ///
  /// In de, this message translates to:
  /// **'Objekte'**
  String get objectsTitle;

  /// No description provided for @objectsEmptyTitle.
  ///
  /// In de, this message translates to:
  /// **'Keine Objekte'**
  String get objectsEmptyTitle;

  /// No description provided for @orderHistoryTitle.
  ///
  /// In de, this message translates to:
  /// **'Auftragshistorie'**
  String get orderHistoryTitle;

  /// No description provided for @historyTotalMetricLabel.
  ///
  /// In de, this message translates to:
  /// **'Gesamt'**
  String get historyTotalMetricLabel;

  /// No description provided for @historyCompletedMetricLabel.
  ///
  /// In de, this message translates to:
  /// **'Erledigt'**
  String get historyCompletedMetricLabel;

  /// No description provided for @historyOpenMetricLabel.
  ///
  /// In de, this message translates to:
  /// **'Offen'**
  String get historyOpenMetricLabel;

  /// No description provided for @historyOverdueMetricLabel.
  ///
  /// In de, this message translates to:
  /// **'Überfällig'**
  String get historyOverdueMetricLabel;

  /// No description provided for @historyLocalMetricLabel.
  ///
  /// In de, this message translates to:
  /// **'Lokal'**
  String get historyLocalMetricLabel;

  /// No description provided for @historyLastCompletedLabel.
  ///
  /// In de, this message translates to:
  /// **'Letzter Abschluss'**
  String get historyLastCompletedLabel;

  /// No description provided for @historyNextScheduledLabel.
  ///
  /// In de, this message translates to:
  /// **'Nächster Termin'**
  String get historyNextScheduledLabel;

  /// No description provided for @historyNoCompletedOrders.
  ///
  /// In de, this message translates to:
  /// **'kein Abschluss'**
  String get historyNoCompletedOrders;

  /// No description provided for @historyNoUpcomingOrders.
  ///
  /// In de, this message translates to:
  /// **'kein offener Termin'**
  String get historyNoUpcomingOrders;

  /// No description provided for @previousOrdersEmptyTitle.
  ///
  /// In de, this message translates to:
  /// **'Keine früheren Aufträge'**
  String get previousOrdersEmptyTitle;

  /// No description provided for @ordersEmptyTitle.
  ///
  /// In de, this message translates to:
  /// **'Keine Aufträge'**
  String get ordersEmptyTitle;

  /// No description provided for @checklistLoadErrorTitle.
  ///
  /// In de, this message translates to:
  /// **'Checkliste konnte nicht geladen werden'**
  String get checklistLoadErrorTitle;

  /// No description provided for @checklistUnavailableTitle.
  ///
  /// In de, this message translates to:
  /// **'Keine Checkliste verfügbar'**
  String get checklistUnavailableTitle;

  /// No description provided for @checklistTemplateMissingTitle.
  ///
  /// In de, this message translates to:
  /// **'Keine Vorlage gefunden'**
  String get checklistTemplateMissingTitle;

  /// No description provided for @checklistMissingTemplateMessage.
  ///
  /// In de, this message translates to:
  /// **'Für diesen Auftragstyp existiert lokal keine aktive Vorlage.'**
  String get checklistMissingTemplateMessage;

  /// No description provided for @commentFieldLabel.
  ///
  /// In de, this message translates to:
  /// **'Kommentar'**
  String get commentFieldLabel;

  /// No description provided for @yesOption.
  ///
  /// In de, this message translates to:
  /// **'Ja'**
  String get yesOption;

  /// No description provided for @noOption.
  ///
  /// In de, this message translates to:
  /// **'Nein'**
  String get noOption;

  /// No description provided for @answerFieldLabel.
  ///
  /// In de, this message translates to:
  /// **'Antwort'**
  String get answerFieldLabel;

  /// No description provided for @numberFieldLabel.
  ///
  /// In de, this message translates to:
  /// **'Zahl'**
  String get numberFieldLabel;

  /// No description provided for @selectionFieldLabel.
  ///
  /// In de, this message translates to:
  /// **'Auswahl'**
  String get selectionFieldLabel;

  /// No description provided for @photoRequiredRecordedTitle.
  ///
  /// In de, this message translates to:
  /// **'Fotopflicht notiert'**
  String get photoRequiredRecordedTitle;

  /// No description provided for @unknownAnswerTypeMessage.
  ///
  /// In de, this message translates to:
  /// **'Unbekannter Antworttyp.'**
  String get unknownAnswerTypeMessage;

  /// No description provided for @locallySavedStatus.
  ///
  /// In de, this message translates to:
  /// **'Lokal gespeichert'**
  String get locallySavedStatus;

  /// No description provided for @initialSyncTitle.
  ///
  /// In de, this message translates to:
  /// **'Initialer Sync'**
  String get initialSyncTitle;

  /// No description provided for @initialSyncReadyLabel.
  ///
  /// In de, this message translates to:
  /// **'Bereit'**
  String get initialSyncReadyLabel;

  /// No description provided for @initialSyncLoadTitle.
  ///
  /// In de, this message translates to:
  /// **'Arbeitsdaten laden'**
  String get initialSyncLoadTitle;

  /// No description provided for @initialSyncLoadMinimalAction.
  ///
  /// In de, this message translates to:
  /// **'Minimaldaten laden'**
  String get initialSyncLoadMinimalAction;

  /// No description provided for @initialSyncOpenDatabaseStep.
  ///
  /// In de, this message translates to:
  /// **'Lokale Datenbank öffnen'**
  String get initialSyncOpenDatabaseStep;

  /// No description provided for @initialSyncProfileStep.
  ///
  /// In de, this message translates to:
  /// **'Benutzerprofil prüfen'**
  String get initialSyncProfileStep;

  /// No description provided for @initialSyncOrdersStep.
  ///
  /// In de, this message translates to:
  /// **'Aufträge und Kunden bereitstellen'**
  String get initialSyncOrdersStep;

  /// No description provided for @initialSyncObjectsStep.
  ///
  /// In de, this message translates to:
  /// **'Objekte und Anlagen bereitstellen'**
  String get initialSyncObjectsStep;

  /// No description provided for @initialSyncChecklistStep.
  ///
  /// In de, this message translates to:
  /// **'Checklisten und Materialstamm bereitstellen'**
  String get initialSyncChecklistStep;

  /// No description provided for @initialSyncFailedLabel.
  ///
  /// In de, this message translates to:
  /// **'Initialer Sync fehlgeschlagen'**
  String get initialSyncFailedLabel;

  /// No description provided for @customerSignatureTitle.
  ///
  /// In de, this message translates to:
  /// **'Kundenunterschrift'**
  String get customerSignatureTitle;

  /// No description provided for @timeEntryAddTitle.
  ///
  /// In de, this message translates to:
  /// **'Zeit erfassen'**
  String get timeEntryAddTitle;

  /// No description provided for @durationPositiveError.
  ///
  /// In de, this message translates to:
  /// **'Dauer muss groesser als 0 sein.'**
  String get durationPositiveError;

  /// No description provided for @splashTagline.
  ///
  /// In de, this message translates to:
  /// **'Einsätze, Rapporte und lokale Arbeitsdaten für den Feldalltag.'**
  String get splashTagline;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'fr', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

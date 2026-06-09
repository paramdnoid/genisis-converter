import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/checklists/presentation/checklist_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/auth/application/auth_providers.dart';
import '../../features/customers/presentation/customer_list_screen.dart';
import '../../features/customers/presentation/customer_detail_screen.dart';
import '../../features/defects/presentation/defect_screen.dart';
import '../../features/installations/presentation/installation_detail_screen.dart';
import '../../features/installations/presentation/installation_list_screen.dart';
import '../../features/installations/presentation/installation_scan_screen.dart';
import '../../features/measurements/presentation/measurement_screen.dart';
import '../../features/materials/presentation/material_screen.dart';
import '../../features/objects/presentation/object_detail_screen.dart';
import '../../features/objects/presentation/object_list_screen.dart';
import '../../features/photos/presentation/photo_detail_screen.dart';
import '../../features/photos/presentation/photo_screen.dart';
import '../../features/reports/presentation/report_screen.dart';
import '../../features/search/presentation/search_screen.dart';
import '../../features/settings/presentation/profile_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/signatures/presentation/signature_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/sync_status/presentation/initial_sync_screen.dart';
import '../../features/sync_status/presentation/sync_status_screen.dart';
import '../../features/time_entries/presentation/time_entry_screen.dart';
import '../../features/work_orders/presentation/offline_route_map_screen.dart';
import '../../features/work_orders/presentation/work_order_completion_screen.dart';
import '../../features/work_orders/presentation/work_order_detail_screen.dart';
import '../../features/work_orders/presentation/work_order_list_screen.dart';
import '../../l10n/app_localizations_x.dart';

abstract final class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const initialSync = '/sync-initial';
  static const dashboard = '/dashboard';
  static const offlineRouteMap = '/routes/offline-map';
  static const workOrders = '/work-orders';
  static const workOrderDetail = '/work-orders/:workOrderId';
  static const workOrderChecklist = '/work-orders/:workOrderId/checklist';
  static const workOrderMeasurements = '/work-orders/:workOrderId/measurements';
  static const workOrderDefects = '/work-orders/:workOrderId/defects';
  static const workOrderPhotos = '/work-orders/:workOrderId/photos';
  static const workOrderPhotoDetail =
      '/work-orders/:workOrderId/photos/:photoId';
  static const workOrderTime = '/work-orders/:workOrderId/time';
  static const workOrderMaterials = '/work-orders/:workOrderId/materials';
  static const workOrderReport = '/work-orders/:workOrderId/report';
  static const workOrderSignature = '/work-orders/:workOrderId/signature';
  static const workOrderComplete = '/work-orders/:workOrderId/complete';
  static const customers = '/customers';
  static const customerDetail = '/customers/:customerId';
  static const objects = '/objects';
  static const objectDetail = '/objects/:objectId';
  static const installations = '/installations';
  static const installationScan = '/installations/scan';
  static const installationDetail = '/installations/:installationId';
  static const settings = '/settings';
  static const syncStatus = '/settings/sync';
  static const settingsProfile = '/settings/profile';
  static const search = '/search';

  static String workOrderDetailPath(String workOrderId) {
    return '/work-orders/$workOrderId';
  }

  static String workOrderChecklistPath(String workOrderId) {
    return '/work-orders/$workOrderId/checklist';
  }

  static String workOrderMeasurementsPath(String workOrderId) {
    return '/work-orders/$workOrderId/measurements';
  }

  static String workOrderDefectsPath(String workOrderId) {
    return '/work-orders/$workOrderId/defects';
  }

  static String workOrderPhotosPath(String workOrderId) {
    return '/work-orders/$workOrderId/photos';
  }

  static String workOrderPhotoDetailPath(String workOrderId, String photoId) {
    return '/work-orders/$workOrderId/photos/$photoId';
  }

  static String workOrderTimePath(String workOrderId) {
    return '/work-orders/$workOrderId/time';
  }

  static String workOrderMaterialsPath(String workOrderId) {
    return '/work-orders/$workOrderId/materials';
  }

  static String workOrderReportPath(String workOrderId) {
    return '/work-orders/$workOrderId/report';
  }

  static String workOrderSignaturePath(String workOrderId) {
    return '/work-orders/$workOrderId/signature';
  }

  static String workOrderCompletePath(String workOrderId) {
    return '/work-orders/$workOrderId/complete';
  }

  static String customerDetailPath(String customerId) {
    return '/customers/$customerId';
  }

  static String objectDetailPath(String objectId) {
    return '/objects/$objectId';
  }

  static String installationDetailPath(String installationId) {
    return '/installations/$installationId';
  }

  static Uri deepLinkUri(String path) {
    return Uri(scheme: 'kaminfeger', host: 'app', path: path);
  }
}

final appRouter = createAppRouter();

GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: authSessionController,
    redirect: (context, state) {
      final location = state.uri.path;
      final publicRoutes = {AppRoutes.splash, AppRoutes.login};
      if (publicRoutes.contains(location)) {
        return null;
      }
      if (!authSessionController.isAuthenticated) {
        return AppRoutes.login;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: SplashScreen()),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        pageBuilder: (context, state) =>
            _fadePage(key: state.pageKey, child: const LoginScreen()),
      ),
      GoRoute(
        path: AppRoutes.initialSync,
        name: 'sync-initial',
        pageBuilder: (context, state) =>
            _fadePage(key: state.pageKey, child: const InitialSyncScreen()),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        name: 'dashboard',
        pageBuilder: (context, state) =>
            _fadePage(key: state.pageKey, child: const DashboardScreen()),
      ),
      GoRoute(
        path: AppRoutes.offlineRouteMap,
        name: 'offline-route-map',
        pageBuilder: (context, state) =>
            _fadePage(key: state.pageKey, child: const OfflineRouteMapScreen()),
      ),
      GoRoute(
        path: AppRoutes.workOrders,
        name: 'work-orders',
        pageBuilder: (context, state) =>
            _fadePage(key: state.pageKey, child: const WorkOrderListScreen()),
      ),
      GoRoute(
        path: AppRoutes.workOrderDetail,
        name: 'work-order-detail',
        pageBuilder: (context, state) {
          final workOrderId = state.pathParameters['workOrderId'] ?? '';
          return _fadePage(
            key: state.pageKey,
            child: WorkOrderDetailScreen(workOrderId: workOrderId),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.workOrderChecklist,
        name: 'work-order-checklist',
        pageBuilder: (context, state) {
          final workOrderId = state.pathParameters['workOrderId'] ?? '';
          return _fadePage(
            key: state.pageKey,
            child: ChecklistScreen(workOrderId: workOrderId),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.workOrderMeasurements,
        name: 'work-order-measurements',
        pageBuilder: (context, state) {
          final workOrderId = state.pathParameters['workOrderId'] ?? '';
          return _fadePage(
            key: state.pageKey,
            child: MeasurementScreen(workOrderId: workOrderId),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.workOrderDefects,
        name: 'work-order-defects',
        pageBuilder: (context, state) {
          final workOrderId = state.pathParameters['workOrderId'] ?? '';
          return _fadePage(
            key: state.pageKey,
            child: DefectScreen(workOrderId: workOrderId),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.workOrderPhotos,
        name: 'work-order-photos',
        pageBuilder: (context, state) {
          final workOrderId = state.pathParameters['workOrderId'] ?? '';
          return _fadePage(
            key: state.pageKey,
            child: PhotoScreen(workOrderId: workOrderId),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.workOrderPhotoDetail,
        name: 'work-order-photo-detail',
        pageBuilder: (context, state) {
          final photoId = state.pathParameters['photoId'] ?? '';
          return _fadePage(
            key: state.pageKey,
            child: PhotoDetailScreen(photoId: photoId),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.workOrderTime,
        name: 'work-order-time',
        pageBuilder: (context, state) {
          final workOrderId = state.pathParameters['workOrderId'] ?? '';
          return _fadePage(
            key: state.pageKey,
            child: TimeEntryScreen(workOrderId: workOrderId),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.workOrderMaterials,
        name: 'work-order-materials',
        pageBuilder: (context, state) {
          final workOrderId = state.pathParameters['workOrderId'] ?? '';
          return _fadePage(
            key: state.pageKey,
            child: MaterialScreen(workOrderId: workOrderId),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.workOrderReport,
        name: 'work-order-report',
        pageBuilder: (context, state) {
          final workOrderId = state.pathParameters['workOrderId'] ?? '';
          return _fadePage(
            key: state.pageKey,
            child: ReportScreen(workOrderId: workOrderId),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.workOrderSignature,
        name: 'work-order-signature',
        pageBuilder: (context, state) {
          final workOrderId = state.pathParameters['workOrderId'] ?? '';
          return _fadePage(
            key: state.pageKey,
            child: SignatureScreen(workOrderId: workOrderId),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.workOrderComplete,
        name: 'work-order-complete',
        pageBuilder: (context, state) {
          final workOrderId = state.pathParameters['workOrderId'] ?? '';
          return _fadePage(
            key: state.pageKey,
            child: WorkOrderCompletionScreen(workOrderId: workOrderId),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.customers,
        name: 'customers',
        pageBuilder: (context, state) =>
            _fadePage(key: state.pageKey, child: const CustomerListScreen()),
      ),
      GoRoute(
        path: AppRoutes.customerDetail,
        name: 'customer-detail',
        pageBuilder: (context, state) {
          final customerId = state.pathParameters['customerId'] ?? '';
          return _fadePage(
            key: state.pageKey,
            child: CustomerDetailScreen(customerId: customerId),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.objects,
        name: 'objects',
        pageBuilder: (context, state) =>
            _fadePage(key: state.pageKey, child: const ObjectListScreen()),
      ),
      GoRoute(
        path: AppRoutes.objectDetail,
        name: 'object-detail',
        pageBuilder: (context, state) {
          final objectId = state.pathParameters['objectId'] ?? '';
          return _fadePage(
            key: state.pageKey,
            child: ObjectDetailScreen(objectId: objectId),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.installations,
        name: 'installations',
        pageBuilder: (context, state) => _fadePage(
          key: state.pageKey,
          child: const InstallationListScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.installationScan,
        name: 'installation-scan',
        pageBuilder: (context, state) => _fadePage(
          key: state.pageKey,
          child: const InstallationScanScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.installationDetail,
        name: 'installation-detail',
        pageBuilder: (context, state) {
          final installationId = state.pathParameters['installationId'] ?? '';
          return _fadePage(
            key: state.pageKey,
            child: InstallationDetailScreen(installationId: installationId),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.search,
        name: 'search',
        pageBuilder: (context, state) =>
            _fadePage(key: state.pageKey, child: const SearchScreen()),
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        pageBuilder: (context, state) =>
            _fadePage(key: state.pageKey, child: const SettingsScreen()),
      ),
      GoRoute(
        path: AppRoutes.syncStatus,
        name: 'sync-status',
        pageBuilder: (context, state) =>
            _fadePage(key: state.pageKey, child: const SyncStatusScreen()),
      ),
      GoRoute(
        path: AppRoutes.settingsProfile,
        name: 'settings-profile',
        pageBuilder: (context, state) =>
            _fadePage(key: state.pageKey, child: const ProfileScreen()),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: Text(context.l10n.notFoundTitle)),
      body: Center(
        child: FilledButton(
          onPressed: () => context.go(AppRoutes.dashboard),
          child: Text(context.l10n.backToDashboardAction),
        ),
      ),
    ),
  );
}

CustomTransitionPage<void> _fadePage({
  required LocalKey key,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: key,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

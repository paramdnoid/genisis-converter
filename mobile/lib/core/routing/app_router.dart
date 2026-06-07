import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/checklists/presentation/checklist_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/measurements/presentation/measurement_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/work_orders/presentation/work_order_detail_screen.dart';
import '../../features/work_orders/presentation/work_order_list_screen.dart';

abstract final class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const dashboard = '/dashboard';
  static const workOrders = '/work-orders';
  static const workOrderDetail = '/work-orders/:workOrderId';
  static const workOrderChecklist = '/work-orders/:workOrderId/checklist';
  static const workOrderMeasurements = '/work-orders/:workOrderId/measurements';

  static String workOrderDetailPath(String workOrderId) {
    return '/work-orders/$workOrderId';
  }

  static String workOrderChecklistPath(String workOrderId) {
    return '/work-orders/$workOrderId/checklist';
  }

  static String workOrderMeasurementsPath(String workOrderId) {
    return '/work-orders/$workOrderId/measurements';
  }
}

final appRouter = createAppRouter();

GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: AppRoutes.splash,
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
        path: AppRoutes.dashboard,
        name: 'dashboard',
        pageBuilder: (context, state) =>
            _fadePage(key: state.pageKey, child: const DashboardScreen()),
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
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Seite nicht gefunden')),
      body: Center(
        child: FilledButton(
          onPressed: () => context.go(AppRoutes.dashboard),
          child: const Text('Zum Dashboard'),
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

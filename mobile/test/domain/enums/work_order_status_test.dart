import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/domain/enums/work_order_status.dart';

void main() {
  group('WorkOrderStatus', () {
    test('parses known values and falls back to unknown', () {
      expect(WorkOrderStatus.parse('scheduled'), WorkOrderStatus.scheduled);
      expect(WorkOrderStatus.parse('in_progress'), WorkOrderStatus.inProgress);
      expect(WorkOrderStatus.parse('missing'), WorkOrderStatus.unknown);
    });

    test('exposes allowed status transitions for field actions', () {
      expect(WorkOrderStatus.scheduled.canStart, isTrue);
      expect(WorkOrderStatus.inProgress.canStart, isFalse);
      expect(WorkOrderStatus.inProgress.canPause, isTrue);
      expect(WorkOrderStatus.paused.canResume, isTrue);
      expect(WorkOrderStatus.inProgress.canComplete, isTrue);
      expect(WorkOrderStatus.completed.canComplete, isFalse);
    });
  });
}

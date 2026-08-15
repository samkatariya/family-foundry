import '../models/action_item.dart';
import '../local/mock_data.dart';
import 'action_item_repository.dart';

class MockActionItemRepository implements ActionItemRepository {
  @override
  Future<List<ActionItem>> getAllActionItems() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.unmodifiable(mockActionItems);
  }

  @override
  Future<List<ActionItem>> getActionsForExperiment(String experimentId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return mockActionItems
        .where((a) => a.relatedExperimentId == experimentId)
        .toList();
  }
}

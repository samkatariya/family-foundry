import '../models/action_item.dart';

abstract class ActionItemRepository {
  Future<List<ActionItem>> getAllActionItems();
  Future<List<ActionItem>> getActionsForExperiment(String experimentId);
}

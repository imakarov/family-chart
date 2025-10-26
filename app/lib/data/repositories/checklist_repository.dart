import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/providers/isar_provider.dart';
import '../models/checklists.dart';

part 'checklist_repository.g.dart';

/// Repository for checklist operations
@riverpod
ChecklistRepository checklistRepository(ChecklistRepositoryRef ref) {
  final isar = ref.watch(isarProvider).requireValue;
  return ChecklistRepository(isar);
}

class ChecklistRepository {
  final Isar _isar;

  ChecklistRepository(this._isar);

  /// Get all checklists
  Future<List<Checklists>> getAllChecklists() async {
    return await _isar.checklists.where().findAll();
  }

  /// Get checklist by ID
  Future<Checklists?> getChecklistById(int checklistId) async {
    return await _isar.checklists.get(checklistId);
  }

  /// Get active checklists (not archived)
  Future<List<Checklists>> getActiveChecklists() async {
    return await _isar.checklists
        .filter()
        .isArchivedEqualTo(false)
        .findAll();
  }

  /// Create or update checklist
  Future<void> saveChecklist(Checklists checklist) async {
    checklist.modifiedAt = DateTime.now();

    await _isar.writeTxn(() async {
      await _isar.checklists.put(checklist);
    });
  }

  /// Delete checklist
  Future<void> deleteChecklist(int checklistId) async {
    await _isar.writeTxn(() async {
      await _isar.checklists.delete(checklistId);
    });
  }

  /// Watch checklists (stream for reactive updates)
  Stream<List<Checklists>> watchChecklists() {
    return _isar.checklists.where().watch(fireImmediately: true);
  }

  /// Watch active checklists
  Stream<List<Checklists>> watchActiveChecklists() {
    return _isar.checklists
        .filter()
        .isArchivedEqualTo(false)
        .watch(fireImmediately: true);
  }
}

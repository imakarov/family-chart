import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/providers/isar_provider.dart';
import '../models/checklist.dart';

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
  Future<List<Checklist>> getAllChecklists() async {
    return await _isar.checklists.where().findAll();
  }

  /// Get checklist by ID
  Future<Checklist?> getChecklistById(String checklistId) async {
    return await _isar.checklists
        .filter()
        .checklistIdEqualTo(checklistId)
        .findFirst();
  }

  /// Get active checklists (not ended)
  Future<List<Checklist>> getActiveChecklists() async {
    final now = DateTime.now();
    return await _isar.checklists
        .filter()
        .endDateGreaterThan(now)
        .findAll();
  }

  /// Create or update checklist
  Future<void> saveChecklist(Checklist checklist) async {
    checklist.modifiedAt = DateTime.now();

    await _isar.writeTxn(() async {
      await _isar.checklists.put(checklist);
    });
  }

  /// Delete checklist
  Future<void> deleteChecklist(String checklistId) async {
    final checklist = await getChecklistById(checklistId);
    if (checklist == null) return;

    await _isar.writeTxn(() async {
      await _isar.checklists.delete(checklist.id);
    });
  }

  /// Get checklist with all related data (persons, tasks)
  Future<Checklist?> getChecklistWithRelations(String checklistId) async {
    final checklist = await getChecklistById(checklistId);
    if (checklist == null) return null;

    // Load relations
    await checklist.persons.load();
    await checklist.tasks.load();

    // Load task assignments
    for (final task in checklist.tasks) {
      await task.assignedTo.load();
    }

    return checklist;
  }

  /// Watch checklists (stream for reactive updates)
  Stream<List<Checklist>> watchChecklists() {
    return _isar.checklists.where().watch(fireImmediately: true);
  }

  /// Watch active checklists
  Stream<List<Checklist>> watchActiveChecklists() {
    final now = DateTime.now();
    return _isar.checklists
        .filter()
        .endDateGreaterThan(now)
        .watch(fireImmediately: true);
  }
}

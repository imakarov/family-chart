import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/providers/isar_provider.dart';
import '../models/achievements.dart';

part 'achievements_repository.g.dart';

/// Repository for achievements operations
@riverpod
AchievementsRepository achievementsRepository(AchievementsRepositoryRef ref) {
  final isar = ref.watch(isarProvider).requireValue;
  return AchievementsRepository(isar);
}

class AchievementsRepository {
  final Isar _isar;

  AchievementsRepository(this._isar);

  /// Get all achievements for a user
  Future<List<Achievements>> getAchievementsByUserId(int userId) async {
    return await _isar.achievements
        .filter()
        .userIdEqualTo(userId)
        .sortByEarnedAtDesc()
        .findAll();
  }

  /// Get achievements for a user in a specific week
  Future<List<Achievements>> getAchievementsByUserAndWeek(
    int userId,
    int weekNumber,
    int weekYear,
  ) async {
    return await _isar.achievements
        .filter()
        .userIdEqualTo(userId)
        .weekNumberEqualTo(weekNumber)
        .weekYearEqualTo(weekYear)
        .sortByEarnedAtDesc()
        .findAll();
  }

  /// Get achievement by ID
  Future<Achievements?> getAchievementById(int achievementId) async {
    return await _isar.achievements.get(achievementId);
  }

  /// Create achievement
  Future<void> saveAchievement(Achievements achievement) async {
    await _isar.writeTxn(() async {
      await _isar.achievements.put(achievement);
    });
  }

  /// Delete achievement
  Future<void> deleteAchievement(int achievementId) async {
    await _isar.writeTxn(() async {
      await _isar.achievements.delete(achievementId);
    });
  }

  /// Watch achievements for a user (stream)
  Stream<List<Achievements>> watchAchievementsByUserId(int userId) {
    return _isar.achievements
        .filter()
        .userIdEqualTo(userId)
        .sortByEarnedAtDesc()
        .watch(fireImmediately: true);
  }
}

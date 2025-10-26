import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/providers/isar_provider.dart';
import '../models/users.dart';

part 'users_repository.g.dart';

/// Repository for users (family members) operations
@riverpod
UsersRepository usersRepository(UsersRepositoryRef ref) {
  final isar = ref.watch(isarProvider).requireValue;
  return UsersRepository(isar);
}

class UsersRepository {
  final Isar _isar;

  UsersRepository(this._isar);

  /// Get all users
  Future<List<Users>> getAllUsers() async {
    return await _isar.users.where().sortBySortOrder().findAll();
  }

  /// Get user by ID
  Future<Users?> getUserById(int userId) async {
    return await _isar.users.get(userId);
  }

  /// Create or update user
  Future<void> saveUser(Users user) async {
    user.modifiedAt = DateTime.now();

    await _isar.writeTxn(() async {
      await _isar.users.put(user);
    });
  }

  /// Delete user
  Future<void> deleteUser(int userId) async {
    await _isar.writeTxn(() async {
      await _isar.users.delete(userId);
    });
  }

  /// Watch users (stream for reactive updates)
  Stream<List<Users>> watchUsers() {
    return _isar.users.where().sortBySortOrder().watch(fireImmediately: true);
  }
}

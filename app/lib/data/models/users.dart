import 'package:isar/isar.dart';

part 'users.g.dart';

/// Users model - represents family members
@collection
class Users {
  Id userId = Isar.autoIncrement; // Primary key, auto-increment

  late String name;

  List<byte>? avatarBytes; // Photo as bytes

  late String colorHex; // Color in hex format (#FF5733)

  String? relation; // daughter, son, parent, nanny

  String? contactId; // Reference to Contacts app

  late int sortOrder; // Display order in UI

  late DateTime createdAt;

  late DateTime modifiedAt;

  String? cloudKitRecordId; // For CloudKit sync
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklists.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetChecklistsCollection on Isar {
  IsarCollection<Checklists> get checklists => this.collection();
}

const ChecklistsSchema = CollectionSchema(
  name: r'Checklists',
  id: -7927221241247255657,
  properties: {
    r'cloudKitRecordId': PropertySchema(
      id: 0,
      name: r'cloudKitRecordId',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'isArchived': PropertySchema(
      id: 2,
      name: r'isArchived',
      type: IsarType.bool,
    ),
    r'isRepeating': PropertySchema(
      id: 3,
      name: r'isRepeating',
      type: IsarType.bool,
    ),
    r'modifiedAt': PropertySchema(
      id: 4,
      name: r'modifiedAt',
      type: IsarType.dateTime,
    ),
    r'name': PropertySchema(
      id: 5,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _checklistsEstimateSize,
  serialize: _checklistsSerialize,
  deserialize: _checklistsDeserialize,
  deserializeProp: _checklistsDeserializeProp,
  idName: r'checklistId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _checklistsGetId,
  getLinks: _checklistsGetLinks,
  attach: _checklistsAttach,
  version: '3.1.0+1',
);

int _checklistsEstimateSize(
  Checklists object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.cloudKitRecordId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _checklistsSerialize(
  Checklists object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.cloudKitRecordId);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeBool(offsets[2], object.isArchived);
  writer.writeBool(offsets[3], object.isRepeating);
  writer.writeDateTime(offsets[4], object.modifiedAt);
  writer.writeString(offsets[5], object.name);
}

Checklists _checklistsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Checklists();
  object.checklistId = id;
  object.cloudKitRecordId = reader.readStringOrNull(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.isArchived = reader.readBool(offsets[2]);
  object.isRepeating = reader.readBool(offsets[3]);
  object.modifiedAt = reader.readDateTime(offsets[4]);
  object.name = reader.readString(offsets[5]);
  return object;
}

P _checklistsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _checklistsGetId(Checklists object) {
  return object.checklistId;
}

List<IsarLinkBase<dynamic>> _checklistsGetLinks(Checklists object) {
  return [];
}

void _checklistsAttach(IsarCollection<dynamic> col, Id id, Checklists object) {
  object.checklistId = id;
}

extension ChecklistsQueryWhereSort
    on QueryBuilder<Checklists, Checklists, QWhere> {
  QueryBuilder<Checklists, Checklists, QAfterWhere> anyChecklistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ChecklistsQueryWhere
    on QueryBuilder<Checklists, Checklists, QWhereClause> {
  QueryBuilder<Checklists, Checklists, QAfterWhereClause> checklistIdEqualTo(
      Id checklistId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: checklistId,
        upper: checklistId,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterWhereClause> checklistIdNotEqualTo(
      Id checklistId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: checklistId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: checklistId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: checklistId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: checklistId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterWhereClause>
      checklistIdGreaterThan(Id checklistId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: checklistId, includeLower: include),
      );
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterWhereClause> checklistIdLessThan(
      Id checklistId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: checklistId, includeUpper: include),
      );
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterWhereClause> checklistIdBetween(
    Id lowerChecklistId,
    Id upperChecklistId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerChecklistId,
        includeLower: includeLower,
        upper: upperChecklistId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ChecklistsQueryFilter
    on QueryBuilder<Checklists, Checklists, QFilterCondition> {
  QueryBuilder<Checklists, Checklists, QAfterFilterCondition>
      checklistIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'checklistId',
        value: value,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition>
      checklistIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'checklistId',
        value: value,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition>
      checklistIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'checklistId',
        value: value,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition>
      checklistIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'checklistId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition>
      cloudKitRecordIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cloudKitRecordId',
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition>
      cloudKitRecordIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cloudKitRecordId',
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition>
      cloudKitRecordIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cloudKitRecordId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition>
      cloudKitRecordIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cloudKitRecordId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition>
      cloudKitRecordIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cloudKitRecordId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition>
      cloudKitRecordIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cloudKitRecordId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition>
      cloudKitRecordIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cloudKitRecordId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition>
      cloudKitRecordIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cloudKitRecordId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition>
      cloudKitRecordIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cloudKitRecordId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition>
      cloudKitRecordIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cloudKitRecordId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition>
      cloudKitRecordIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cloudKitRecordId',
        value: '',
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition>
      cloudKitRecordIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cloudKitRecordId',
        value: '',
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition> isArchivedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isArchived',
        value: value,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition>
      isRepeatingEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRepeating',
        value: value,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition> modifiedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modifiedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition>
      modifiedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'modifiedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition>
      modifiedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'modifiedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition> modifiedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'modifiedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension ChecklistsQueryObject
    on QueryBuilder<Checklists, Checklists, QFilterCondition> {}

extension ChecklistsQueryLinks
    on QueryBuilder<Checklists, Checklists, QFilterCondition> {}

extension ChecklistsQuerySortBy
    on QueryBuilder<Checklists, Checklists, QSortBy> {
  QueryBuilder<Checklists, Checklists, QAfterSortBy> sortByCloudKitRecordId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cloudKitRecordId', Sort.asc);
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterSortBy>
      sortByCloudKitRecordIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cloudKitRecordId', Sort.desc);
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterSortBy> sortByIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.asc);
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterSortBy> sortByIsArchivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.desc);
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterSortBy> sortByIsRepeating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRepeating', Sort.asc);
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterSortBy> sortByIsRepeatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRepeating', Sort.desc);
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterSortBy> sortByModifiedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedAt', Sort.asc);
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterSortBy> sortByModifiedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedAt', Sort.desc);
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension ChecklistsQuerySortThenBy
    on QueryBuilder<Checklists, Checklists, QSortThenBy> {
  QueryBuilder<Checklists, Checklists, QAfterSortBy> thenByChecklistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistId', Sort.asc);
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterSortBy> thenByChecklistIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistId', Sort.desc);
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterSortBy> thenByCloudKitRecordId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cloudKitRecordId', Sort.asc);
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterSortBy>
      thenByCloudKitRecordIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cloudKitRecordId', Sort.desc);
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterSortBy> thenByIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.asc);
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterSortBy> thenByIsArchivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.desc);
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterSortBy> thenByIsRepeating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRepeating', Sort.asc);
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterSortBy> thenByIsRepeatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRepeating', Sort.desc);
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterSortBy> thenByModifiedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedAt', Sort.asc);
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterSortBy> thenByModifiedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedAt', Sort.desc);
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Checklists, Checklists, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension ChecklistsQueryWhereDistinct
    on QueryBuilder<Checklists, Checklists, QDistinct> {
  QueryBuilder<Checklists, Checklists, QDistinct> distinctByCloudKitRecordId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cloudKitRecordId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Checklists, Checklists, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Checklists, Checklists, QDistinct> distinctByIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isArchived');
    });
  }

  QueryBuilder<Checklists, Checklists, QDistinct> distinctByIsRepeating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRepeating');
    });
  }

  QueryBuilder<Checklists, Checklists, QDistinct> distinctByModifiedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modifiedAt');
    });
  }

  QueryBuilder<Checklists, Checklists, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension ChecklistsQueryProperty
    on QueryBuilder<Checklists, Checklists, QQueryProperty> {
  QueryBuilder<Checklists, int, QQueryOperations> checklistIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'checklistId');
    });
  }

  QueryBuilder<Checklists, String?, QQueryOperations>
      cloudKitRecordIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cloudKitRecordId');
    });
  }

  QueryBuilder<Checklists, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Checklists, bool, QQueryOperations> isArchivedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isArchived');
    });
  }

  QueryBuilder<Checklists, bool, QQueryOperations> isRepeatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRepeating');
    });
  }

  QueryBuilder<Checklists, DateTime, QQueryOperations> modifiedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modifiedAt');
    });
  }

  QueryBuilder<Checklists, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}

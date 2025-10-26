// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievements.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAchievementsCollection on Isar {
  IsarCollection<Achievements> get achievements => this.collection();
}

const AchievementsSchema = CollectionSchema(
  name: r'Achievements',
  id: -2330568277534188503,
  properties: {
    r'checklistId': PropertySchema(
      id: 0,
      name: r'checklistId',
      type: IsarType.long,
    ),
    r'description': PropertySchema(
      id: 1,
      name: r'description',
      type: IsarType.string,
    ),
    r'earnedAt': PropertySchema(
      id: 2,
      name: r'earnedAt',
      type: IsarType.dateTime,
    ),
    r'earnedDate': PropertySchema(
      id: 3,
      name: r'earnedDate',
      type: IsarType.dateTime,
    ),
    r'iconName': PropertySchema(
      id: 4,
      name: r'iconName',
      type: IsarType.string,
    ),
    r'metadata': PropertySchema(
      id: 5,
      name: r'metadata',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 6,
      name: r'title',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 7,
      name: r'type',
      type: IsarType.string,
      enumMap: _AchievementstypeEnumValueMap,
    ),
    r'userId': PropertySchema(
      id: 8,
      name: r'userId',
      type: IsarType.long,
    ),
    r'weekNumber': PropertySchema(
      id: 9,
      name: r'weekNumber',
      type: IsarType.long,
    ),
    r'weekYear': PropertySchema(
      id: 10,
      name: r'weekYear',
      type: IsarType.long,
    )
  },
  estimateSize: _achievementsEstimateSize,
  serialize: _achievementsSerialize,
  deserialize: _achievementsDeserialize,
  deserializeProp: _achievementsDeserializeProp,
  idName: r'achievementId',
  indexes: {
    r'userId': IndexSchema(
      id: -2005826577402374815,
      name: r'userId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'weekNumber': IndexSchema(
      id: 3113799900175558897,
      name: r'weekNumber',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'weekNumber',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'weekYear': IndexSchema(
      id: -9158079483598940145,
      name: r'weekYear',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'weekYear',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _achievementsGetId,
  getLinks: _achievementsGetLinks,
  attach: _achievementsAttach,
  version: '3.1.0+1',
);

int _achievementsEstimateSize(
  Achievements object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.iconName.length * 3;
  {
    final value = object.metadata;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.type.name.length * 3;
  return bytesCount;
}

void _achievementsSerialize(
  Achievements object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.checklistId);
  writer.writeString(offsets[1], object.description);
  writer.writeDateTime(offsets[2], object.earnedAt);
  writer.writeDateTime(offsets[3], object.earnedDate);
  writer.writeString(offsets[4], object.iconName);
  writer.writeString(offsets[5], object.metadata);
  writer.writeString(offsets[6], object.title);
  writer.writeString(offsets[7], object.type.name);
  writer.writeLong(offsets[8], object.userId);
  writer.writeLong(offsets[9], object.weekNumber);
  writer.writeLong(offsets[10], object.weekYear);
}

Achievements _achievementsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Achievements();
  object.achievementId = id;
  object.checklistId = reader.readLongOrNull(offsets[0]);
  object.description = reader.readStringOrNull(offsets[1]);
  object.earnedAt = reader.readDateTime(offsets[2]);
  object.earnedDate = reader.readDateTime(offsets[3]);
  object.iconName = reader.readString(offsets[4]);
  object.metadata = reader.readStringOrNull(offsets[5]);
  object.title = reader.readString(offsets[6]);
  object.type =
      _AchievementstypeValueEnumMap[reader.readStringOrNull(offsets[7])] ??
          AchievementType.streak5days;
  object.userId = reader.readLong(offsets[8]);
  object.weekNumber = reader.readLong(offsets[9]);
  object.weekYear = reader.readLong(offsets[10]);
  return object;
}

P _achievementsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (_AchievementstypeValueEnumMap[reader.readStringOrNull(offset)] ??
          AchievementType.streak5days) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _AchievementstypeEnumValueMap = {
  r'streak5days': r'streak5days',
  r'week100percent': r'week100percent',
  r'team90percent': r'team90percent',
  r'custom': r'custom',
};
const _AchievementstypeValueEnumMap = {
  r'streak5days': AchievementType.streak5days,
  r'week100percent': AchievementType.week100percent,
  r'team90percent': AchievementType.team90percent,
  r'custom': AchievementType.custom,
};

Id _achievementsGetId(Achievements object) {
  return object.achievementId;
}

List<IsarLinkBase<dynamic>> _achievementsGetLinks(Achievements object) {
  return [];
}

void _achievementsAttach(
    IsarCollection<dynamic> col, Id id, Achievements object) {
  object.achievementId = id;
}

extension AchievementsQueryWhereSort
    on QueryBuilder<Achievements, Achievements, QWhere> {
  QueryBuilder<Achievements, Achievements, QAfterWhere> anyAchievementId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterWhere> anyUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'userId'),
      );
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterWhere> anyWeekNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'weekNumber'),
      );
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterWhere> anyWeekYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'weekYear'),
      );
    });
  }
}

extension AchievementsQueryWhere
    on QueryBuilder<Achievements, Achievements, QWhereClause> {
  QueryBuilder<Achievements, Achievements, QAfterWhereClause>
      achievementIdEqualTo(Id achievementId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: achievementId,
        upper: achievementId,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterWhereClause>
      achievementIdNotEqualTo(Id achievementId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: achievementId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: achievementId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: achievementId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: achievementId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterWhereClause>
      achievementIdGreaterThan(Id achievementId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: achievementId, includeLower: include),
      );
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterWhereClause>
      achievementIdLessThan(Id achievementId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: achievementId, includeUpper: include),
      );
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterWhereClause>
      achievementIdBetween(
    Id lowerAchievementId,
    Id upperAchievementId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerAchievementId,
        includeLower: includeLower,
        upper: upperAchievementId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterWhereClause> userIdEqualTo(
      int userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterWhereClause> userIdNotEqualTo(
      int userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterWhereClause> userIdGreaterThan(
    int userId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'userId',
        lower: [userId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterWhereClause> userIdLessThan(
    int userId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'userId',
        lower: [],
        upper: [userId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterWhereClause> userIdBetween(
    int lowerUserId,
    int upperUserId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'userId',
        lower: [lowerUserId],
        includeLower: includeLower,
        upper: [upperUserId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterWhereClause> weekNumberEqualTo(
      int weekNumber) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'weekNumber',
        value: [weekNumber],
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterWhereClause>
      weekNumberNotEqualTo(int weekNumber) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'weekNumber',
              lower: [],
              upper: [weekNumber],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'weekNumber',
              lower: [weekNumber],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'weekNumber',
              lower: [weekNumber],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'weekNumber',
              lower: [],
              upper: [weekNumber],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterWhereClause>
      weekNumberGreaterThan(
    int weekNumber, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'weekNumber',
        lower: [weekNumber],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterWhereClause>
      weekNumberLessThan(
    int weekNumber, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'weekNumber',
        lower: [],
        upper: [weekNumber],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterWhereClause> weekNumberBetween(
    int lowerWeekNumber,
    int upperWeekNumber, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'weekNumber',
        lower: [lowerWeekNumber],
        includeLower: includeLower,
        upper: [upperWeekNumber],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterWhereClause> weekYearEqualTo(
      int weekYear) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'weekYear',
        value: [weekYear],
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterWhereClause>
      weekYearNotEqualTo(int weekYear) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'weekYear',
              lower: [],
              upper: [weekYear],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'weekYear',
              lower: [weekYear],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'weekYear',
              lower: [weekYear],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'weekYear',
              lower: [],
              upper: [weekYear],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterWhereClause>
      weekYearGreaterThan(
    int weekYear, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'weekYear',
        lower: [weekYear],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterWhereClause> weekYearLessThan(
    int weekYear, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'weekYear',
        lower: [],
        upper: [weekYear],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterWhereClause> weekYearBetween(
    int lowerWeekYear,
    int upperWeekYear, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'weekYear',
        lower: [lowerWeekYear],
        includeLower: includeLower,
        upper: [upperWeekYear],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AchievementsQueryFilter
    on QueryBuilder<Achievements, Achievements, QFilterCondition> {
  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      achievementIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'achievementId',
        value: value,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      achievementIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'achievementId',
        value: value,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      achievementIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'achievementId',
        value: value,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      achievementIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'achievementId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      checklistIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'checklistId',
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      checklistIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'checklistId',
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      checklistIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'checklistId',
        value: value,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      checklistIdGreaterThan(
    int? value, {
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

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      checklistIdLessThan(
    int? value, {
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

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      checklistIdBetween(
    int? lower,
    int? upper, {
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

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      earnedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'earnedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      earnedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'earnedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      earnedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'earnedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      earnedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'earnedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      earnedDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'earnedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      earnedDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'earnedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      earnedDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'earnedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      earnedDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'earnedDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      iconNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      iconNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'iconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      iconNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'iconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      iconNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'iconName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      iconNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'iconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      iconNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'iconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      iconNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'iconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      iconNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'iconName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      iconNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconName',
        value: '',
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      iconNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'iconName',
        value: '',
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      metadataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'metadata',
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      metadataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'metadata',
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      metadataEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'metadata',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      metadataGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'metadata',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      metadataLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'metadata',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      metadataBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'metadata',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      metadataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'metadata',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      metadataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'metadata',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      metadataContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'metadata',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      metadataMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'metadata',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      metadataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'metadata',
        value: '',
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      metadataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'metadata',
        value: '',
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition> typeEqualTo(
    AchievementType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      typeGreaterThan(
    AchievementType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition> typeLessThan(
    AchievementType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition> typeBetween(
    AchievementType lower,
    AchievementType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition> userIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      userIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      userIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition> userIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      weekNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weekNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      weekNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weekNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      weekNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weekNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      weekNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weekNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      weekYearEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weekYear',
        value: value,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      weekYearGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weekYear',
        value: value,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      weekYearLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weekYear',
        value: value,
      ));
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterFilterCondition>
      weekYearBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weekYear',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AchievementsQueryObject
    on QueryBuilder<Achievements, Achievements, QFilterCondition> {}

extension AchievementsQueryLinks
    on QueryBuilder<Achievements, Achievements, QFilterCondition> {}

extension AchievementsQuerySortBy
    on QueryBuilder<Achievements, Achievements, QSortBy> {
  QueryBuilder<Achievements, Achievements, QAfterSortBy> sortByChecklistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistId', Sort.asc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy>
      sortByChecklistIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistId', Sort.desc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> sortByEarnedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'earnedAt', Sort.asc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> sortByEarnedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'earnedAt', Sort.desc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> sortByEarnedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'earnedDate', Sort.asc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy>
      sortByEarnedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'earnedDate', Sort.desc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> sortByIconName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconName', Sort.asc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> sortByIconNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconName', Sort.desc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> sortByMetadata() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metadata', Sort.asc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> sortByMetadataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metadata', Sort.desc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> sortByWeekNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekNumber', Sort.asc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy>
      sortByWeekNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekNumber', Sort.desc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> sortByWeekYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekYear', Sort.asc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> sortByWeekYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekYear', Sort.desc);
    });
  }
}

extension AchievementsQuerySortThenBy
    on QueryBuilder<Achievements, Achievements, QSortThenBy> {
  QueryBuilder<Achievements, Achievements, QAfterSortBy> thenByAchievementId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementId', Sort.asc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy>
      thenByAchievementIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementId', Sort.desc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> thenByChecklistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistId', Sort.asc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy>
      thenByChecklistIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistId', Sort.desc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> thenByEarnedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'earnedAt', Sort.asc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> thenByEarnedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'earnedAt', Sort.desc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> thenByEarnedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'earnedDate', Sort.asc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy>
      thenByEarnedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'earnedDate', Sort.desc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> thenByIconName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconName', Sort.asc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> thenByIconNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconName', Sort.desc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> thenByMetadata() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metadata', Sort.asc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> thenByMetadataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metadata', Sort.desc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> thenByWeekNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekNumber', Sort.asc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy>
      thenByWeekNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekNumber', Sort.desc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> thenByWeekYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekYear', Sort.asc);
    });
  }

  QueryBuilder<Achievements, Achievements, QAfterSortBy> thenByWeekYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekYear', Sort.desc);
    });
  }
}

extension AchievementsQueryWhereDistinct
    on QueryBuilder<Achievements, Achievements, QDistinct> {
  QueryBuilder<Achievements, Achievements, QDistinct> distinctByChecklistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'checklistId');
    });
  }

  QueryBuilder<Achievements, Achievements, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Achievements, Achievements, QDistinct> distinctByEarnedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'earnedAt');
    });
  }

  QueryBuilder<Achievements, Achievements, QDistinct> distinctByEarnedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'earnedDate');
    });
  }

  QueryBuilder<Achievements, Achievements, QDistinct> distinctByIconName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Achievements, Achievements, QDistinct> distinctByMetadata(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'metadata', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Achievements, Achievements, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Achievements, Achievements, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Achievements, Achievements, QDistinct> distinctByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId');
    });
  }

  QueryBuilder<Achievements, Achievements, QDistinct> distinctByWeekNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weekNumber');
    });
  }

  QueryBuilder<Achievements, Achievements, QDistinct> distinctByWeekYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weekYear');
    });
  }
}

extension AchievementsQueryProperty
    on QueryBuilder<Achievements, Achievements, QQueryProperty> {
  QueryBuilder<Achievements, int, QQueryOperations> achievementIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'achievementId');
    });
  }

  QueryBuilder<Achievements, int?, QQueryOperations> checklistIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'checklistId');
    });
  }

  QueryBuilder<Achievements, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<Achievements, DateTime, QQueryOperations> earnedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'earnedAt');
    });
  }

  QueryBuilder<Achievements, DateTime, QQueryOperations> earnedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'earnedDate');
    });
  }

  QueryBuilder<Achievements, String, QQueryOperations> iconNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconName');
    });
  }

  QueryBuilder<Achievements, String?, QQueryOperations> metadataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'metadata');
    });
  }

  QueryBuilder<Achievements, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<Achievements, AchievementType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<Achievements, int, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }

  QueryBuilder<Achievements, int, QQueryOperations> weekNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weekNumber');
    });
  }

  QueryBuilder<Achievements, int, QQueryOperations> weekYearProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weekYear');
    });
  }
}

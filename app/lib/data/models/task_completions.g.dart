// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_completions.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTaskCompletionsCollection on Isar {
  IsarCollection<TaskCompletions> get taskCompletions => this.collection();
}

const TaskCompletionsSchema = CollectionSchema(
  name: r'TaskCompletions',
  id: -3845621758224265075,
  properties: {
    r'checklistId': PropertySchema(
      id: 0,
      name: r'checklistId',
      type: IsarType.long,
    ),
    r'cloudKitRecordId': PropertySchema(
      id: 1,
      name: r'cloudKitRecordId',
      type: IsarType.string,
    ),
    r'completedAt': PropertySchema(
      id: 2,
      name: r'completedAt',
      type: IsarType.dateTime,
    ),
    r'completedBy': PropertySchema(
      id: 3,
      name: r'completedBy',
      type: IsarType.long,
    ),
    r'completionDate': PropertySchema(
      id: 4,
      name: r'completionDate',
      type: IsarType.dateTime,
    ),
    r'dayOfWeek': PropertySchema(
      id: 5,
      name: r'dayOfWeek',
      type: IsarType.long,
    ),
    r'isCompleted': PropertySchema(
      id: 6,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'modifiedAt': PropertySchema(
      id: 7,
      name: r'modifiedAt',
      type: IsarType.dateTime,
    ),
    r'source': PropertySchema(
      id: 8,
      name: r'source',
      type: IsarType.string,
      enumMap: _TaskCompletionssourceEnumValueMap,
    ),
    r'taskId': PropertySchema(
      id: 9,
      name: r'taskId',
      type: IsarType.long,
    ),
    r'userId': PropertySchema(
      id: 10,
      name: r'userId',
      type: IsarType.long,
    ),
    r'weekNumber': PropertySchema(
      id: 11,
      name: r'weekNumber',
      type: IsarType.long,
    ),
    r'weekYear': PropertySchema(
      id: 12,
      name: r'weekYear',
      type: IsarType.long,
    )
  },
  estimateSize: _taskCompletionsEstimateSize,
  serialize: _taskCompletionsSerialize,
  deserialize: _taskCompletionsDeserialize,
  deserializeProp: _taskCompletionsDeserializeProp,
  idName: r'id',
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
    r'taskId': IndexSchema(
      id: -6391211041487498726,
      name: r'taskId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'taskId',
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
    ),
    r'dayOfWeek': IndexSchema(
      id: -5516657708462385134,
      name: r'dayOfWeek',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dayOfWeek',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'checklistId': IndexSchema(
      id: 9198624678771496956,
      name: r'checklistId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'checklistId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _taskCompletionsGetId,
  getLinks: _taskCompletionsGetLinks,
  attach: _taskCompletionsAttach,
  version: '3.1.0+1',
);

int _taskCompletionsEstimateSize(
  TaskCompletions object,
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
  bytesCount += 3 + object.source.name.length * 3;
  return bytesCount;
}

void _taskCompletionsSerialize(
  TaskCompletions object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.checklistId);
  writer.writeString(offsets[1], object.cloudKitRecordId);
  writer.writeDateTime(offsets[2], object.completedAt);
  writer.writeLong(offsets[3], object.completedBy);
  writer.writeDateTime(offsets[4], object.completionDate);
  writer.writeLong(offsets[5], object.dayOfWeek);
  writer.writeBool(offsets[6], object.isCompleted);
  writer.writeDateTime(offsets[7], object.modifiedAt);
  writer.writeString(offsets[8], object.source.name);
  writer.writeLong(offsets[9], object.taskId);
  writer.writeLong(offsets[10], object.userId);
  writer.writeLong(offsets[11], object.weekNumber);
  writer.writeLong(offsets[12], object.weekYear);
}

TaskCompletions _taskCompletionsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TaskCompletions();
  object.checklistId = reader.readLong(offsets[0]);
  object.cloudKitRecordId = reader.readStringOrNull(offsets[1]);
  object.completedAt = reader.readDateTimeOrNull(offsets[2]);
  object.completedBy = reader.readLongOrNull(offsets[3]);
  object.completionDate = reader.readDateTime(offsets[4]);
  object.dayOfWeek = reader.readLong(offsets[5]);
  object.id = id;
  object.isCompleted = reader.readBool(offsets[6]);
  object.modifiedAt = reader.readDateTime(offsets[7]);
  object.source =
      _TaskCompletionssourceValueEnumMap[reader.readStringOrNull(offsets[8])] ??
          TaskCompletionSource.manual;
  object.taskId = reader.readLong(offsets[9]);
  object.userId = reader.readLong(offsets[10]);
  object.weekNumber = reader.readLong(offsets[11]);
  object.weekYear = reader.readLong(offsets[12]);
  return object;
}

P _taskCompletionsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readDateTime(offset)) as P;
    case 8:
      return (_TaskCompletionssourceValueEnumMap[
              reader.readStringOrNull(offset)] ??
          TaskCompletionSource.manual) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _TaskCompletionssourceEnumValueMap = {
  r'manual': r'manual',
  r'ocr': r'ocr',
  r'sync': r'sync',
};
const _TaskCompletionssourceValueEnumMap = {
  r'manual': TaskCompletionSource.manual,
  r'ocr': TaskCompletionSource.ocr,
  r'sync': TaskCompletionSource.sync,
};

Id _taskCompletionsGetId(TaskCompletions object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _taskCompletionsGetLinks(TaskCompletions object) {
  return [];
}

void _taskCompletionsAttach(
    IsarCollection<dynamic> col, Id id, TaskCompletions object) {
  object.id = id;
}

extension TaskCompletionsQueryWhereSort
    on QueryBuilder<TaskCompletions, TaskCompletions, QWhere> {
  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhere> anyUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'userId'),
      );
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhere> anyTaskId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'taskId'),
      );
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhere> anyWeekNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'weekNumber'),
      );
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhere> anyWeekYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'weekYear'),
      );
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhere> anyDayOfWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'dayOfWeek'),
      );
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhere> anyChecklistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'checklistId'),
      );
    });
  }
}

extension TaskCompletionsQueryWhere
    on QueryBuilder<TaskCompletions, TaskCompletions, QWhereClause> {
  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      userIdEqualTo(int userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      userIdNotEqualTo(int userId) {
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      userIdGreaterThan(
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      userIdLessThan(
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      userIdBetween(
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      taskIdEqualTo(int taskId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'taskId',
        value: [taskId],
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      taskIdNotEqualTo(int taskId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'taskId',
              lower: [],
              upper: [taskId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'taskId',
              lower: [taskId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'taskId',
              lower: [taskId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'taskId',
              lower: [],
              upper: [taskId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      taskIdGreaterThan(
    int taskId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'taskId',
        lower: [taskId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      taskIdLessThan(
    int taskId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'taskId',
        lower: [],
        upper: [taskId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      taskIdBetween(
    int lowerTaskId,
    int upperTaskId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'taskId',
        lower: [lowerTaskId],
        includeLower: includeLower,
        upper: [upperTaskId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      weekNumberEqualTo(int weekNumber) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'weekNumber',
        value: [weekNumber],
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      weekNumberBetween(
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      weekYearEqualTo(int weekYear) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'weekYear',
        value: [weekYear],
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      weekYearLessThan(
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      weekYearBetween(
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      dayOfWeekEqualTo(int dayOfWeek) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dayOfWeek',
        value: [dayOfWeek],
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      dayOfWeekNotEqualTo(int dayOfWeek) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dayOfWeek',
              lower: [],
              upper: [dayOfWeek],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dayOfWeek',
              lower: [dayOfWeek],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dayOfWeek',
              lower: [dayOfWeek],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dayOfWeek',
              lower: [],
              upper: [dayOfWeek],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      dayOfWeekGreaterThan(
    int dayOfWeek, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dayOfWeek',
        lower: [dayOfWeek],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      dayOfWeekLessThan(
    int dayOfWeek, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dayOfWeek',
        lower: [],
        upper: [dayOfWeek],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      dayOfWeekBetween(
    int lowerDayOfWeek,
    int upperDayOfWeek, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dayOfWeek',
        lower: [lowerDayOfWeek],
        includeLower: includeLower,
        upper: [upperDayOfWeek],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      checklistIdEqualTo(int checklistId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'checklistId',
        value: [checklistId],
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      checklistIdNotEqualTo(int checklistId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'checklistId',
              lower: [],
              upper: [checklistId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'checklistId',
              lower: [checklistId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'checklistId',
              lower: [checklistId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'checklistId',
              lower: [],
              upper: [checklistId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      checklistIdGreaterThan(
    int checklistId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'checklistId',
        lower: [checklistId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      checklistIdLessThan(
    int checklistId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'checklistId',
        lower: [],
        upper: [checklistId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterWhereClause>
      checklistIdBetween(
    int lowerChecklistId,
    int upperChecklistId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'checklistId',
        lower: [lowerChecklistId],
        includeLower: includeLower,
        upper: [upperChecklistId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TaskCompletionsQueryFilter
    on QueryBuilder<TaskCompletions, TaskCompletions, QFilterCondition> {
  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      checklistIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'checklistId',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      checklistIdGreaterThan(
    int value, {
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      checklistIdLessThan(
    int value, {
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      checklistIdBetween(
    int lower,
    int upper, {
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      cloudKitRecordIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cloudKitRecordId',
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      cloudKitRecordIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cloudKitRecordId',
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      cloudKitRecordIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cloudKitRecordId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      cloudKitRecordIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cloudKitRecordId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      cloudKitRecordIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cloudKitRecordId',
        value: '',
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      cloudKitRecordIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cloudKitRecordId',
        value: '',
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      completedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'completedAt',
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      completedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'completedAt',
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      completedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      completedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      completedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      completedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      completedByIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'completedBy',
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      completedByIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'completedBy',
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      completedByEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedBy',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      completedByGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedBy',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      completedByLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedBy',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      completedByBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedBy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      completionDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      completionDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      completionDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      completionDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completionDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      dayOfWeekEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dayOfWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      dayOfWeekGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dayOfWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      dayOfWeekLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dayOfWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      dayOfWeekBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dayOfWeek',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      isCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      modifiedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modifiedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      modifiedAtBetween(
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      sourceEqualTo(
    TaskCompletionSource value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      sourceGreaterThan(
    TaskCompletionSource value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      sourceLessThan(
    TaskCompletionSource value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      sourceBetween(
    TaskCompletionSource lower,
    TaskCompletionSource upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'source',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      sourceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      sourceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      sourceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      sourceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'source',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      sourceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'source',
        value: '',
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      sourceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'source',
        value: '',
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      taskIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taskId',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      taskIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'taskId',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      taskIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'taskId',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      taskIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'taskId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      userIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      userIdBetween(
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      weekNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weekNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
      weekYearEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weekYear',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
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

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterFilterCondition>
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

extension TaskCompletionsQueryObject
    on QueryBuilder<TaskCompletions, TaskCompletions, QFilterCondition> {}

extension TaskCompletionsQueryLinks
    on QueryBuilder<TaskCompletions, TaskCompletions, QFilterCondition> {}

extension TaskCompletionsQuerySortBy
    on QueryBuilder<TaskCompletions, TaskCompletions, QSortBy> {
  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      sortByChecklistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistId', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      sortByChecklistIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistId', Sort.desc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      sortByCloudKitRecordId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cloudKitRecordId', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      sortByCloudKitRecordIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cloudKitRecordId', Sort.desc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      sortByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      sortByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      sortByCompletedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedBy', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      sortByCompletedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedBy', Sort.desc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      sortByCompletionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completionDate', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      sortByCompletionDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completionDate', Sort.desc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      sortByDayOfWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOfWeek', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      sortByDayOfWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOfWeek', Sort.desc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      sortByModifiedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedAt', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      sortByModifiedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedAt', Sort.desc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy> sortBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      sortBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy> sortByTaskId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      sortByTaskIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.desc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      sortByWeekNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekNumber', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      sortByWeekNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekNumber', Sort.desc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      sortByWeekYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekYear', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      sortByWeekYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekYear', Sort.desc);
    });
  }
}

extension TaskCompletionsQuerySortThenBy
    on QueryBuilder<TaskCompletions, TaskCompletions, QSortThenBy> {
  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      thenByChecklistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistId', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      thenByChecklistIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistId', Sort.desc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      thenByCloudKitRecordId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cloudKitRecordId', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      thenByCloudKitRecordIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cloudKitRecordId', Sort.desc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      thenByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      thenByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      thenByCompletedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedBy', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      thenByCompletedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedBy', Sort.desc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      thenByCompletionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completionDate', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      thenByCompletionDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completionDate', Sort.desc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      thenByDayOfWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOfWeek', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      thenByDayOfWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOfWeek', Sort.desc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      thenByModifiedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedAt', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      thenByModifiedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedAt', Sort.desc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy> thenBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      thenBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy> thenByTaskId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      thenByTaskIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.desc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      thenByWeekNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekNumber', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      thenByWeekNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekNumber', Sort.desc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      thenByWeekYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekYear', Sort.asc);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QAfterSortBy>
      thenByWeekYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekYear', Sort.desc);
    });
  }
}

extension TaskCompletionsQueryWhereDistinct
    on QueryBuilder<TaskCompletions, TaskCompletions, QDistinct> {
  QueryBuilder<TaskCompletions, TaskCompletions, QDistinct>
      distinctByChecklistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'checklistId');
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QDistinct>
      distinctByCloudKitRecordId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cloudKitRecordId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QDistinct>
      distinctByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedAt');
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QDistinct>
      distinctByCompletedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedBy');
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QDistinct>
      distinctByCompletionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completionDate');
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QDistinct>
      distinctByDayOfWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dayOfWeek');
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QDistinct>
      distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QDistinct>
      distinctByModifiedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modifiedAt');
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QDistinct> distinctBySource(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'source', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QDistinct> distinctByTaskId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'taskId');
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QDistinct> distinctByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId');
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QDistinct>
      distinctByWeekNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weekNumber');
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletions, QDistinct>
      distinctByWeekYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weekYear');
    });
  }
}

extension TaskCompletionsQueryProperty
    on QueryBuilder<TaskCompletions, TaskCompletions, QQueryProperty> {
  QueryBuilder<TaskCompletions, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TaskCompletions, int, QQueryOperations> checklistIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'checklistId');
    });
  }

  QueryBuilder<TaskCompletions, String?, QQueryOperations>
      cloudKitRecordIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cloudKitRecordId');
    });
  }

  QueryBuilder<TaskCompletions, DateTime?, QQueryOperations>
      completedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedAt');
    });
  }

  QueryBuilder<TaskCompletions, int?, QQueryOperations> completedByProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedBy');
    });
  }

  QueryBuilder<TaskCompletions, DateTime, QQueryOperations>
      completionDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completionDate');
    });
  }

  QueryBuilder<TaskCompletions, int, QQueryOperations> dayOfWeekProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dayOfWeek');
    });
  }

  QueryBuilder<TaskCompletions, bool, QQueryOperations> isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<TaskCompletions, DateTime, QQueryOperations>
      modifiedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modifiedAt');
    });
  }

  QueryBuilder<TaskCompletions, TaskCompletionSource, QQueryOperations>
      sourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'source');
    });
  }

  QueryBuilder<TaskCompletions, int, QQueryOperations> taskIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'taskId');
    });
  }

  QueryBuilder<TaskCompletions, int, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }

  QueryBuilder<TaskCompletions, int, QQueryOperations> weekNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weekNumber');
    });
  }

  QueryBuilder<TaskCompletions, int, QQueryOperations> weekYearProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weekYear');
    });
  }
}

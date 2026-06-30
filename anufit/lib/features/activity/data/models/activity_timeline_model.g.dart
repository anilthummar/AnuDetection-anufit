// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_timeline_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetActivityTimelineModelCollection on Isar {
  IsarCollection<ActivityTimelineModel> get activityTimelineModels =>
      this.collection();
}

const ActivityTimelineModelSchema = CollectionSchema(
  name: r'ActivityTimelineModel',
  id: -7624958694697398827,
  properties: {
    r'calories': PropertySchema(
      id: 0,
      name: r'calories',
      type: IsarType.double,
    ),
    r'date': PropertySchema(id: 1, name: r'date', type: IsarType.dateTime),
    r'dayHourKey': PropertySchema(
      id: 2,
      name: r'dayHourKey',
      type: IsarType.string,
    ),
    r'distanceKm': PropertySchema(
      id: 3,
      name: r'distanceKm',
      type: IsarType.double,
    ),
    r'hour': PropertySchema(id: 4, name: r'hour', type: IsarType.long),
    r'steps': PropertySchema(id: 5, name: r'steps', type: IsarType.long),
    r'walkingTimeMinutes': PropertySchema(
      id: 6,
      name: r'walkingTimeMinutes',
      type: IsarType.long,
    ),
  },

  estimateSize: _activityTimelineModelEstimateSize,
  serialize: _activityTimelineModelSerialize,
  deserialize: _activityTimelineModelDeserialize,
  deserializeProp: _activityTimelineModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'dayHourKey': IndexSchema(
      id: -8117737400578510823,
      name: r'dayHourKey',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dayHourKey',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _activityTimelineModelGetId,
  getLinks: _activityTimelineModelGetLinks,
  attach: _activityTimelineModelAttach,
  version: '3.3.2',
);

int _activityTimelineModelEstimateSize(
  ActivityTimelineModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.dayHourKey.length * 3;
  return bytesCount;
}

void _activityTimelineModelSerialize(
  ActivityTimelineModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.calories);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeString(offsets[2], object.dayHourKey);
  writer.writeDouble(offsets[3], object.distanceKm);
  writer.writeLong(offsets[4], object.hour);
  writer.writeLong(offsets[5], object.steps);
  writer.writeLong(offsets[6], object.walkingTimeMinutes);
}

ActivityTimelineModel _activityTimelineModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ActivityTimelineModel();
  object.calories = reader.readDouble(offsets[0]);
  object.date = reader.readDateTime(offsets[1]);
  object.dayHourKey = reader.readString(offsets[2]);
  object.distanceKm = reader.readDouble(offsets[3]);
  object.hour = reader.readLong(offsets[4]);
  object.id = id;
  object.steps = reader.readLong(offsets[5]);
  object.walkingTimeMinutes = reader.readLong(offsets[6]);
  return object;
}

P _activityTimelineModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _activityTimelineModelGetId(ActivityTimelineModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _activityTimelineModelGetLinks(
  ActivityTimelineModel object,
) {
  return [];
}

void _activityTimelineModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  ActivityTimelineModel object,
) {
  object.id = id;
}

extension ActivityTimelineModelByIndex
    on IsarCollection<ActivityTimelineModel> {
  Future<ActivityTimelineModel?> getByDayHourKey(String dayHourKey) {
    return getByIndex(r'dayHourKey', [dayHourKey]);
  }

  ActivityTimelineModel? getByDayHourKeySync(String dayHourKey) {
    return getByIndexSync(r'dayHourKey', [dayHourKey]);
  }

  Future<bool> deleteByDayHourKey(String dayHourKey) {
    return deleteByIndex(r'dayHourKey', [dayHourKey]);
  }

  bool deleteByDayHourKeySync(String dayHourKey) {
    return deleteByIndexSync(r'dayHourKey', [dayHourKey]);
  }

  Future<List<ActivityTimelineModel?>> getAllByDayHourKey(
    List<String> dayHourKeyValues,
  ) {
    final values = dayHourKeyValues.map((e) => [e]).toList();
    return getAllByIndex(r'dayHourKey', values);
  }

  List<ActivityTimelineModel?> getAllByDayHourKeySync(
    List<String> dayHourKeyValues,
  ) {
    final values = dayHourKeyValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'dayHourKey', values);
  }

  Future<int> deleteAllByDayHourKey(List<String> dayHourKeyValues) {
    final values = dayHourKeyValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'dayHourKey', values);
  }

  int deleteAllByDayHourKeySync(List<String> dayHourKeyValues) {
    final values = dayHourKeyValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'dayHourKey', values);
  }

  Future<Id> putByDayHourKey(ActivityTimelineModel object) {
    return putByIndex(r'dayHourKey', object);
  }

  Id putByDayHourKeySync(
    ActivityTimelineModel object, {
    bool saveLinks = true,
  }) {
    return putByIndexSync(r'dayHourKey', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDayHourKey(List<ActivityTimelineModel> objects) {
    return putAllByIndex(r'dayHourKey', objects);
  }

  List<Id> putAllByDayHourKeySync(
    List<ActivityTimelineModel> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'dayHourKey', objects, saveLinks: saveLinks);
  }
}

extension ActivityTimelineModelQueryWhereSort
    on QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QWhere> {
  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ActivityTimelineModelQueryWhere
    on
        QueryBuilder<
          ActivityTimelineModel,
          ActivityTimelineModel,
          QWhereClause
        > {
  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterWhereClause>
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

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterWhereClause>
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterWhereClause>
  dayHourKeyEqualTo(String dayHourKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'dayHourKey', value: [dayHourKey]),
      );
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterWhereClause>
  dayHourKeyNotEqualTo(String dayHourKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dayHourKey',
                lower: [],
                upper: [dayHourKey],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dayHourKey',
                lower: [dayHourKey],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dayHourKey',
                lower: [dayHourKey],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dayHourKey',
                lower: [],
                upper: [dayHourKey],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension ActivityTimelineModelQueryFilter
    on
        QueryBuilder<
          ActivityTimelineModel,
          ActivityTimelineModel,
          QFilterCondition
        > {
  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  caloriesEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'calories',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  caloriesGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'calories',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  caloriesLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'calories',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  caloriesBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'calories',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  dateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'date', value: value),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  dateGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'date',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  dateLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'date',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'date',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  dayHourKeyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'dayHourKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  dayHourKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'dayHourKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  dayHourKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'dayHourKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  dayHourKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'dayHourKey',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  dayHourKeyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'dayHourKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  dayHourKeyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'dayHourKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  dayHourKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'dayHourKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  dayHourKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'dayHourKey',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  dayHourKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'dayHourKey', value: ''),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  dayHourKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'dayHourKey', value: ''),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  distanceKmEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'distanceKm',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  distanceKmGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'distanceKm',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  distanceKmLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'distanceKm',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  distanceKmBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'distanceKm',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  hourEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hour', value: value),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  hourGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'hour',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  hourLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'hour',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  hourBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'hour',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  stepsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'steps', value: value),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  stepsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'steps',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  stepsLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'steps',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  stepsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'steps',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  walkingTimeMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'walkingTimeMinutes', value: value),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  walkingTimeMinutesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'walkingTimeMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  walkingTimeMinutesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'walkingTimeMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ActivityTimelineModel,
    ActivityTimelineModel,
    QAfterFilterCondition
  >
  walkingTimeMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'walkingTimeMinutes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension ActivityTimelineModelQueryObject
    on
        QueryBuilder<
          ActivityTimelineModel,
          ActivityTimelineModel,
          QFilterCondition
        > {}

extension ActivityTimelineModelQueryLinks
    on
        QueryBuilder<
          ActivityTimelineModel,
          ActivityTimelineModel,
          QFilterCondition
        > {}

extension ActivityTimelineModelQuerySortBy
    on QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QSortBy> {
  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  sortByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.asc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  sortByCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.desc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  sortByDayHourKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayHourKey', Sort.asc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  sortByDayHourKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayHourKey', Sort.desc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  sortByDistanceKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceKm', Sort.asc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  sortByDistanceKmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceKm', Sort.desc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  sortByHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hour', Sort.asc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  sortByHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hour', Sort.desc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  sortBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.asc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  sortByStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.desc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  sortByWalkingTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walkingTimeMinutes', Sort.asc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  sortByWalkingTimeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walkingTimeMinutes', Sort.desc);
    });
  }
}

extension ActivityTimelineModelQuerySortThenBy
    on QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QSortThenBy> {
  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  thenByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.asc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  thenByCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.desc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  thenByDayHourKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayHourKey', Sort.asc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  thenByDayHourKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayHourKey', Sort.desc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  thenByDistanceKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceKm', Sort.asc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  thenByDistanceKmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceKm', Sort.desc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  thenByHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hour', Sort.asc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  thenByHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hour', Sort.desc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  thenBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.asc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  thenByStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.desc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  thenByWalkingTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walkingTimeMinutes', Sort.asc);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QAfterSortBy>
  thenByWalkingTimeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walkingTimeMinutes', Sort.desc);
    });
  }
}

extension ActivityTimelineModelQueryWhereDistinct
    on QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QDistinct> {
  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QDistinct>
  distinctByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'calories');
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QDistinct>
  distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QDistinct>
  distinctByDayHourKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dayHourKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QDistinct>
  distinctByDistanceKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distanceKm');
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QDistinct>
  distinctByHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hour');
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QDistinct>
  distinctBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'steps');
    });
  }

  QueryBuilder<ActivityTimelineModel, ActivityTimelineModel, QDistinct>
  distinctByWalkingTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'walkingTimeMinutes');
    });
  }
}

extension ActivityTimelineModelQueryProperty
    on
        QueryBuilder<
          ActivityTimelineModel,
          ActivityTimelineModel,
          QQueryProperty
        > {
  QueryBuilder<ActivityTimelineModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ActivityTimelineModel, double, QQueryOperations>
  caloriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'calories');
    });
  }

  QueryBuilder<ActivityTimelineModel, DateTime, QQueryOperations>
  dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<ActivityTimelineModel, String, QQueryOperations>
  dayHourKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dayHourKey');
    });
  }

  QueryBuilder<ActivityTimelineModel, double, QQueryOperations>
  distanceKmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distanceKm');
    });
  }

  QueryBuilder<ActivityTimelineModel, int, QQueryOperations> hourProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hour');
    });
  }

  QueryBuilder<ActivityTimelineModel, int, QQueryOperations> stepsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'steps');
    });
  }

  QueryBuilder<ActivityTimelineModel, int, QQueryOperations>
  walkingTimeMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'walkingTimeMinutes');
    });
  }
}

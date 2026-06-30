// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_summary_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDailySummaryModelCollection on Isar {
  IsarCollection<DailySummaryModel> get dailySummaryModels => this.collection();
}

const DailySummaryModelSchema = CollectionSchema(
  name: r'DailySummaryModel',
  id: -794567742946120472,
  properties: {
    r'calories': PropertySchema(
      id: 0,
      name: r'calories',
      type: IsarType.double,
    ),
    r'date': PropertySchema(id: 1, name: r'date', type: IsarType.dateTime),
    r'distanceKm': PropertySchema(
      id: 2,
      name: r'distanceKm',
      type: IsarType.double,
    ),
    r'goalCompleted': PropertySchema(
      id: 3,
      name: r'goalCompleted',
      type: IsarType.bool,
    ),
    r'steps': PropertySchema(id: 4, name: r'steps', type: IsarType.long),
    r'walkingTimeMinutes': PropertySchema(
      id: 5,
      name: r'walkingTimeMinutes',
      type: IsarType.long,
    ),
  },

  estimateSize: _dailySummaryModelEstimateSize,
  serialize: _dailySummaryModelSerialize,
  deserialize: _dailySummaryModelDeserialize,
  deserializeProp: _dailySummaryModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'date': IndexSchema(
      id: -7552997827385218417,
      name: r'date',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'date',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _dailySummaryModelGetId,
  getLinks: _dailySummaryModelGetLinks,
  attach: _dailySummaryModelAttach,
  version: '3.3.2',
);

int _dailySummaryModelEstimateSize(
  DailySummaryModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _dailySummaryModelSerialize(
  DailySummaryModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.calories);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeDouble(offsets[2], object.distanceKm);
  writer.writeBool(offsets[3], object.goalCompleted);
  writer.writeLong(offsets[4], object.steps);
  writer.writeLong(offsets[5], object.walkingTimeMinutes);
}

DailySummaryModel _dailySummaryModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DailySummaryModel();
  object.calories = reader.readDouble(offsets[0]);
  object.date = reader.readDateTime(offsets[1]);
  object.distanceKm = reader.readDouble(offsets[2]);
  object.goalCompleted = reader.readBool(offsets[3]);
  object.id = id;
  object.steps = reader.readLong(offsets[4]);
  object.walkingTimeMinutes = reader.readLong(offsets[5]);
  return object;
}

P _dailySummaryModelDeserializeProp<P>(
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
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dailySummaryModelGetId(DailySummaryModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dailySummaryModelGetLinks(
  DailySummaryModel object,
) {
  return [];
}

void _dailySummaryModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  DailySummaryModel object,
) {
  object.id = id;
}

extension DailySummaryModelByIndex on IsarCollection<DailySummaryModel> {
  Future<DailySummaryModel?> getByDate(DateTime date) {
    return getByIndex(r'date', [date]);
  }

  DailySummaryModel? getByDateSync(DateTime date) {
    return getByIndexSync(r'date', [date]);
  }

  Future<bool> deleteByDate(DateTime date) {
    return deleteByIndex(r'date', [date]);
  }

  bool deleteByDateSync(DateTime date) {
    return deleteByIndexSync(r'date', [date]);
  }

  Future<List<DailySummaryModel?>> getAllByDate(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return getAllByIndex(r'date', values);
  }

  List<DailySummaryModel?> getAllByDateSync(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'date', values);
  }

  Future<int> deleteAllByDate(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'date', values);
  }

  int deleteAllByDateSync(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'date', values);
  }

  Future<Id> putByDate(DailySummaryModel object) {
    return putByIndex(r'date', object);
  }

  Id putByDateSync(DailySummaryModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'date', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDate(List<DailySummaryModel> objects) {
    return putAllByIndex(r'date', objects);
  }

  List<Id> putAllByDateSync(
    List<DailySummaryModel> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'date', objects, saveLinks: saveLinks);
  }
}

extension DailySummaryModelQueryWhereSort
    on QueryBuilder<DailySummaryModel, DailySummaryModel, QWhere> {
  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterWhere> anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }
}

extension DailySummaryModelQueryWhere
    on QueryBuilder<DailySummaryModel, DailySummaryModel, QWhereClause> {
  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterWhereClause>
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

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterWhereClause>
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

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterWhereClause>
  dateEqualTo(DateTime date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'date', value: [date]),
      );
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterWhereClause>
  dateNotEqualTo(DateTime date) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'date',
                lower: [],
                upper: [date],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'date',
                lower: [date],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'date',
                lower: [date],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'date',
                lower: [],
                upper: [date],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterWhereClause>
  dateGreaterThan(DateTime date, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'date',
          lower: [date],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterWhereClause>
  dateLessThan(DateTime date, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'date',
          lower: [],
          upper: [date],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterWhereClause>
  dateBetween(
    DateTime lowerDate,
    DateTime upperDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'date',
          lower: [lowerDate],
          includeLower: includeLower,
          upper: [upperDate],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension DailySummaryModelQueryFilter
    on QueryBuilder<DailySummaryModel, DailySummaryModel, QFilterCondition> {
  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterFilterCondition>
  dateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'date', value: value),
      );
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterFilterCondition>
  goalCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'goalCompleted', value: value),
      );
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterFilterCondition>
  stepsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'steps', value: value),
      );
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterFilterCondition>
  walkingTimeMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'walkingTimeMinutes', value: value),
      );
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterFilterCondition>
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

extension DailySummaryModelQueryObject
    on QueryBuilder<DailySummaryModel, DailySummaryModel, QFilterCondition> {}

extension DailySummaryModelQueryLinks
    on QueryBuilder<DailySummaryModel, DailySummaryModel, QFilterCondition> {}

extension DailySummaryModelQuerySortBy
    on QueryBuilder<DailySummaryModel, DailySummaryModel, QSortBy> {
  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy>
  sortByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.asc);
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy>
  sortByCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.desc);
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy>
  sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy>
  sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy>
  sortByDistanceKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceKm', Sort.asc);
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy>
  sortByDistanceKmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceKm', Sort.desc);
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy>
  sortByGoalCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalCompleted', Sort.asc);
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy>
  sortByGoalCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalCompleted', Sort.desc);
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy>
  sortBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.asc);
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy>
  sortByStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.desc);
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy>
  sortByWalkingTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walkingTimeMinutes', Sort.asc);
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy>
  sortByWalkingTimeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walkingTimeMinutes', Sort.desc);
    });
  }
}

extension DailySummaryModelQuerySortThenBy
    on QueryBuilder<DailySummaryModel, DailySummaryModel, QSortThenBy> {
  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy>
  thenByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.asc);
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy>
  thenByCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.desc);
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy>
  thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy>
  thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy>
  thenByDistanceKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceKm', Sort.asc);
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy>
  thenByDistanceKmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceKm', Sort.desc);
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy>
  thenByGoalCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalCompleted', Sort.asc);
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy>
  thenByGoalCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalCompleted', Sort.desc);
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy>
  thenBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.asc);
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy>
  thenByStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.desc);
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy>
  thenByWalkingTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walkingTimeMinutes', Sort.asc);
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QAfterSortBy>
  thenByWalkingTimeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walkingTimeMinutes', Sort.desc);
    });
  }
}

extension DailySummaryModelQueryWhereDistinct
    on QueryBuilder<DailySummaryModel, DailySummaryModel, QDistinct> {
  QueryBuilder<DailySummaryModel, DailySummaryModel, QDistinct>
  distinctByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'calories');
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QDistinct>
  distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QDistinct>
  distinctByDistanceKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distanceKm');
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QDistinct>
  distinctByGoalCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goalCompleted');
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QDistinct>
  distinctBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'steps');
    });
  }

  QueryBuilder<DailySummaryModel, DailySummaryModel, QDistinct>
  distinctByWalkingTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'walkingTimeMinutes');
    });
  }
}

extension DailySummaryModelQueryProperty
    on QueryBuilder<DailySummaryModel, DailySummaryModel, QQueryProperty> {
  QueryBuilder<DailySummaryModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DailySummaryModel, double, QQueryOperations> caloriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'calories');
    });
  }

  QueryBuilder<DailySummaryModel, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<DailySummaryModel, double, QQueryOperations>
  distanceKmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distanceKm');
    });
  }

  QueryBuilder<DailySummaryModel, bool, QQueryOperations>
  goalCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goalCompleted');
    });
  }

  QueryBuilder<DailySummaryModel, int, QQueryOperations> stepsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'steps');
    });
  }

  QueryBuilder<DailySummaryModel, int, QQueryOperations>
  walkingTimeMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'walkingTimeMinutes');
    });
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_summary_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWeeklySummaryModelCollection on Isar {
  IsarCollection<WeeklySummaryModel> get weeklySummaryModels =>
      this.collection();
}

const WeeklySummaryModelSchema = CollectionSchema(
  name: r'WeeklySummaryModel',
  id: 3972581333380596483,
  properties: {
    r'calories': PropertySchema(
      id: 0,
      name: r'calories',
      type: IsarType.double,
    ),
    r'distanceKm': PropertySchema(
      id: 1,
      name: r'distanceKm',
      type: IsarType.double,
    ),
    r'steps': PropertySchema(id: 2, name: r'steps', type: IsarType.long),
    r'walkingTimeMinutes': PropertySchema(
      id: 3,
      name: r'walkingTimeMinutes',
      type: IsarType.long,
    ),
    r'week': PropertySchema(id: 4, name: r'week', type: IsarType.long),
    r'year': PropertySchema(id: 5, name: r'year', type: IsarType.long),
  },

  estimateSize: _weeklySummaryModelEstimateSize,
  serialize: _weeklySummaryModelSerialize,
  deserialize: _weeklySummaryModelDeserialize,
  deserializeProp: _weeklySummaryModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'week_year': IndexSchema(
      id: 1850323284808909679,
      name: r'week_year',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'week',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'year',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _weeklySummaryModelGetId,
  getLinks: _weeklySummaryModelGetLinks,
  attach: _weeklySummaryModelAttach,
  version: '3.3.2',
);

int _weeklySummaryModelEstimateSize(
  WeeklySummaryModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _weeklySummaryModelSerialize(
  WeeklySummaryModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.calories);
  writer.writeDouble(offsets[1], object.distanceKm);
  writer.writeLong(offsets[2], object.steps);
  writer.writeLong(offsets[3], object.walkingTimeMinutes);
  writer.writeLong(offsets[4], object.week);
  writer.writeLong(offsets[5], object.year);
}

WeeklySummaryModel _weeklySummaryModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WeeklySummaryModel();
  object.calories = reader.readDouble(offsets[0]);
  object.distanceKm = reader.readDouble(offsets[1]);
  object.id = id;
  object.steps = reader.readLong(offsets[2]);
  object.walkingTimeMinutes = reader.readLong(offsets[3]);
  object.week = reader.readLong(offsets[4]);
  object.year = reader.readLong(offsets[5]);
  return object;
}

P _weeklySummaryModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _weeklySummaryModelGetId(WeeklySummaryModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _weeklySummaryModelGetLinks(
  WeeklySummaryModel object,
) {
  return [];
}

void _weeklySummaryModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  WeeklySummaryModel object,
) {
  object.id = id;
}

extension WeeklySummaryModelQueryWhereSort
    on QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QWhere> {
  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterWhere>
  anyWeekYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'week_year'),
      );
    });
  }
}

extension WeeklySummaryModelQueryWhere
    on QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QWhereClause> {
  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterWhereClause>
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

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterWhereClause>
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

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterWhereClause>
  weekEqualToAnyYear(int week) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'week_year', value: [week]),
      );
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterWhereClause>
  weekNotEqualToAnyYear(int week) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'week_year',
                lower: [],
                upper: [week],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'week_year',
                lower: [week],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'week_year',
                lower: [week],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'week_year',
                lower: [],
                upper: [week],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterWhereClause>
  weekGreaterThanAnyYear(int week, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'week_year',
          lower: [week],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterWhereClause>
  weekLessThanAnyYear(int week, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'week_year',
          lower: [],
          upper: [week],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterWhereClause>
  weekBetweenAnyYear(
    int lowerWeek,
    int upperWeek, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'week_year',
          lower: [lowerWeek],
          includeLower: includeLower,
          upper: [upperWeek],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterWhereClause>
  weekYearEqualTo(int week, int year) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'week_year', value: [week, year]),
      );
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterWhereClause>
  weekEqualToYearNotEqualTo(int week, int year) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'week_year',
                lower: [week],
                upper: [week, year],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'week_year',
                lower: [week, year],
                includeLower: false,
                upper: [week],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'week_year',
                lower: [week, year],
                includeLower: false,
                upper: [week],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'week_year',
                lower: [week],
                upper: [week, year],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterWhereClause>
  weekEqualToYearGreaterThan(int week, int year, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'week_year',
          lower: [week, year],
          includeLower: include,
          upper: [week],
        ),
      );
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterWhereClause>
  weekEqualToYearLessThan(int week, int year, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'week_year',
          lower: [week],
          upper: [week, year],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterWhereClause>
  weekEqualToYearBetween(
    int week,
    int lowerYear,
    int upperYear, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'week_year',
          lower: [week, lowerYear],
          includeLower: includeLower,
          upper: [week, upperYear],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension WeeklySummaryModelQueryFilter
    on QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QFilterCondition> {
  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
  stepsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'steps', value: value),
      );
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
  walkingTimeMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'walkingTimeMinutes', value: value),
      );
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
  weekEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'week', value: value),
      );
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
  weekGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'week',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
  weekLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'week',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
  weekBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'week',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
  yearEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'year', value: value),
      );
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
  yearGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'year',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
  yearLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'year',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterFilterCondition>
  yearBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'year',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension WeeklySummaryModelQueryObject
    on QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QFilterCondition> {}

extension WeeklySummaryModelQueryLinks
    on QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QFilterCondition> {}

extension WeeklySummaryModelQuerySortBy
    on QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QSortBy> {
  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  sortByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.asc);
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  sortByCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.desc);
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  sortByDistanceKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceKm', Sort.asc);
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  sortByDistanceKmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceKm', Sort.desc);
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  sortBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.asc);
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  sortByStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.desc);
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  sortByWalkingTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walkingTimeMinutes', Sort.asc);
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  sortByWalkingTimeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walkingTimeMinutes', Sort.desc);
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  sortByWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'week', Sort.asc);
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  sortByWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'week', Sort.desc);
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  sortByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.asc);
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  sortByYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.desc);
    });
  }
}

extension WeeklySummaryModelQuerySortThenBy
    on QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QSortThenBy> {
  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  thenByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.asc);
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  thenByCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.desc);
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  thenByDistanceKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceKm', Sort.asc);
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  thenByDistanceKmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceKm', Sort.desc);
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  thenBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.asc);
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  thenByStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.desc);
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  thenByWalkingTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walkingTimeMinutes', Sort.asc);
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  thenByWalkingTimeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walkingTimeMinutes', Sort.desc);
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  thenByWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'week', Sort.asc);
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  thenByWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'week', Sort.desc);
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  thenByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.asc);
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QAfterSortBy>
  thenByYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.desc);
    });
  }
}

extension WeeklySummaryModelQueryWhereDistinct
    on QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QDistinct> {
  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QDistinct>
  distinctByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'calories');
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QDistinct>
  distinctByDistanceKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distanceKm');
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QDistinct>
  distinctBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'steps');
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QDistinct>
  distinctByWalkingTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'walkingTimeMinutes');
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QDistinct>
  distinctByWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'week');
    });
  }

  QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QDistinct>
  distinctByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'year');
    });
  }
}

extension WeeklySummaryModelQueryProperty
    on QueryBuilder<WeeklySummaryModel, WeeklySummaryModel, QQueryProperty> {
  QueryBuilder<WeeklySummaryModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WeeklySummaryModel, double, QQueryOperations>
  caloriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'calories');
    });
  }

  QueryBuilder<WeeklySummaryModel, double, QQueryOperations>
  distanceKmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distanceKm');
    });
  }

  QueryBuilder<WeeklySummaryModel, int, QQueryOperations> stepsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'steps');
    });
  }

  QueryBuilder<WeeklySummaryModel, int, QQueryOperations>
  walkingTimeMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'walkingTimeMinutes');
    });
  }

  QueryBuilder<WeeklySummaryModel, int, QQueryOperations> weekProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'week');
    });
  }

  QueryBuilder<WeeklySummaryModel, int, QQueryOperations> yearProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'year');
    });
  }
}

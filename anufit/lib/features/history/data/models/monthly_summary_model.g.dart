// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_summary_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMonthlySummaryModelCollection on Isar {
  IsarCollection<MonthlySummaryModel> get monthlySummaryModels =>
      this.collection();
}

const MonthlySummaryModelSchema = CollectionSchema(
  name: r'MonthlySummaryModel',
  id: 3916111995907331405,
  properties: {
    r'activeDays': PropertySchema(
      id: 0,
      name: r'activeDays',
      type: IsarType.long,
    ),
    r'calories': PropertySchema(
      id: 1,
      name: r'calories',
      type: IsarType.double,
    ),
    r'distanceKm': PropertySchema(
      id: 2,
      name: r'distanceKm',
      type: IsarType.double,
    ),
    r'month': PropertySchema(id: 3, name: r'month', type: IsarType.long),
    r'steps': PropertySchema(id: 4, name: r'steps', type: IsarType.long),
    r'walkingTimeMinutes': PropertySchema(
      id: 5,
      name: r'walkingTimeMinutes',
      type: IsarType.long,
    ),
    r'year': PropertySchema(id: 6, name: r'year', type: IsarType.long),
  },

  estimateSize: _monthlySummaryModelEstimateSize,
  serialize: _monthlySummaryModelSerialize,
  deserialize: _monthlySummaryModelDeserialize,
  deserializeProp: _monthlySummaryModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'month_year': IndexSchema(
      id: 9018924667056050055,
      name: r'month_year',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'month',
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

  getId: _monthlySummaryModelGetId,
  getLinks: _monthlySummaryModelGetLinks,
  attach: _monthlySummaryModelAttach,
  version: '3.3.2',
);

int _monthlySummaryModelEstimateSize(
  MonthlySummaryModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _monthlySummaryModelSerialize(
  MonthlySummaryModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.activeDays);
  writer.writeDouble(offsets[1], object.calories);
  writer.writeDouble(offsets[2], object.distanceKm);
  writer.writeLong(offsets[3], object.month);
  writer.writeLong(offsets[4], object.steps);
  writer.writeLong(offsets[5], object.walkingTimeMinutes);
  writer.writeLong(offsets[6], object.year);
}

MonthlySummaryModel _monthlySummaryModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MonthlySummaryModel();
  object.activeDays = reader.readLong(offsets[0]);
  object.calories = reader.readDouble(offsets[1]);
  object.distanceKm = reader.readDouble(offsets[2]);
  object.id = id;
  object.month = reader.readLong(offsets[3]);
  object.steps = reader.readLong(offsets[4]);
  object.walkingTimeMinutes = reader.readLong(offsets[5]);
  object.year = reader.readLong(offsets[6]);
  return object;
}

P _monthlySummaryModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
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

Id _monthlySummaryModelGetId(MonthlySummaryModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _monthlySummaryModelGetLinks(
  MonthlySummaryModel object,
) {
  return [];
}

void _monthlySummaryModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  MonthlySummaryModel object,
) {
  object.id = id;
}

extension MonthlySummaryModelQueryWhereSort
    on QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QWhere> {
  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterWhere>
  anyMonthYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'month_year'),
      );
    });
  }
}

extension MonthlySummaryModelQueryWhere
    on QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QWhereClause> {
  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterWhereClause>
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

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterWhereClause>
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

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterWhereClause>
  monthEqualToAnyYear(int month) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'month_year', value: [month]),
      );
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterWhereClause>
  monthNotEqualToAnyYear(int month) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'month_year',
                lower: [],
                upper: [month],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'month_year',
                lower: [month],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'month_year',
                lower: [month],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'month_year',
                lower: [],
                upper: [month],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterWhereClause>
  monthGreaterThanAnyYear(int month, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'month_year',
          lower: [month],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterWhereClause>
  monthLessThanAnyYear(int month, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'month_year',
          lower: [],
          upper: [month],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterWhereClause>
  monthBetweenAnyYear(
    int lowerMonth,
    int upperMonth, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'month_year',
          lower: [lowerMonth],
          includeLower: includeLower,
          upper: [upperMonth],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterWhereClause>
  monthYearEqualTo(int month, int year) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'month_year',
          value: [month, year],
        ),
      );
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterWhereClause>
  monthEqualToYearNotEqualTo(int month, int year) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'month_year',
                lower: [month],
                upper: [month, year],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'month_year',
                lower: [month, year],
                includeLower: false,
                upper: [month],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'month_year',
                lower: [month, year],
                includeLower: false,
                upper: [month],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'month_year',
                lower: [month],
                upper: [month, year],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterWhereClause>
  monthEqualToYearGreaterThan(int month, int year, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'month_year',
          lower: [month, year],
          includeLower: include,
          upper: [month],
        ),
      );
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterWhereClause>
  monthEqualToYearLessThan(int month, int year, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'month_year',
          lower: [month],
          upper: [month, year],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterWhereClause>
  monthEqualToYearBetween(
    int month,
    int lowerYear,
    int upperYear, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'month_year',
          lower: [month, lowerYear],
          includeLower: includeLower,
          upper: [month, upperYear],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension MonthlySummaryModelQueryFilter
    on
        QueryBuilder<
          MonthlySummaryModel,
          MonthlySummaryModel,
          QFilterCondition
        > {
  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
  activeDaysEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'activeDays', value: value),
      );
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
  activeDaysGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'activeDays',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
  activeDaysLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'activeDays',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
  activeDaysBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'activeDays',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
  monthEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'month', value: value),
      );
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
  monthGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'month',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
  monthLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'month',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
  monthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'month',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
  stepsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'steps', value: value),
      );
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
  walkingTimeMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'walkingTimeMinutes', value: value),
      );
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
  yearEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'year', value: value),
      );
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
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

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterFilterCondition>
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

extension MonthlySummaryModelQueryObject
    on
        QueryBuilder<
          MonthlySummaryModel,
          MonthlySummaryModel,
          QFilterCondition
        > {}

extension MonthlySummaryModelQueryLinks
    on
        QueryBuilder<
          MonthlySummaryModel,
          MonthlySummaryModel,
          QFilterCondition
        > {}

extension MonthlySummaryModelQuerySortBy
    on QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QSortBy> {
  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  sortByActiveDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeDays', Sort.asc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  sortByActiveDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeDays', Sort.desc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  sortByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.asc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  sortByCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.desc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  sortByDistanceKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceKm', Sort.asc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  sortByDistanceKmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceKm', Sort.desc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  sortByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.asc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  sortByMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.desc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  sortBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.asc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  sortByStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.desc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  sortByWalkingTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walkingTimeMinutes', Sort.asc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  sortByWalkingTimeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walkingTimeMinutes', Sort.desc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  sortByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.asc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  sortByYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.desc);
    });
  }
}

extension MonthlySummaryModelQuerySortThenBy
    on QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QSortThenBy> {
  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  thenByActiveDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeDays', Sort.asc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  thenByActiveDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeDays', Sort.desc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  thenByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.asc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  thenByCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.desc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  thenByDistanceKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceKm', Sort.asc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  thenByDistanceKmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceKm', Sort.desc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  thenByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.asc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  thenByMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.desc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  thenBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.asc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  thenByStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.desc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  thenByWalkingTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walkingTimeMinutes', Sort.asc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  thenByWalkingTimeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walkingTimeMinutes', Sort.desc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  thenByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.asc);
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QAfterSortBy>
  thenByYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.desc);
    });
  }
}

extension MonthlySummaryModelQueryWhereDistinct
    on QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QDistinct> {
  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QDistinct>
  distinctByActiveDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activeDays');
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QDistinct>
  distinctByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'calories');
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QDistinct>
  distinctByDistanceKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distanceKm');
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QDistinct>
  distinctByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'month');
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QDistinct>
  distinctBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'steps');
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QDistinct>
  distinctByWalkingTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'walkingTimeMinutes');
    });
  }

  QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QDistinct>
  distinctByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'year');
    });
  }
}

extension MonthlySummaryModelQueryProperty
    on QueryBuilder<MonthlySummaryModel, MonthlySummaryModel, QQueryProperty> {
  QueryBuilder<MonthlySummaryModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MonthlySummaryModel, int, QQueryOperations>
  activeDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activeDays');
    });
  }

  QueryBuilder<MonthlySummaryModel, double, QQueryOperations>
  caloriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'calories');
    });
  }

  QueryBuilder<MonthlySummaryModel, double, QQueryOperations>
  distanceKmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distanceKm');
    });
  }

  QueryBuilder<MonthlySummaryModel, int, QQueryOperations> monthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'month');
    });
  }

  QueryBuilder<MonthlySummaryModel, int, QQueryOperations> stepsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'steps');
    });
  }

  QueryBuilder<MonthlySummaryModel, int, QQueryOperations>
  walkingTimeMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'walkingTimeMinutes');
    });
  }

  QueryBuilder<MonthlySummaryModel, int, QQueryOperations> yearProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'year');
    });
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGoalModelCollection on Isar {
  IsarCollection<GoalModel> get goalModels => this.collection();
}

const GoalModelSchema = CollectionSchema(
  name: r'GoalModel',
  id: -1812259076224842086,
  properties: {
    r'calorieGoal': PropertySchema(
      id: 0,
      name: r'calorieGoal',
      type: IsarType.double,
    ),
    r'distanceGoalKm': PropertySchema(
      id: 1,
      name: r'distanceGoalKm',
      type: IsarType.double,
    ),
    r'stepGoal': PropertySchema(id: 2, name: r'stepGoal', type: IsarType.long),
    r'updatedAt': PropertySchema(
      id: 3,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'walkingTimeGoalMinutes': PropertySchema(
      id: 4,
      name: r'walkingTimeGoalMinutes',
      type: IsarType.long,
    ),
  },

  estimateSize: _goalModelEstimateSize,
  serialize: _goalModelSerialize,
  deserialize: _goalModelDeserialize,
  deserializeProp: _goalModelDeserializeProp,
  idName: r'goalId',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _goalModelGetId,
  getLinks: _goalModelGetLinks,
  attach: _goalModelAttach,
  version: '3.3.2',
);

int _goalModelEstimateSize(
  GoalModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _goalModelSerialize(
  GoalModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.calorieGoal);
  writer.writeDouble(offsets[1], object.distanceGoalKm);
  writer.writeLong(offsets[2], object.stepGoal);
  writer.writeDateTime(offsets[3], object.updatedAt);
  writer.writeLong(offsets[4], object.walkingTimeGoalMinutes);
}

GoalModel _goalModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GoalModel();
  object.calorieGoal = reader.readDoubleOrNull(offsets[0]);
  object.distanceGoalKm = reader.readDoubleOrNull(offsets[1]);
  object.goalId = id;
  object.stepGoal = reader.readLong(offsets[2]);
  object.updatedAt = reader.readDateTime(offsets[3]);
  object.walkingTimeGoalMinutes = reader.readLongOrNull(offsets[4]);
  return object;
}

P _goalModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _goalModelGetId(GoalModel object) {
  return object.goalId;
}

List<IsarLinkBase<dynamic>> _goalModelGetLinks(GoalModel object) {
  return [];
}

void _goalModelAttach(IsarCollection<dynamic> col, Id id, GoalModel object) {
  object.goalId = id;
}

extension GoalModelQueryWhereSort
    on QueryBuilder<GoalModel, GoalModel, QWhere> {
  QueryBuilder<GoalModel, GoalModel, QAfterWhere> anyGoalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GoalModelQueryWhere
    on QueryBuilder<GoalModel, GoalModel, QWhereClause> {
  QueryBuilder<GoalModel, GoalModel, QAfterWhereClause> goalIdEqualTo(
    Id goalId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(lower: goalId, upper: goalId),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterWhereClause> goalIdNotEqualTo(
    Id goalId,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: goalId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: goalId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: goalId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: goalId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterWhereClause> goalIdGreaterThan(
    Id goalId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: goalId, includeLower: include),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterWhereClause> goalIdLessThan(
    Id goalId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: goalId, includeUpper: include),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterWhereClause> goalIdBetween(
    Id lowerGoalId,
    Id upperGoalId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerGoalId,
          includeLower: includeLower,
          upper: upperGoalId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension GoalModelQueryFilter
    on QueryBuilder<GoalModel, GoalModel, QFilterCondition> {
  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition>
  calorieGoalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'calorieGoal'),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition>
  calorieGoalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'calorieGoal'),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> calorieGoalEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'calorieGoal',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition>
  calorieGoalGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'calorieGoal',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> calorieGoalLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'calorieGoal',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> calorieGoalBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'calorieGoal',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition>
  distanceGoalKmIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'distanceGoalKm'),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition>
  distanceGoalKmIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'distanceGoalKm'),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition>
  distanceGoalKmEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'distanceGoalKm',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition>
  distanceGoalKmGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'distanceGoalKm',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition>
  distanceGoalKmLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'distanceGoalKm',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition>
  distanceGoalKmBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'distanceGoalKm',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> goalIdEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'goalId', value: value),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> goalIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'goalId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> goalIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'goalId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> goalIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'goalId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> stepGoalEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'stepGoal', value: value),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> stepGoalGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'stepGoal',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> stepGoalLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'stepGoal',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> stepGoalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'stepGoal',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> updatedAtEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition>
  updatedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'updatedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition>
  walkingTimeGoalMinutesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'walkingTimeGoalMinutes'),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition>
  walkingTimeGoalMinutesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'walkingTimeGoalMinutes'),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition>
  walkingTimeGoalMinutesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'walkingTimeGoalMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition>
  walkingTimeGoalMinutesGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'walkingTimeGoalMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition>
  walkingTimeGoalMinutesLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'walkingTimeGoalMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition>
  walkingTimeGoalMinutesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'walkingTimeGoalMinutes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension GoalModelQueryObject
    on QueryBuilder<GoalModel, GoalModel, QFilterCondition> {}

extension GoalModelQueryLinks
    on QueryBuilder<GoalModel, GoalModel, QFilterCondition> {}

extension GoalModelQuerySortBy on QueryBuilder<GoalModel, GoalModel, QSortBy> {
  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> sortByCalorieGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calorieGoal', Sort.asc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> sortByCalorieGoalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calorieGoal', Sort.desc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> sortByDistanceGoalKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceGoalKm', Sort.asc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> sortByDistanceGoalKmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceGoalKm', Sort.desc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> sortByStepGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stepGoal', Sort.asc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> sortByStepGoalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stepGoal', Sort.desc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy>
  sortByWalkingTimeGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walkingTimeGoalMinutes', Sort.asc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy>
  sortByWalkingTimeGoalMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walkingTimeGoalMinutes', Sort.desc);
    });
  }
}

extension GoalModelQuerySortThenBy
    on QueryBuilder<GoalModel, GoalModel, QSortThenBy> {
  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> thenByCalorieGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calorieGoal', Sort.asc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> thenByCalorieGoalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calorieGoal', Sort.desc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> thenByDistanceGoalKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceGoalKm', Sort.asc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> thenByDistanceGoalKmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceGoalKm', Sort.desc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> thenByGoalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalId', Sort.asc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> thenByGoalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalId', Sort.desc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> thenByStepGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stepGoal', Sort.asc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> thenByStepGoalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stepGoal', Sort.desc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy>
  thenByWalkingTimeGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walkingTimeGoalMinutes', Sort.asc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy>
  thenByWalkingTimeGoalMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walkingTimeGoalMinutes', Sort.desc);
    });
  }
}

extension GoalModelQueryWhereDistinct
    on QueryBuilder<GoalModel, GoalModel, QDistinct> {
  QueryBuilder<GoalModel, GoalModel, QDistinct> distinctByCalorieGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'calorieGoal');
    });
  }

  QueryBuilder<GoalModel, GoalModel, QDistinct> distinctByDistanceGoalKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distanceGoalKm');
    });
  }

  QueryBuilder<GoalModel, GoalModel, QDistinct> distinctByStepGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stepGoal');
    });
  }

  QueryBuilder<GoalModel, GoalModel, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<GoalModel, GoalModel, QDistinct>
  distinctByWalkingTimeGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'walkingTimeGoalMinutes');
    });
  }
}

extension GoalModelQueryProperty
    on QueryBuilder<GoalModel, GoalModel, QQueryProperty> {
  QueryBuilder<GoalModel, int, QQueryOperations> goalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goalId');
    });
  }

  QueryBuilder<GoalModel, double?, QQueryOperations> calorieGoalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'calorieGoal');
    });
  }

  QueryBuilder<GoalModel, double?, QQueryOperations> distanceGoalKmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distanceGoalKm');
    });
  }

  QueryBuilder<GoalModel, int, QQueryOperations> stepGoalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stepGoal');
    });
  }

  QueryBuilder<GoalModel, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<GoalModel, int?, QQueryOperations>
  walkingTimeGoalMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'walkingTimeGoalMinutes');
    });
  }
}

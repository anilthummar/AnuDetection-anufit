// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_goal_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWeightGoalModelCollection on Isar {
  IsarCollection<WeightGoalModel> get weightGoalModels => this.collection();
}

const WeightGoalModelSchema = CollectionSchema(
  name: r'WeightGoalModel',
  id: 3966716838809984987,
  properties: {
    r'goalWeightKg': PropertySchema(
      id: 0,
      name: r'goalWeightKg',
      type: IsarType.double,
    ),
    r'updatedAt': PropertySchema(
      id: 1,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
  },

  estimateSize: _weightGoalModelEstimateSize,
  serialize: _weightGoalModelSerialize,
  deserialize: _weightGoalModelDeserialize,
  deserializeProp: _weightGoalModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _weightGoalModelGetId,
  getLinks: _weightGoalModelGetLinks,
  attach: _weightGoalModelAttach,
  version: '3.3.2',
);

int _weightGoalModelEstimateSize(
  WeightGoalModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _weightGoalModelSerialize(
  WeightGoalModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.goalWeightKg);
  writer.writeDateTime(offsets[1], object.updatedAt);
}

WeightGoalModel _weightGoalModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WeightGoalModel();
  object.goalWeightKg = reader.readDouble(offsets[0]);
  object.id = id;
  object.updatedAt = reader.readDateTime(offsets[1]);
  return object;
}

P _weightGoalModelDeserializeProp<P>(
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
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _weightGoalModelGetId(WeightGoalModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _weightGoalModelGetLinks(WeightGoalModel object) {
  return [];
}

void _weightGoalModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  WeightGoalModel object,
) {
  object.id = id;
}

extension WeightGoalModelQueryWhereSort
    on QueryBuilder<WeightGoalModel, WeightGoalModel, QWhere> {
  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WeightGoalModelQueryWhere
    on QueryBuilder<WeightGoalModel, WeightGoalModel, QWhereClause> {
  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterWhereClause>
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

  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterWhereClause> idBetween(
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
}

extension WeightGoalModelQueryFilter
    on QueryBuilder<WeightGoalModel, WeightGoalModel, QFilterCondition> {
  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterFilterCondition>
  goalWeightKgEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'goalWeightKg',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterFilterCondition>
  goalWeightKgGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'goalWeightKg',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterFilterCondition>
  goalWeightKgLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'goalWeightKg',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterFilterCondition>
  goalWeightKgBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'goalWeightKg',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterFilterCondition>
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

  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterFilterCondition>
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

  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterFilterCondition>
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

  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterFilterCondition>
  updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterFilterCondition>
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

  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterFilterCondition>
  updatedAtLessThan(DateTime value, {bool include = false}) {
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

  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterFilterCondition>
  updatedAtBetween(
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
}

extension WeightGoalModelQueryObject
    on QueryBuilder<WeightGoalModel, WeightGoalModel, QFilterCondition> {}

extension WeightGoalModelQueryLinks
    on QueryBuilder<WeightGoalModel, WeightGoalModel, QFilterCondition> {}

extension WeightGoalModelQuerySortBy
    on QueryBuilder<WeightGoalModel, WeightGoalModel, QSortBy> {
  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterSortBy>
  sortByGoalWeightKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalWeightKg', Sort.asc);
    });
  }

  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterSortBy>
  sortByGoalWeightKgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalWeightKg', Sort.desc);
    });
  }

  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterSortBy>
  sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension WeightGoalModelQuerySortThenBy
    on QueryBuilder<WeightGoalModel, WeightGoalModel, QSortThenBy> {
  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterSortBy>
  thenByGoalWeightKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalWeightKg', Sort.asc);
    });
  }

  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterSortBy>
  thenByGoalWeightKgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalWeightKg', Sort.desc);
    });
  }

  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterSortBy>
  thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<WeightGoalModel, WeightGoalModel, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension WeightGoalModelQueryWhereDistinct
    on QueryBuilder<WeightGoalModel, WeightGoalModel, QDistinct> {
  QueryBuilder<WeightGoalModel, WeightGoalModel, QDistinct>
  distinctByGoalWeightKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goalWeightKg');
    });
  }

  QueryBuilder<WeightGoalModel, WeightGoalModel, QDistinct>
  distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension WeightGoalModelQueryProperty
    on QueryBuilder<WeightGoalModel, WeightGoalModel, QQueryProperty> {
  QueryBuilder<WeightGoalModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WeightGoalModel, double, QQueryOperations>
  goalWeightKgProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goalWeightKg');
    });
  }

  QueryBuilder<WeightGoalModel, DateTime, QQueryOperations>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}

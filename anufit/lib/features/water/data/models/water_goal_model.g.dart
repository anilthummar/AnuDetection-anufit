// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_goal_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWaterGoalModelCollection on Isar {
  IsarCollection<WaterGoalModel> get waterGoalModels => this.collection();
}

const WaterGoalModelSchema = CollectionSchema(
  name: r'WaterGoalModel',
  id: -1107149124588164694,
  properties: {
    r'dailyGoalLiters': PropertySchema(
      id: 0,
      name: r'dailyGoalLiters',
      type: IsarType.double,
    ),
    r'updatedAt': PropertySchema(
      id: 1,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
  },

  estimateSize: _waterGoalModelEstimateSize,
  serialize: _waterGoalModelSerialize,
  deserialize: _waterGoalModelDeserialize,
  deserializeProp: _waterGoalModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _waterGoalModelGetId,
  getLinks: _waterGoalModelGetLinks,
  attach: _waterGoalModelAttach,
  version: '3.3.2',
);

int _waterGoalModelEstimateSize(
  WaterGoalModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _waterGoalModelSerialize(
  WaterGoalModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.dailyGoalLiters);
  writer.writeDateTime(offsets[1], object.updatedAt);
}

WaterGoalModel _waterGoalModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WaterGoalModel();
  object.dailyGoalLiters = reader.readDouble(offsets[0]);
  object.id = id;
  object.updatedAt = reader.readDateTime(offsets[1]);
  return object;
}

P _waterGoalModelDeserializeProp<P>(
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

Id _waterGoalModelGetId(WaterGoalModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _waterGoalModelGetLinks(WaterGoalModel object) {
  return [];
}

void _waterGoalModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  WaterGoalModel object,
) {
  object.id = id;
}

extension WaterGoalModelQueryWhereSort
    on QueryBuilder<WaterGoalModel, WaterGoalModel, QWhere> {
  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WaterGoalModelQueryWhere
    on QueryBuilder<WaterGoalModel, WaterGoalModel, QWhereClause> {
  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
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

  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterWhereClause> idBetween(
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

extension WaterGoalModelQueryFilter
    on QueryBuilder<WaterGoalModel, WaterGoalModel, QFilterCondition> {
  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterFilterCondition>
  dailyGoalLitersEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'dailyGoalLiters',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterFilterCondition>
  dailyGoalLitersGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'dailyGoalLiters',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterFilterCondition>
  dailyGoalLitersLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'dailyGoalLiters',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterFilterCondition>
  dailyGoalLitersBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'dailyGoalLiters',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterFilterCondition>
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

  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterFilterCondition>
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

  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterFilterCondition>
  updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterFilterCondition>
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

  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterFilterCondition>
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

  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterFilterCondition>
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

extension WaterGoalModelQueryObject
    on QueryBuilder<WaterGoalModel, WaterGoalModel, QFilterCondition> {}

extension WaterGoalModelQueryLinks
    on QueryBuilder<WaterGoalModel, WaterGoalModel, QFilterCondition> {}

extension WaterGoalModelQuerySortBy
    on QueryBuilder<WaterGoalModel, WaterGoalModel, QSortBy> {
  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterSortBy>
  sortByDailyGoalLiters() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyGoalLiters', Sort.asc);
    });
  }

  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterSortBy>
  sortByDailyGoalLitersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyGoalLiters', Sort.desc);
    });
  }

  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension WaterGoalModelQuerySortThenBy
    on QueryBuilder<WaterGoalModel, WaterGoalModel, QSortThenBy> {
  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterSortBy>
  thenByDailyGoalLiters() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyGoalLiters', Sort.asc);
    });
  }

  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterSortBy>
  thenByDailyGoalLitersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyGoalLiters', Sort.desc);
    });
  }

  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<WaterGoalModel, WaterGoalModel, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension WaterGoalModelQueryWhereDistinct
    on QueryBuilder<WaterGoalModel, WaterGoalModel, QDistinct> {
  QueryBuilder<WaterGoalModel, WaterGoalModel, QDistinct>
  distinctByDailyGoalLiters() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dailyGoalLiters');
    });
  }

  QueryBuilder<WaterGoalModel, WaterGoalModel, QDistinct>
  distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension WaterGoalModelQueryProperty
    on QueryBuilder<WaterGoalModel, WaterGoalModel, QQueryProperty> {
  QueryBuilder<WaterGoalModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WaterGoalModel, double, QQueryOperations>
  dailyGoalLitersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dailyGoalLiters');
    });
  }

  QueryBuilder<WaterGoalModel, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}

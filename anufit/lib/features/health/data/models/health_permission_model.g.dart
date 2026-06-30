// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_permission_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHealthPermissionModelCollection on Isar {
  IsarCollection<HealthPermissionModel> get healthPermissionModels =>
      this.collection();
}

const HealthPermissionModelSchema = CollectionSchema(
  name: r'HealthPermissionModel',
  id: -6030527934159244400,
  properties: {
    r'authorized': PropertySchema(
      id: 0,
      name: r'authorized',
      type: IsarType.bool,
    ),
    r'calories': PropertySchema(id: 1, name: r'calories', type: IsarType.bool),
    r'distance': PropertySchema(id: 2, name: r'distance', type: IsarType.bool),
    r'height': PropertySchema(id: 3, name: r'height', type: IsarType.bool),
    r'status': PropertySchema(id: 4, name: r'status', type: IsarType.string),
    r'steps': PropertySchema(id: 5, name: r'steps', type: IsarType.bool),
    r'weight': PropertySchema(id: 6, name: r'weight', type: IsarType.bool),
  },

  estimateSize: _healthPermissionModelEstimateSize,
  serialize: _healthPermissionModelSerialize,
  deserialize: _healthPermissionModelDeserialize,
  deserializeProp: _healthPermissionModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _healthPermissionModelGetId,
  getLinks: _healthPermissionModelGetLinks,
  attach: _healthPermissionModelAttach,
  version: '3.3.2',
);

int _healthPermissionModelEstimateSize(
  HealthPermissionModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.status.length * 3;
  return bytesCount;
}

void _healthPermissionModelSerialize(
  HealthPermissionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.authorized);
  writer.writeBool(offsets[1], object.calories);
  writer.writeBool(offsets[2], object.distance);
  writer.writeBool(offsets[3], object.height);
  writer.writeString(offsets[4], object.status);
  writer.writeBool(offsets[5], object.steps);
  writer.writeBool(offsets[6], object.weight);
}

HealthPermissionModel _healthPermissionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HealthPermissionModel();
  object.authorized = reader.readBool(offsets[0]);
  object.calories = reader.readBool(offsets[1]);
  object.distance = reader.readBool(offsets[2]);
  object.height = reader.readBool(offsets[3]);
  object.id = id;
  object.status = reader.readString(offsets[4]);
  object.steps = reader.readBool(offsets[5]);
  object.weight = reader.readBool(offsets[6]);
  return object;
}

P _healthPermissionModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _healthPermissionModelGetId(HealthPermissionModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _healthPermissionModelGetLinks(
  HealthPermissionModel object,
) {
  return [];
}

void _healthPermissionModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  HealthPermissionModel object,
) {
  object.id = id;
}

extension HealthPermissionModelQueryWhereSort
    on QueryBuilder<HealthPermissionModel, HealthPermissionModel, QWhere> {
  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension HealthPermissionModelQueryWhere
    on
        QueryBuilder<
          HealthPermissionModel,
          HealthPermissionModel,
          QWhereClause
        > {
  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterWhereClause>
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

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterWhereClause>
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
}

extension HealthPermissionModelQueryFilter
    on
        QueryBuilder<
          HealthPermissionModel,
          HealthPermissionModel,
          QFilterCondition
        > {
  QueryBuilder<
    HealthPermissionModel,
    HealthPermissionModel,
    QAfterFilterCondition
  >
  authorizedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'authorized', value: value),
      );
    });
  }

  QueryBuilder<
    HealthPermissionModel,
    HealthPermissionModel,
    QAfterFilterCondition
  >
  caloriesEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'calories', value: value),
      );
    });
  }

  QueryBuilder<
    HealthPermissionModel,
    HealthPermissionModel,
    QAfterFilterCondition
  >
  distanceEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'distance', value: value),
      );
    });
  }

  QueryBuilder<
    HealthPermissionModel,
    HealthPermissionModel,
    QAfterFilterCondition
  >
  heightEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'height', value: value),
      );
    });
  }

  QueryBuilder<
    HealthPermissionModel,
    HealthPermissionModel,
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
    HealthPermissionModel,
    HealthPermissionModel,
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
    HealthPermissionModel,
    HealthPermissionModel,
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
    HealthPermissionModel,
    HealthPermissionModel,
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
    HealthPermissionModel,
    HealthPermissionModel,
    QAfterFilterCondition
  >
  statusEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    HealthPermissionModel,
    HealthPermissionModel,
    QAfterFilterCondition
  >
  statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    HealthPermissionModel,
    HealthPermissionModel,
    QAfterFilterCondition
  >
  statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    HealthPermissionModel,
    HealthPermissionModel,
    QAfterFilterCondition
  >
  statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'status',
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
    HealthPermissionModel,
    HealthPermissionModel,
    QAfterFilterCondition
  >
  statusStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    HealthPermissionModel,
    HealthPermissionModel,
    QAfterFilterCondition
  >
  statusEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    HealthPermissionModel,
    HealthPermissionModel,
    QAfterFilterCondition
  >
  statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    HealthPermissionModel,
    HealthPermissionModel,
    QAfterFilterCondition
  >
  statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'status',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    HealthPermissionModel,
    HealthPermissionModel,
    QAfterFilterCondition
  >
  statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<
    HealthPermissionModel,
    HealthPermissionModel,
    QAfterFilterCondition
  >
  statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<
    HealthPermissionModel,
    HealthPermissionModel,
    QAfterFilterCondition
  >
  stepsEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'steps', value: value),
      );
    });
  }

  QueryBuilder<
    HealthPermissionModel,
    HealthPermissionModel,
    QAfterFilterCondition
  >
  weightEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'weight', value: value),
      );
    });
  }
}

extension HealthPermissionModelQueryObject
    on
        QueryBuilder<
          HealthPermissionModel,
          HealthPermissionModel,
          QFilterCondition
        > {}

extension HealthPermissionModelQueryLinks
    on
        QueryBuilder<
          HealthPermissionModel,
          HealthPermissionModel,
          QFilterCondition
        > {}

extension HealthPermissionModelQuerySortBy
    on QueryBuilder<HealthPermissionModel, HealthPermissionModel, QSortBy> {
  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  sortByAuthorized() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authorized', Sort.asc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  sortByAuthorizedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authorized', Sort.desc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  sortByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.asc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  sortByCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.desc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  sortByDistance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distance', Sort.asc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  sortByDistanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distance', Sort.desc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  sortByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.asc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  sortByHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.desc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  sortBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.asc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  sortByStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.desc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  sortByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.asc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  sortByWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.desc);
    });
  }
}

extension HealthPermissionModelQuerySortThenBy
    on QueryBuilder<HealthPermissionModel, HealthPermissionModel, QSortThenBy> {
  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  thenByAuthorized() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authorized', Sort.asc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  thenByAuthorizedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authorized', Sort.desc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  thenByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.asc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  thenByCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.desc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  thenByDistance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distance', Sort.asc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  thenByDistanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distance', Sort.desc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  thenByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.asc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  thenByHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.desc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  thenBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.asc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  thenByStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.desc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  thenByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.asc);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QAfterSortBy>
  thenByWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.desc);
    });
  }
}

extension HealthPermissionModelQueryWhereDistinct
    on QueryBuilder<HealthPermissionModel, HealthPermissionModel, QDistinct> {
  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QDistinct>
  distinctByAuthorized() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'authorized');
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QDistinct>
  distinctByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'calories');
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QDistinct>
  distinctByDistance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distance');
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QDistinct>
  distinctByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'height');
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QDistinct>
  distinctByStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QDistinct>
  distinctBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'steps');
    });
  }

  QueryBuilder<HealthPermissionModel, HealthPermissionModel, QDistinct>
  distinctByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weight');
    });
  }
}

extension HealthPermissionModelQueryProperty
    on
        QueryBuilder<
          HealthPermissionModel,
          HealthPermissionModel,
          QQueryProperty
        > {
  QueryBuilder<HealthPermissionModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<HealthPermissionModel, bool, QQueryOperations>
  authorizedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'authorized');
    });
  }

  QueryBuilder<HealthPermissionModel, bool, QQueryOperations>
  caloriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'calories');
    });
  }

  QueryBuilder<HealthPermissionModel, bool, QQueryOperations>
  distanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distance');
    });
  }

  QueryBuilder<HealthPermissionModel, bool, QQueryOperations> heightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'height');
    });
  }

  QueryBuilder<HealthPermissionModel, String, QQueryOperations>
  statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<HealthPermissionModel, bool, QQueryOperations> stepsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'steps');
    });
  }

  QueryBuilder<HealthPermissionModel, bool, QQueryOperations> weightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weight');
    });
  }
}

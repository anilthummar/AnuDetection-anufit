// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourly_step_record_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHourlyStepRecordModelCollection on Isar {
  IsarCollection<HourlyStepRecordModel> get hourlyStepRecordModels =>
      this.collection();
}

const HourlyStepRecordModelSchema = CollectionSchema(
  name: r'HourlyStepRecordModel',
  id: -4512548729156433472,
  properties: {
    r'hourStart': PropertySchema(
      id: 0,
      name: r'hourStart',
      type: IsarType.dateTime,
    ),
    r'steps': PropertySchema(id: 1, name: r'steps', type: IsarType.long),
  },

  estimateSize: _hourlyStepRecordModelEstimateSize,
  serialize: _hourlyStepRecordModelSerialize,
  deserialize: _hourlyStepRecordModelDeserialize,
  deserializeProp: _hourlyStepRecordModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'hourStart': IndexSchema(
      id: -9202472974871149580,
      name: r'hourStart',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'hourStart',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _hourlyStepRecordModelGetId,
  getLinks: _hourlyStepRecordModelGetLinks,
  attach: _hourlyStepRecordModelAttach,
  version: '3.3.2',
);

int _hourlyStepRecordModelEstimateSize(
  HourlyStepRecordModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _hourlyStepRecordModelSerialize(
  HourlyStepRecordModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.hourStart);
  writer.writeLong(offsets[1], object.steps);
}

HourlyStepRecordModel _hourlyStepRecordModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HourlyStepRecordModel();
  object.hourStart = reader.readDateTime(offsets[0]);
  object.id = id;
  object.steps = reader.readLong(offsets[1]);
  return object;
}

P _hourlyStepRecordModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _hourlyStepRecordModelGetId(HourlyStepRecordModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _hourlyStepRecordModelGetLinks(
  HourlyStepRecordModel object,
) {
  return [];
}

void _hourlyStepRecordModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  HourlyStepRecordModel object,
) {
  object.id = id;
}

extension HourlyStepRecordModelByIndex
    on IsarCollection<HourlyStepRecordModel> {
  Future<HourlyStepRecordModel?> getByHourStart(DateTime hourStart) {
    return getByIndex(r'hourStart', [hourStart]);
  }

  HourlyStepRecordModel? getByHourStartSync(DateTime hourStart) {
    return getByIndexSync(r'hourStart', [hourStart]);
  }

  Future<bool> deleteByHourStart(DateTime hourStart) {
    return deleteByIndex(r'hourStart', [hourStart]);
  }

  bool deleteByHourStartSync(DateTime hourStart) {
    return deleteByIndexSync(r'hourStart', [hourStart]);
  }

  Future<List<HourlyStepRecordModel?>> getAllByHourStart(
    List<DateTime> hourStartValues,
  ) {
    final values = hourStartValues.map((e) => [e]).toList();
    return getAllByIndex(r'hourStart', values);
  }

  List<HourlyStepRecordModel?> getAllByHourStartSync(
    List<DateTime> hourStartValues,
  ) {
    final values = hourStartValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'hourStart', values);
  }

  Future<int> deleteAllByHourStart(List<DateTime> hourStartValues) {
    final values = hourStartValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'hourStart', values);
  }

  int deleteAllByHourStartSync(List<DateTime> hourStartValues) {
    final values = hourStartValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'hourStart', values);
  }

  Future<Id> putByHourStart(HourlyStepRecordModel object) {
    return putByIndex(r'hourStart', object);
  }

  Id putByHourStartSync(HourlyStepRecordModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'hourStart', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByHourStart(List<HourlyStepRecordModel> objects) {
    return putAllByIndex(r'hourStart', objects);
  }

  List<Id> putAllByHourStartSync(
    List<HourlyStepRecordModel> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'hourStart', objects, saveLinks: saveLinks);
  }
}

extension HourlyStepRecordModelQueryWhereSort
    on QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QWhere> {
  QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QAfterWhere>
  anyHourStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'hourStart'),
      );
    });
  }
}

extension HourlyStepRecordModelQueryWhere
    on
        QueryBuilder<
          HourlyStepRecordModel,
          HourlyStepRecordModel,
          QWhereClause
        > {
  QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QAfterWhereClause>
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

  QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QAfterWhereClause>
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

  QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QAfterWhereClause>
  hourStartEqualTo(DateTime hourStart) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'hourStart', value: [hourStart]),
      );
    });
  }

  QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QAfterWhereClause>
  hourStartNotEqualTo(DateTime hourStart) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'hourStart',
                lower: [],
                upper: [hourStart],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'hourStart',
                lower: [hourStart],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'hourStart',
                lower: [hourStart],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'hourStart',
                lower: [],
                upper: [hourStart],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QAfterWhereClause>
  hourStartGreaterThan(DateTime hourStart, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'hourStart',
          lower: [hourStart],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QAfterWhereClause>
  hourStartLessThan(DateTime hourStart, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'hourStart',
          lower: [],
          upper: [hourStart],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QAfterWhereClause>
  hourStartBetween(
    DateTime lowerHourStart,
    DateTime upperHourStart, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'hourStart',
          lower: [lowerHourStart],
          includeLower: includeLower,
          upper: [upperHourStart],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension HourlyStepRecordModelQueryFilter
    on
        QueryBuilder<
          HourlyStepRecordModel,
          HourlyStepRecordModel,
          QFilterCondition
        > {
  QueryBuilder<
    HourlyStepRecordModel,
    HourlyStepRecordModel,
    QAfterFilterCondition
  >
  hourStartEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hourStart', value: value),
      );
    });
  }

  QueryBuilder<
    HourlyStepRecordModel,
    HourlyStepRecordModel,
    QAfterFilterCondition
  >
  hourStartGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'hourStart',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    HourlyStepRecordModel,
    HourlyStepRecordModel,
    QAfterFilterCondition
  >
  hourStartLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'hourStart',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    HourlyStepRecordModel,
    HourlyStepRecordModel,
    QAfterFilterCondition
  >
  hourStartBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'hourStart',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    HourlyStepRecordModel,
    HourlyStepRecordModel,
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
    HourlyStepRecordModel,
    HourlyStepRecordModel,
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
    HourlyStepRecordModel,
    HourlyStepRecordModel,
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
    HourlyStepRecordModel,
    HourlyStepRecordModel,
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
    HourlyStepRecordModel,
    HourlyStepRecordModel,
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
    HourlyStepRecordModel,
    HourlyStepRecordModel,
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
    HourlyStepRecordModel,
    HourlyStepRecordModel,
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
    HourlyStepRecordModel,
    HourlyStepRecordModel,
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
}

extension HourlyStepRecordModelQueryObject
    on
        QueryBuilder<
          HourlyStepRecordModel,
          HourlyStepRecordModel,
          QFilterCondition
        > {}

extension HourlyStepRecordModelQueryLinks
    on
        QueryBuilder<
          HourlyStepRecordModel,
          HourlyStepRecordModel,
          QFilterCondition
        > {}

extension HourlyStepRecordModelQuerySortBy
    on QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QSortBy> {
  QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QAfterSortBy>
  sortByHourStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hourStart', Sort.asc);
    });
  }

  QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QAfterSortBy>
  sortByHourStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hourStart', Sort.desc);
    });
  }

  QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QAfterSortBy>
  sortBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.asc);
    });
  }

  QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QAfterSortBy>
  sortByStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.desc);
    });
  }
}

extension HourlyStepRecordModelQuerySortThenBy
    on QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QSortThenBy> {
  QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QAfterSortBy>
  thenByHourStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hourStart', Sort.asc);
    });
  }

  QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QAfterSortBy>
  thenByHourStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hourStart', Sort.desc);
    });
  }

  QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QAfterSortBy>
  thenBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.asc);
    });
  }

  QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QAfterSortBy>
  thenByStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.desc);
    });
  }
}

extension HourlyStepRecordModelQueryWhereDistinct
    on QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QDistinct> {
  QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QDistinct>
  distinctByHourStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hourStart');
    });
  }

  QueryBuilder<HourlyStepRecordModel, HourlyStepRecordModel, QDistinct>
  distinctBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'steps');
    });
  }
}

extension HourlyStepRecordModelQueryProperty
    on
        QueryBuilder<
          HourlyStepRecordModel,
          HourlyStepRecordModel,
          QQueryProperty
        > {
  QueryBuilder<HourlyStepRecordModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<HourlyStepRecordModel, DateTime, QQueryOperations>
  hourStartProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hourStart');
    });
  }

  QueryBuilder<HourlyStepRecordModel, int, QQueryOperations> stepsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'steps');
    });
  }
}

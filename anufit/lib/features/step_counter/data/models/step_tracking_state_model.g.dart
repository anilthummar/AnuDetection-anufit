// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_tracking_state_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStepTrackingStateModelCollection on Isar {
  IsarCollection<StepTrackingStateModel> get stepTrackingStateModels =>
      this.collection();
}

const StepTrackingStateModelSchema = CollectionSchema(
  name: r'StepTrackingStateModel',
  id: -2385455359195917589,
  properties: {
    r'baselineDate': PropertySchema(
      id: 0,
      name: r'baselineDate',
      type: IsarType.dateTime,
    ),
    r'dailyBaseline': PropertySchema(
      id: 1,
      name: r'dailyBaseline',
      type: IsarType.long,
    ),
    r'isPaused': PropertySchema(id: 2, name: r'isPaused', type: IsarType.bool),
    r'isTracking': PropertySchema(
      id: 3,
      name: r'isTracking',
      type: IsarType.bool,
    ),
    r'lastHardwareTotal': PropertySchema(
      id: 4,
      name: r'lastHardwareTotal',
      type: IsarType.long,
    ),
    r'manualAdjustment': PropertySchema(
      id: 5,
      name: r'manualAdjustment',
      type: IsarType.long,
    ),
    r'timezoneId': PropertySchema(
      id: 6,
      name: r'timezoneId',
      type: IsarType.string,
    ),
  },

  estimateSize: _stepTrackingStateModelEstimateSize,
  serialize: _stepTrackingStateModelSerialize,
  deserialize: _stepTrackingStateModelDeserialize,
  deserializeProp: _stepTrackingStateModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _stepTrackingStateModelGetId,
  getLinks: _stepTrackingStateModelGetLinks,
  attach: _stepTrackingStateModelAttach,
  version: '3.3.2',
);

int _stepTrackingStateModelEstimateSize(
  StepTrackingStateModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.timezoneId.length * 3;
  return bytesCount;
}

void _stepTrackingStateModelSerialize(
  StepTrackingStateModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.baselineDate);
  writer.writeLong(offsets[1], object.dailyBaseline);
  writer.writeBool(offsets[2], object.isPaused);
  writer.writeBool(offsets[3], object.isTracking);
  writer.writeLong(offsets[4], object.lastHardwareTotal);
  writer.writeLong(offsets[5], object.manualAdjustment);
  writer.writeString(offsets[6], object.timezoneId);
}

StepTrackingStateModel _stepTrackingStateModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StepTrackingStateModel();
  object.baselineDate = reader.readDateTime(offsets[0]);
  object.dailyBaseline = reader.readLong(offsets[1]);
  object.id = id;
  object.isPaused = reader.readBool(offsets[2]);
  object.isTracking = reader.readBool(offsets[3]);
  object.lastHardwareTotal = reader.readLong(offsets[4]);
  object.manualAdjustment = reader.readLong(offsets[5]);
  object.timezoneId = reader.readString(offsets[6]);
  return object;
}

P _stepTrackingStateModelDeserializeProp<P>(
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
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _stepTrackingStateModelGetId(StepTrackingStateModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _stepTrackingStateModelGetLinks(
  StepTrackingStateModel object,
) {
  return [];
}

void _stepTrackingStateModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  StepTrackingStateModel object,
) {
  object.id = id;
}

extension StepTrackingStateModelQueryWhereSort
    on QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QWhere> {
  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension StepTrackingStateModelQueryWhere
    on
        QueryBuilder<
          StepTrackingStateModel,
          StepTrackingStateModel,
          QWhereClause
        > {
  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterWhereClause
  >
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterWhereClause
  >
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

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterWhereClause
  >
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterWhereClause
  >
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterWhereClause
  >
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

extension StepTrackingStateModelQueryFilter
    on
        QueryBuilder<
          StepTrackingStateModel,
          StepTrackingStateModel,
          QFilterCondition
        > {
  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  baselineDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'baselineDate', value: value),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  baselineDateGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'baselineDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  baselineDateLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'baselineDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  baselineDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'baselineDate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  dailyBaselineEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'dailyBaseline', value: value),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  dailyBaselineGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'dailyBaseline',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  dailyBaselineLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'dailyBaseline',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  dailyBaselineBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'dailyBaseline',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
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
    StepTrackingStateModel,
    StepTrackingStateModel,
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
    StepTrackingStateModel,
    StepTrackingStateModel,
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
    StepTrackingStateModel,
    StepTrackingStateModel,
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
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  isPausedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isPaused', value: value),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  isTrackingEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isTracking', value: value),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  lastHardwareTotalEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastHardwareTotal', value: value),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  lastHardwareTotalGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastHardwareTotal',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  lastHardwareTotalLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastHardwareTotal',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  lastHardwareTotalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastHardwareTotal',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  manualAdjustmentEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'manualAdjustment', value: value),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  manualAdjustmentGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'manualAdjustment',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  manualAdjustmentLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'manualAdjustment',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  manualAdjustmentBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'manualAdjustment',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  timezoneIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'timezoneId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  timezoneIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'timezoneId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  timezoneIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'timezoneId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  timezoneIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'timezoneId',
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
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  timezoneIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'timezoneId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  timezoneIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'timezoneId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  timezoneIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'timezoneId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  timezoneIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'timezoneId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  timezoneIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'timezoneId', value: ''),
      );
    });
  }

  QueryBuilder<
    StepTrackingStateModel,
    StepTrackingStateModel,
    QAfterFilterCondition
  >
  timezoneIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'timezoneId', value: ''),
      );
    });
  }
}

extension StepTrackingStateModelQueryObject
    on
        QueryBuilder<
          StepTrackingStateModel,
          StepTrackingStateModel,
          QFilterCondition
        > {}

extension StepTrackingStateModelQueryLinks
    on
        QueryBuilder<
          StepTrackingStateModel,
          StepTrackingStateModel,
          QFilterCondition
        > {}

extension StepTrackingStateModelQuerySortBy
    on QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QSortBy> {
  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  sortByBaselineDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'baselineDate', Sort.asc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  sortByBaselineDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'baselineDate', Sort.desc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  sortByDailyBaseline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyBaseline', Sort.asc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  sortByDailyBaselineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyBaseline', Sort.desc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  sortByIsPaused() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPaused', Sort.asc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  sortByIsPausedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPaused', Sort.desc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  sortByIsTracking() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTracking', Sort.asc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  sortByIsTrackingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTracking', Sort.desc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  sortByLastHardwareTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastHardwareTotal', Sort.asc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  sortByLastHardwareTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastHardwareTotal', Sort.desc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  sortByManualAdjustment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manualAdjustment', Sort.asc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  sortByManualAdjustmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manualAdjustment', Sort.desc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  sortByTimezoneId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timezoneId', Sort.asc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  sortByTimezoneIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timezoneId', Sort.desc);
    });
  }
}

extension StepTrackingStateModelQuerySortThenBy
    on
        QueryBuilder<
          StepTrackingStateModel,
          StepTrackingStateModel,
          QSortThenBy
        > {
  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  thenByBaselineDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'baselineDate', Sort.asc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  thenByBaselineDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'baselineDate', Sort.desc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  thenByDailyBaseline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyBaseline', Sort.asc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  thenByDailyBaselineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyBaseline', Sort.desc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  thenByIsPaused() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPaused', Sort.asc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  thenByIsPausedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPaused', Sort.desc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  thenByIsTracking() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTracking', Sort.asc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  thenByIsTrackingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTracking', Sort.desc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  thenByLastHardwareTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastHardwareTotal', Sort.asc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  thenByLastHardwareTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastHardwareTotal', Sort.desc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  thenByManualAdjustment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manualAdjustment', Sort.asc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  thenByManualAdjustmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manualAdjustment', Sort.desc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  thenByTimezoneId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timezoneId', Sort.asc);
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QAfterSortBy>
  thenByTimezoneIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timezoneId', Sort.desc);
    });
  }
}

extension StepTrackingStateModelQueryWhereDistinct
    on QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QDistinct> {
  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QDistinct>
  distinctByBaselineDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'baselineDate');
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QDistinct>
  distinctByDailyBaseline() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dailyBaseline');
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QDistinct>
  distinctByIsPaused() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPaused');
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QDistinct>
  distinctByIsTracking() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isTracking');
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QDistinct>
  distinctByLastHardwareTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastHardwareTotal');
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QDistinct>
  distinctByManualAdjustment() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'manualAdjustment');
    });
  }

  QueryBuilder<StepTrackingStateModel, StepTrackingStateModel, QDistinct>
  distinctByTimezoneId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timezoneId', caseSensitive: caseSensitive);
    });
  }
}

extension StepTrackingStateModelQueryProperty
    on
        QueryBuilder<
          StepTrackingStateModel,
          StepTrackingStateModel,
          QQueryProperty
        > {
  QueryBuilder<StepTrackingStateModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<StepTrackingStateModel, DateTime, QQueryOperations>
  baselineDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'baselineDate');
    });
  }

  QueryBuilder<StepTrackingStateModel, int, QQueryOperations>
  dailyBaselineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dailyBaseline');
    });
  }

  QueryBuilder<StepTrackingStateModel, bool, QQueryOperations>
  isPausedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPaused');
    });
  }

  QueryBuilder<StepTrackingStateModel, bool, QQueryOperations>
  isTrackingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isTracking');
    });
  }

  QueryBuilder<StepTrackingStateModel, int, QQueryOperations>
  lastHardwareTotalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastHardwareTotal');
    });
  }

  QueryBuilder<StepTrackingStateModel, int, QQueryOperations>
  manualAdjustmentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'manualAdjustment');
    });
  }

  QueryBuilder<StepTrackingStateModel, String, QQueryOperations>
  timezoneIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timezoneId');
    });
  }
}

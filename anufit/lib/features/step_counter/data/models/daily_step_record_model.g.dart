// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_step_record_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDailyStepRecordModelCollection on Isar {
  IsarCollection<DailyStepRecordModel> get dailyStepRecordModels =>
      this.collection();
}

const DailyStepRecordModelSchema = CollectionSchema(
  name: r'DailyStepRecordModel',
  id: -3407006098144940865,
  properties: {
    r'date': PropertySchema(id: 0, name: r'date', type: IsarType.dateTime),
    r'hardwareBaseline': PropertySchema(
      id: 1,
      name: r'hardwareBaseline',
      type: IsarType.long,
    ),
    r'hardwareTotalEnd': PropertySchema(
      id: 2,
      name: r'hardwareTotalEnd',
      type: IsarType.long,
    ),
    r'steps': PropertySchema(id: 3, name: r'steps', type: IsarType.long),
  },

  estimateSize: _dailyStepRecordModelEstimateSize,
  serialize: _dailyStepRecordModelSerialize,
  deserialize: _dailyStepRecordModelDeserialize,
  deserializeProp: _dailyStepRecordModelDeserializeProp,
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

  getId: _dailyStepRecordModelGetId,
  getLinks: _dailyStepRecordModelGetLinks,
  attach: _dailyStepRecordModelAttach,
  version: '3.3.2',
);

int _dailyStepRecordModelEstimateSize(
  DailyStepRecordModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _dailyStepRecordModelSerialize(
  DailyStepRecordModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeLong(offsets[1], object.hardwareBaseline);
  writer.writeLong(offsets[2], object.hardwareTotalEnd);
  writer.writeLong(offsets[3], object.steps);
}

DailyStepRecordModel _dailyStepRecordModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DailyStepRecordModel();
  object.date = reader.readDateTime(offsets[0]);
  object.hardwareBaseline = reader.readLong(offsets[1]);
  object.hardwareTotalEnd = reader.readLong(offsets[2]);
  object.id = id;
  object.steps = reader.readLong(offsets[3]);
  return object;
}

P _dailyStepRecordModelDeserializeProp<P>(
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
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dailyStepRecordModelGetId(DailyStepRecordModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dailyStepRecordModelGetLinks(
  DailyStepRecordModel object,
) {
  return [];
}

void _dailyStepRecordModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  DailyStepRecordModel object,
) {
  object.id = id;
}

extension DailyStepRecordModelByIndex on IsarCollection<DailyStepRecordModel> {
  Future<DailyStepRecordModel?> getByDate(DateTime date) {
    return getByIndex(r'date', [date]);
  }

  DailyStepRecordModel? getByDateSync(DateTime date) {
    return getByIndexSync(r'date', [date]);
  }

  Future<bool> deleteByDate(DateTime date) {
    return deleteByIndex(r'date', [date]);
  }

  bool deleteByDateSync(DateTime date) {
    return deleteByIndexSync(r'date', [date]);
  }

  Future<List<DailyStepRecordModel?>> getAllByDate(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return getAllByIndex(r'date', values);
  }

  List<DailyStepRecordModel?> getAllByDateSync(List<DateTime> dateValues) {
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

  Future<Id> putByDate(DailyStepRecordModel object) {
    return putByIndex(r'date', object);
  }

  Id putByDateSync(DailyStepRecordModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'date', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDate(List<DailyStepRecordModel> objects) {
    return putAllByIndex(r'date', objects);
  }

  List<Id> putAllByDateSync(
    List<DailyStepRecordModel> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'date', objects, saveLinks: saveLinks);
  }
}

extension DailyStepRecordModelQueryWhereSort
    on QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QWhere> {
  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterWhere>
  anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }
}

extension DailyStepRecordModelQueryWhere
    on QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QWhereClause> {
  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterWhereClause>
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

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterWhereClause>
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

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterWhereClause>
  dateEqualTo(DateTime date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'date', value: [date]),
      );
    });
  }

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterWhereClause>
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

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterWhereClause>
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

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterWhereClause>
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

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterWhereClause>
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

extension DailyStepRecordModelQueryFilter
    on
        QueryBuilder<
          DailyStepRecordModel,
          DailyStepRecordModel,
          QFilterCondition
        > {
  QueryBuilder<
    DailyStepRecordModel,
    DailyStepRecordModel,
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
    DailyStepRecordModel,
    DailyStepRecordModel,
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
    DailyStepRecordModel,
    DailyStepRecordModel,
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
    DailyStepRecordModel,
    DailyStepRecordModel,
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
    DailyStepRecordModel,
    DailyStepRecordModel,
    QAfterFilterCondition
  >
  hardwareBaselineEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hardwareBaseline', value: value),
      );
    });
  }

  QueryBuilder<
    DailyStepRecordModel,
    DailyStepRecordModel,
    QAfterFilterCondition
  >
  hardwareBaselineGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'hardwareBaseline',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    DailyStepRecordModel,
    DailyStepRecordModel,
    QAfterFilterCondition
  >
  hardwareBaselineLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'hardwareBaseline',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    DailyStepRecordModel,
    DailyStepRecordModel,
    QAfterFilterCondition
  >
  hardwareBaselineBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'hardwareBaseline',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    DailyStepRecordModel,
    DailyStepRecordModel,
    QAfterFilterCondition
  >
  hardwareTotalEndEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hardwareTotalEnd', value: value),
      );
    });
  }

  QueryBuilder<
    DailyStepRecordModel,
    DailyStepRecordModel,
    QAfterFilterCondition
  >
  hardwareTotalEndGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'hardwareTotalEnd',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    DailyStepRecordModel,
    DailyStepRecordModel,
    QAfterFilterCondition
  >
  hardwareTotalEndLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'hardwareTotalEnd',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    DailyStepRecordModel,
    DailyStepRecordModel,
    QAfterFilterCondition
  >
  hardwareTotalEndBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'hardwareTotalEnd',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    DailyStepRecordModel,
    DailyStepRecordModel,
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
    DailyStepRecordModel,
    DailyStepRecordModel,
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
    DailyStepRecordModel,
    DailyStepRecordModel,
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
    DailyStepRecordModel,
    DailyStepRecordModel,
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
    DailyStepRecordModel,
    DailyStepRecordModel,
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
    DailyStepRecordModel,
    DailyStepRecordModel,
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
    DailyStepRecordModel,
    DailyStepRecordModel,
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
    DailyStepRecordModel,
    DailyStepRecordModel,
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

extension DailyStepRecordModelQueryObject
    on
        QueryBuilder<
          DailyStepRecordModel,
          DailyStepRecordModel,
          QFilterCondition
        > {}

extension DailyStepRecordModelQueryLinks
    on
        QueryBuilder<
          DailyStepRecordModel,
          DailyStepRecordModel,
          QFilterCondition
        > {}

extension DailyStepRecordModelQuerySortBy
    on QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QSortBy> {
  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterSortBy>
  sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterSortBy>
  sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterSortBy>
  sortByHardwareBaseline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hardwareBaseline', Sort.asc);
    });
  }

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterSortBy>
  sortByHardwareBaselineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hardwareBaseline', Sort.desc);
    });
  }

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterSortBy>
  sortByHardwareTotalEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hardwareTotalEnd', Sort.asc);
    });
  }

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterSortBy>
  sortByHardwareTotalEndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hardwareTotalEnd', Sort.desc);
    });
  }

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterSortBy>
  sortBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.asc);
    });
  }

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterSortBy>
  sortByStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.desc);
    });
  }
}

extension DailyStepRecordModelQuerySortThenBy
    on QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QSortThenBy> {
  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterSortBy>
  thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterSortBy>
  thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterSortBy>
  thenByHardwareBaseline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hardwareBaseline', Sort.asc);
    });
  }

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterSortBy>
  thenByHardwareBaselineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hardwareBaseline', Sort.desc);
    });
  }

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterSortBy>
  thenByHardwareTotalEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hardwareTotalEnd', Sort.asc);
    });
  }

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterSortBy>
  thenByHardwareTotalEndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hardwareTotalEnd', Sort.desc);
    });
  }

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterSortBy>
  thenBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.asc);
    });
  }

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QAfterSortBy>
  thenByStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.desc);
    });
  }
}

extension DailyStepRecordModelQueryWhereDistinct
    on QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QDistinct> {
  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QDistinct>
  distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QDistinct>
  distinctByHardwareBaseline() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hardwareBaseline');
    });
  }

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QDistinct>
  distinctByHardwareTotalEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hardwareTotalEnd');
    });
  }

  QueryBuilder<DailyStepRecordModel, DailyStepRecordModel, QDistinct>
  distinctBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'steps');
    });
  }
}

extension DailyStepRecordModelQueryProperty
    on
        QueryBuilder<
          DailyStepRecordModel,
          DailyStepRecordModel,
          QQueryProperty
        > {
  QueryBuilder<DailyStepRecordModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DailyStepRecordModel, DateTime, QQueryOperations>
  dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<DailyStepRecordModel, int, QQueryOperations>
  hardwareBaselineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hardwareBaseline');
    });
  }

  QueryBuilder<DailyStepRecordModel, int, QQueryOperations>
  hardwareTotalEndProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hardwareTotalEnd');
    });
  }

  QueryBuilder<DailyStepRecordModel, int, QQueryOperations> stepsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'steps');
    });
  }
}

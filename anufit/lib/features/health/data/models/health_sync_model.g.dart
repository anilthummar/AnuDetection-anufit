// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_sync_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHealthSyncModelCollection on Isar {
  IsarCollection<HealthSyncModel> get healthSyncModels => this.collection();
}

const HealthSyncModelSchema = CollectionSchema(
  name: r'HealthSyncModel',
  id: 185669936424051165,
  properties: {
    r'errorMessage': PropertySchema(
      id: 0,
      name: r'errorMessage',
      type: IsarType.string,
    ),
    r'lastIncrementalSync': PropertySchema(
      id: 1,
      name: r'lastIncrementalSync',
      type: IsarType.dateTime,
    ),
    r'lastSync': PropertySchema(
      id: 2,
      name: r'lastSync',
      type: IsarType.dateTime,
    ),
    r'recordsSynced': PropertySchema(
      id: 3,
      name: r'recordsSynced',
      type: IsarType.long,
    ),
    r'source': PropertySchema(id: 4, name: r'source', type: IsarType.string),
    r'status': PropertySchema(id: 5, name: r'status', type: IsarType.string),
  },

  estimateSize: _healthSyncModelEstimateSize,
  serialize: _healthSyncModelSerialize,
  deserialize: _healthSyncModelDeserialize,
  deserializeProp: _healthSyncModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _healthSyncModelGetId,
  getLinks: _healthSyncModelGetLinks,
  attach: _healthSyncModelAttach,
  version: '3.3.2',
);

int _healthSyncModelEstimateSize(
  HealthSyncModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.errorMessage;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.source.length * 3;
  bytesCount += 3 + object.status.length * 3;
  return bytesCount;
}

void _healthSyncModelSerialize(
  HealthSyncModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.errorMessage);
  writer.writeDateTime(offsets[1], object.lastIncrementalSync);
  writer.writeDateTime(offsets[2], object.lastSync);
  writer.writeLong(offsets[3], object.recordsSynced);
  writer.writeString(offsets[4], object.source);
  writer.writeString(offsets[5], object.status);
}

HealthSyncModel _healthSyncModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HealthSyncModel();
  object.errorMessage = reader.readStringOrNull(offsets[0]);
  object.id = id;
  object.lastIncrementalSync = reader.readDateTimeOrNull(offsets[1]);
  object.lastSync = reader.readDateTimeOrNull(offsets[2]);
  object.recordsSynced = reader.readLong(offsets[3]);
  object.source = reader.readString(offsets[4]);
  object.status = reader.readString(offsets[5]);
  return object;
}

P _healthSyncModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _healthSyncModelGetId(HealthSyncModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _healthSyncModelGetLinks(HealthSyncModel object) {
  return [];
}

void _healthSyncModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  HealthSyncModel object,
) {
  object.id = id;
}

extension HealthSyncModelQueryWhereSort
    on QueryBuilder<HealthSyncModel, HealthSyncModel, QWhere> {
  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension HealthSyncModelQueryWhere
    on QueryBuilder<HealthSyncModel, HealthSyncModel, QWhereClause> {
  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterWhereClause>
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

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterWhereClause> idBetween(
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

extension HealthSyncModelQueryFilter
    on QueryBuilder<HealthSyncModel, HealthSyncModel, QFilterCondition> {
  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  errorMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'errorMessage'),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  errorMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'errorMessage'),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  errorMessageEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'errorMessage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  errorMessageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'errorMessage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  errorMessageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'errorMessage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  errorMessageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'errorMessage',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  errorMessageStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'errorMessage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  errorMessageEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'errorMessage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  errorMessageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'errorMessage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  errorMessageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'errorMessage',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  errorMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'errorMessage', value: ''),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  errorMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'errorMessage', value: ''),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
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

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
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

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
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

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  lastIncrementalSyncIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastIncrementalSync'),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  lastIncrementalSyncIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastIncrementalSync'),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  lastIncrementalSyncEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastIncrementalSync', value: value),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  lastIncrementalSyncGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastIncrementalSync',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  lastIncrementalSyncLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastIncrementalSync',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  lastIncrementalSyncBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastIncrementalSync',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  lastSyncIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastSync'),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  lastSyncIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastSync'),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  lastSyncEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastSync', value: value),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  lastSyncGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastSync',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  lastSyncLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastSync',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  lastSyncBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastSync',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  recordsSyncedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'recordsSynced', value: value),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  recordsSyncedGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'recordsSynced',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  recordsSyncedLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'recordsSynced',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  recordsSyncedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'recordsSynced',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  sourceEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'source',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  sourceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'source',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  sourceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'source',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  sourceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'source',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  sourceStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'source',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  sourceEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'source',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  sourceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'source',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  sourceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'source',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  sourceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'source', value: ''),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  sourceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'source', value: ''),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
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

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
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

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
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

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
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

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
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

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
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

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
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

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
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

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterFilterCondition>
  statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'status', value: ''),
      );
    });
  }
}

extension HealthSyncModelQueryObject
    on QueryBuilder<HealthSyncModel, HealthSyncModel, QFilterCondition> {}

extension HealthSyncModelQueryLinks
    on QueryBuilder<HealthSyncModel, HealthSyncModel, QFilterCondition> {}

extension HealthSyncModelQuerySortBy
    on QueryBuilder<HealthSyncModel, HealthSyncModel, QSortBy> {
  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy>
  sortByErrorMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorMessage', Sort.asc);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy>
  sortByErrorMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorMessage', Sort.desc);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy>
  sortByLastIncrementalSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastIncrementalSync', Sort.asc);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy>
  sortByLastIncrementalSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastIncrementalSync', Sort.desc);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy>
  sortByLastSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSync', Sort.asc);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy>
  sortByLastSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSync', Sort.desc);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy>
  sortByRecordsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordsSynced', Sort.asc);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy>
  sortByRecordsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordsSynced', Sort.desc);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy> sortBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy>
  sortBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy>
  sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension HealthSyncModelQuerySortThenBy
    on QueryBuilder<HealthSyncModel, HealthSyncModel, QSortThenBy> {
  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy>
  thenByErrorMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorMessage', Sort.asc);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy>
  thenByErrorMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorMessage', Sort.desc);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy>
  thenByLastIncrementalSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastIncrementalSync', Sort.asc);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy>
  thenByLastIncrementalSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastIncrementalSync', Sort.desc);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy>
  thenByLastSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSync', Sort.asc);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy>
  thenByLastSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSync', Sort.desc);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy>
  thenByRecordsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordsSynced', Sort.asc);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy>
  thenByRecordsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordsSynced', Sort.desc);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy> thenBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy>
  thenBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QAfterSortBy>
  thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension HealthSyncModelQueryWhereDistinct
    on QueryBuilder<HealthSyncModel, HealthSyncModel, QDistinct> {
  QueryBuilder<HealthSyncModel, HealthSyncModel, QDistinct>
  distinctByErrorMessage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'errorMessage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QDistinct>
  distinctByLastIncrementalSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastIncrementalSync');
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QDistinct>
  distinctByLastSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastSync');
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QDistinct>
  distinctByRecordsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recordsSynced');
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QDistinct> distinctBySource({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'source', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HealthSyncModel, HealthSyncModel, QDistinct> distinctByStatus({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }
}

extension HealthSyncModelQueryProperty
    on QueryBuilder<HealthSyncModel, HealthSyncModel, QQueryProperty> {
  QueryBuilder<HealthSyncModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<HealthSyncModel, String?, QQueryOperations>
  errorMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'errorMessage');
    });
  }

  QueryBuilder<HealthSyncModel, DateTime?, QQueryOperations>
  lastIncrementalSyncProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastIncrementalSync');
    });
  }

  QueryBuilder<HealthSyncModel, DateTime?, QQueryOperations>
  lastSyncProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSync');
    });
  }

  QueryBuilder<HealthSyncModel, int, QQueryOperations> recordsSyncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recordsSynced');
    });
  }

  QueryBuilder<HealthSyncModel, String, QQueryOperations> sourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'source');
    });
  }

  QueryBuilder<HealthSyncModel, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }
}

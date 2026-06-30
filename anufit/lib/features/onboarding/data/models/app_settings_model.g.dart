// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAppSettingsModelCollection on Isar {
  IsarCollection<AppSettingsModel> get appSettingsModels => this.collection();
}

const AppSettingsModelSchema = CollectionSchema(
  name: r'AppSettingsModel',
  id: -638838212012723081,
  properties: {
    r'appVersion': PropertySchema(
      id: 0,
      name: r'appVersion',
      type: IsarType.string,
    ),
    r'currentOnboardingStep': PropertySchema(
      id: 1,
      name: r'currentOnboardingStep',
      type: IsarType.string,
      enumMap: _AppSettingsModelcurrentOnboardingStepEnumValueMap,
    ),
    r'healthConnected': PropertySchema(
      id: 2,
      name: r'healthConnected',
      type: IsarType.bool,
    ),
    r'language': PropertySchema(
      id: 3,
      name: r'language',
      type: IsarType.string,
    ),
    r'notificationsEnabled': PropertySchema(
      id: 4,
      name: r'notificationsEnabled',
      type: IsarType.bool,
    ),
    r'onboardingComplete': PropertySchema(
      id: 5,
      name: r'onboardingComplete',
      type: IsarType.bool,
    ),
    r'theme': PropertySchema(id: 6, name: r'theme', type: IsarType.string),
  },

  estimateSize: _appSettingsModelEstimateSize,
  serialize: _appSettingsModelSerialize,
  deserialize: _appSettingsModelDeserialize,
  deserializeProp: _appSettingsModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _appSettingsModelGetId,
  getLinks: _appSettingsModelGetLinks,
  attach: _appSettingsModelAttach,
  version: '3.3.2',
);

int _appSettingsModelEstimateSize(
  AppSettingsModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.appVersion.length * 3;
  bytesCount += 3 + object.currentOnboardingStep.name.length * 3;
  bytesCount += 3 + object.language.length * 3;
  bytesCount += 3 + object.theme.length * 3;
  return bytesCount;
}

void _appSettingsModelSerialize(
  AppSettingsModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.appVersion);
  writer.writeString(offsets[1], object.currentOnboardingStep.name);
  writer.writeBool(offsets[2], object.healthConnected);
  writer.writeString(offsets[3], object.language);
  writer.writeBool(offsets[4], object.notificationsEnabled);
  writer.writeBool(offsets[5], object.onboardingComplete);
  writer.writeString(offsets[6], object.theme);
}

AppSettingsModel _appSettingsModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AppSettingsModel();
  object.appVersion = reader.readString(offsets[0]);
  object.currentOnboardingStep =
      _AppSettingsModelcurrentOnboardingStepValueEnumMap[reader
          .readStringOrNull(offsets[1])] ??
      OnboardingStep.welcome;
  object.healthConnected = reader.readBool(offsets[2]);
  object.id = id;
  object.language = reader.readString(offsets[3]);
  object.notificationsEnabled = reader.readBool(offsets[4]);
  object.onboardingComplete = reader.readBool(offsets[5]);
  object.theme = reader.readString(offsets[6]);
  return object;
}

P _appSettingsModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (_AppSettingsModelcurrentOnboardingStepValueEnumMap[reader
                  .readStringOrNull(offset)] ??
              OnboardingStep.welcome)
          as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _AppSettingsModelcurrentOnboardingStepEnumValueMap = {
  r'welcome': r'welcome',
  r'features': r'features',
  r'permissions': r'permissions',
  r'profile': r'profile',
  r'goal': r'goal',
  r'walkingPreferences': r'walkingPreferences',
  r'healthIntegration': r'healthIntegration',
  r'finish': r'finish',
};
const _AppSettingsModelcurrentOnboardingStepValueEnumMap = {
  r'welcome': OnboardingStep.welcome,
  r'features': OnboardingStep.features,
  r'permissions': OnboardingStep.permissions,
  r'profile': OnboardingStep.profile,
  r'goal': OnboardingStep.goal,
  r'walkingPreferences': OnboardingStep.walkingPreferences,
  r'healthIntegration': OnboardingStep.healthIntegration,
  r'finish': OnboardingStep.finish,
};

Id _appSettingsModelGetId(AppSettingsModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _appSettingsModelGetLinks(AppSettingsModel object) {
  return [];
}

void _appSettingsModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  AppSettingsModel object,
) {
  object.id = id;
}

extension AppSettingsModelQueryWhereSort
    on QueryBuilder<AppSettingsModel, AppSettingsModel, QWhere> {
  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AppSettingsModelQueryWhere
    on QueryBuilder<AppSettingsModel, AppSettingsModel, QWhereClause> {
  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterWhereClause>
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

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterWhereClause> idBetween(
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

extension AppSettingsModelQueryFilter
    on QueryBuilder<AppSettingsModel, AppSettingsModel, QFilterCondition> {
  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  appVersionEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'appVersion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  appVersionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'appVersion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  appVersionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'appVersion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  appVersionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'appVersion',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  appVersionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'appVersion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  appVersionEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'appVersion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  appVersionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'appVersion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  appVersionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'appVersion',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  appVersionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'appVersion', value: ''),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  appVersionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'appVersion', value: ''),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  currentOnboardingStepEqualTo(
    OnboardingStep value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'currentOnboardingStep',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  currentOnboardingStepGreaterThan(
    OnboardingStep value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'currentOnboardingStep',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  currentOnboardingStepLessThan(
    OnboardingStep value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'currentOnboardingStep',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  currentOnboardingStepBetween(
    OnboardingStep lower,
    OnboardingStep upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'currentOnboardingStep',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  currentOnboardingStepStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'currentOnboardingStep',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  currentOnboardingStepEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'currentOnboardingStep',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  currentOnboardingStepContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'currentOnboardingStep',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  currentOnboardingStepMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'currentOnboardingStep',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  currentOnboardingStepIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'currentOnboardingStep', value: ''),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  currentOnboardingStepIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'currentOnboardingStep',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  healthConnectedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'healthConnected', value: value),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
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

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
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

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
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

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  languageEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'language',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  languageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'language',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  languageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'language',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  languageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'language',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  languageStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'language',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  languageEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'language',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  languageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'language',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  languageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'language',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  languageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'language', value: ''),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  languageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'language', value: ''),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  notificationsEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'notificationsEnabled',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  onboardingCompleteEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'onboardingComplete', value: value),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  themeEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'theme',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  themeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'theme',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  themeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'theme',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  themeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'theme',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  themeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'theme',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  themeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'theme',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  themeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'theme',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  themeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'theme',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  themeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'theme', value: ''),
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterFilterCondition>
  themeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'theme', value: ''),
      );
    });
  }
}

extension AppSettingsModelQueryObject
    on QueryBuilder<AppSettingsModel, AppSettingsModel, QFilterCondition> {}

extension AppSettingsModelQueryLinks
    on QueryBuilder<AppSettingsModel, AppSettingsModel, QFilterCondition> {}

extension AppSettingsModelQuerySortBy
    on QueryBuilder<AppSettingsModel, AppSettingsModel, QSortBy> {
  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  sortByAppVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appVersion', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  sortByAppVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appVersion', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  sortByCurrentOnboardingStep() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentOnboardingStep', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  sortByCurrentOnboardingStepDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentOnboardingStep', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  sortByHealthConnected() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthConnected', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  sortByHealthConnectedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthConnected', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  sortByLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  sortByLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  sortByNotificationsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  sortByNotificationsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  sortByOnboardingComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingComplete', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  sortByOnboardingCompleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingComplete', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy> sortByTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  sortByThemeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme', Sort.desc);
    });
  }
}

extension AppSettingsModelQuerySortThenBy
    on QueryBuilder<AppSettingsModel, AppSettingsModel, QSortThenBy> {
  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  thenByAppVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appVersion', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  thenByAppVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appVersion', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  thenByCurrentOnboardingStep() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentOnboardingStep', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  thenByCurrentOnboardingStepDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentOnboardingStep', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  thenByHealthConnected() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthConnected', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  thenByHealthConnectedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthConnected', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  thenByLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  thenByLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  thenByNotificationsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  thenByNotificationsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  thenByOnboardingComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingComplete', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  thenByOnboardingCompleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingComplete', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy> thenByTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QAfterSortBy>
  thenByThemeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme', Sort.desc);
    });
  }
}

extension AppSettingsModelQueryWhereDistinct
    on QueryBuilder<AppSettingsModel, AppSettingsModel, QDistinct> {
  QueryBuilder<AppSettingsModel, AppSettingsModel, QDistinct>
  distinctByAppVersion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'appVersion', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QDistinct>
  distinctByCurrentOnboardingStep({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'currentOnboardingStep',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QDistinct>
  distinctByHealthConnected() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'healthConnected');
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QDistinct>
  distinctByLanguage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'language', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QDistinct>
  distinctByNotificationsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationsEnabled');
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QDistinct>
  distinctByOnboardingComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'onboardingComplete');
    });
  }

  QueryBuilder<AppSettingsModel, AppSettingsModel, QDistinct> distinctByTheme({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'theme', caseSensitive: caseSensitive);
    });
  }
}

extension AppSettingsModelQueryProperty
    on QueryBuilder<AppSettingsModel, AppSettingsModel, QQueryProperty> {
  QueryBuilder<AppSettingsModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AppSettingsModel, String, QQueryOperations>
  appVersionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'appVersion');
    });
  }

  QueryBuilder<AppSettingsModel, OnboardingStep, QQueryOperations>
  currentOnboardingStepProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentOnboardingStep');
    });
  }

  QueryBuilder<AppSettingsModel, bool, QQueryOperations>
  healthConnectedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'healthConnected');
    });
  }

  QueryBuilder<AppSettingsModel, String, QQueryOperations> languageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'language');
    });
  }

  QueryBuilder<AppSettingsModel, bool, QQueryOperations>
  notificationsEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationsEnabled');
    });
  }

  QueryBuilder<AppSettingsModel, bool, QQueryOperations>
  onboardingCompleteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'onboardingComplete');
    });
  }

  QueryBuilder<AppSettingsModel, String, QQueryOperations> themeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'theme');
    });
  }
}

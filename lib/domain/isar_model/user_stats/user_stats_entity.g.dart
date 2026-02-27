// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_stats_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserStatsEntityCollection on Isar {
  IsarCollection<UserStatsEntity> get userStatsEntitys => this.collection();
}

const UserStatsEntitySchema = CollectionSchema(
  name: r'UserStatsEntity',
  id: 8744513959743373420,
  properties: {
    r'accuracyRate': PropertySchema(
      id: 0,
      name: r'accuracyRate',
      type: IsarType.double,
    ),
    r'correctAnswers': PropertySchema(
      id: 1,
      name: r'correctAnswers',
      type: IsarType.long,
    ),
    r'lastSessionDate': PropertySchema(
      id: 2,
      name: r'lastSessionDate',
      type: IsarType.dateTime,
    ),
    r'totalCards': PropertySchema(
      id: 3,
      name: r'totalCards',
      type: IsarType.long,
    ),
  },

  estimateSize: _userStatsEntityEstimateSize,
  serialize: _userStatsEntitySerialize,
  deserialize: _userStatsEntityDeserialize,
  deserializeProp: _userStatsEntityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _userStatsEntityGetId,
  getLinks: _userStatsEntityGetLinks,
  attach: _userStatsEntityAttach,
  version: '3.3.0',
);

int _userStatsEntityEstimateSize(
  UserStatsEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _userStatsEntitySerialize(
  UserStatsEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.accuracyRate);
  writer.writeLong(offsets[1], object.correctAnswers);
  writer.writeDateTime(offsets[2], object.lastSessionDate);
  writer.writeLong(offsets[3], object.totalCards);
}

UserStatsEntity _userStatsEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserStatsEntity();
  object.correctAnswers = reader.readLong(offsets[1]);
  object.id = id;
  object.lastSessionDate = reader.readDateTime(offsets[2]);
  object.totalCards = reader.readLong(offsets[3]);
  return object;
}

P _userStatsEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userStatsEntityGetId(UserStatsEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userStatsEntityGetLinks(UserStatsEntity object) {
  return [];
}

void _userStatsEntityAttach(
  IsarCollection<dynamic> col,
  Id id,
  UserStatsEntity object,
) {
  object.id = id;
}

extension UserStatsEntityQueryWhereSort
    on QueryBuilder<UserStatsEntity, UserStatsEntity, QWhere> {
  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserStatsEntityQueryWhere
    on QueryBuilder<UserStatsEntity, UserStatsEntity, QWhereClause> {
  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterWhereClause>
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

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterWhereClause> idBetween(
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

extension UserStatsEntityQueryFilter
    on QueryBuilder<UserStatsEntity, UserStatsEntity, QFilterCondition> {
  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterFilterCondition>
  accuracyRateEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'accuracyRate',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterFilterCondition>
  accuracyRateGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'accuracyRate',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterFilterCondition>
  accuracyRateLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'accuracyRate',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterFilterCondition>
  accuracyRateBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'accuracyRate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterFilterCondition>
  correctAnswersEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'correctAnswers', value: value),
      );
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterFilterCondition>
  correctAnswersGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'correctAnswers',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterFilterCondition>
  correctAnswersLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'correctAnswers',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterFilterCondition>
  correctAnswersBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'correctAnswers',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterFilterCondition>
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

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterFilterCondition>
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

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterFilterCondition>
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

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterFilterCondition>
  lastSessionDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastSessionDate', value: value),
      );
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterFilterCondition>
  lastSessionDateGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastSessionDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterFilterCondition>
  lastSessionDateLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastSessionDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterFilterCondition>
  lastSessionDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastSessionDate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterFilterCondition>
  totalCardsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'totalCards', value: value),
      );
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterFilterCondition>
  totalCardsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'totalCards',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterFilterCondition>
  totalCardsLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'totalCards',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterFilterCondition>
  totalCardsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'totalCards',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension UserStatsEntityQueryObject
    on QueryBuilder<UserStatsEntity, UserStatsEntity, QFilterCondition> {}

extension UserStatsEntityQueryLinks
    on QueryBuilder<UserStatsEntity, UserStatsEntity, QFilterCondition> {}

extension UserStatsEntityQuerySortBy
    on QueryBuilder<UserStatsEntity, UserStatsEntity, QSortBy> {
  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterSortBy>
  sortByAccuracyRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accuracyRate', Sort.asc);
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterSortBy>
  sortByAccuracyRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accuracyRate', Sort.desc);
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterSortBy>
  sortByCorrectAnswers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctAnswers', Sort.asc);
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterSortBy>
  sortByCorrectAnswersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctAnswers', Sort.desc);
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterSortBy>
  sortByLastSessionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSessionDate', Sort.asc);
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterSortBy>
  sortByLastSessionDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSessionDate', Sort.desc);
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterSortBy>
  sortByTotalCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCards', Sort.asc);
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterSortBy>
  sortByTotalCardsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCards', Sort.desc);
    });
  }
}

extension UserStatsEntityQuerySortThenBy
    on QueryBuilder<UserStatsEntity, UserStatsEntity, QSortThenBy> {
  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterSortBy>
  thenByAccuracyRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accuracyRate', Sort.asc);
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterSortBy>
  thenByAccuracyRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accuracyRate', Sort.desc);
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterSortBy>
  thenByCorrectAnswers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctAnswers', Sort.asc);
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterSortBy>
  thenByCorrectAnswersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctAnswers', Sort.desc);
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterSortBy>
  thenByLastSessionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSessionDate', Sort.asc);
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterSortBy>
  thenByLastSessionDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSessionDate', Sort.desc);
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterSortBy>
  thenByTotalCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCards', Sort.asc);
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QAfterSortBy>
  thenByTotalCardsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCards', Sort.desc);
    });
  }
}

extension UserStatsEntityQueryWhereDistinct
    on QueryBuilder<UserStatsEntity, UserStatsEntity, QDistinct> {
  QueryBuilder<UserStatsEntity, UserStatsEntity, QDistinct>
  distinctByAccuracyRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accuracyRate');
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QDistinct>
  distinctByCorrectAnswers() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'correctAnswers');
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QDistinct>
  distinctByLastSessionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastSessionDate');
    });
  }

  QueryBuilder<UserStatsEntity, UserStatsEntity, QDistinct>
  distinctByTotalCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalCards');
    });
  }
}

extension UserStatsEntityQueryProperty
    on QueryBuilder<UserStatsEntity, UserStatsEntity, QQueryProperty> {
  QueryBuilder<UserStatsEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserStatsEntity, double, QQueryOperations>
  accuracyRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accuracyRate');
    });
  }

  QueryBuilder<UserStatsEntity, int, QQueryOperations>
  correctAnswersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'correctAnswers');
    });
  }

  QueryBuilder<UserStatsEntity, DateTime, QQueryOperations>
  lastSessionDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSessionDate');
    });
  }

  QueryBuilder<UserStatsEntity, int, QQueryOperations> totalCardsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalCards');
    });
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_session_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStudySessionEntityCollection on Isar {
  IsarCollection<StudySessionEntity> get studySessionEntitys =>
      this.collection();
}

const StudySessionEntitySchema = CollectionSchema(
  name: r'StudySessionEntity',
  id: 8988397787196711269,
  properties: {
    r'correctAnswers': PropertySchema(
      id: 0,
      name: r'correctAnswers',
      type: IsarType.long,
    ),
    r'endedAt': PropertySchema(
      id: 1,
      name: r'endedAt',
      type: IsarType.dateTime,
    ),
    r'isCompleted': PropertySchema(
      id: 2,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'totalCards': PropertySchema(
      id: 3,
      name: r'totalCards',
      type: IsarType.long,
    ),
  },

  estimateSize: _studySessionEntityEstimateSize,
  serialize: _studySessionEntitySerialize,
  deserialize: _studySessionEntityDeserialize,
  deserializeProp: _studySessionEntityDeserializeProp,
  idName: r'id',
  indexes: {
    r'isCompleted': IndexSchema(
      id: -7936144632215868537,
      name: r'isCompleted',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isCompleted',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {
    r'answers': LinkSchema(
      id: 4288901877889258824,
      name: r'answers',
      target: r'StudyAnswerEntity',
      single: false,
      linkName: r'session',
    ),
  },
  embeddedSchemas: {},

  getId: _studySessionEntityGetId,
  getLinks: _studySessionEntityGetLinks,
  attach: _studySessionEntityAttach,
  version: '3.3.0',
);

int _studySessionEntityEstimateSize(
  StudySessionEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _studySessionEntitySerialize(
  StudySessionEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.correctAnswers);
  writer.writeDateTime(offsets[1], object.endedAt);
  writer.writeBool(offsets[2], object.isCompleted);
  writer.writeLong(offsets[3], object.totalCards);
}

StudySessionEntity _studySessionEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StudySessionEntity();
  object.correctAnswers = reader.readLong(offsets[0]);
  object.endedAt = reader.readDateTime(offsets[1]);
  object.id = id;
  object.isCompleted = reader.readBool(offsets[2]);
  object.totalCards = reader.readLong(offsets[3]);
  return object;
}

P _studySessionEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _studySessionEntityGetId(StudySessionEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _studySessionEntityGetLinks(
  StudySessionEntity object,
) {
  return [object.answers];
}

void _studySessionEntityAttach(
  IsarCollection<dynamic> col,
  Id id,
  StudySessionEntity object,
) {
  object.id = id;
  object.answers.attach(
    col,
    col.isar.collection<StudyAnswerEntity>(),
    r'answers',
    id,
  );
}

extension StudySessionEntityQueryWhereSort
    on QueryBuilder<StudySessionEntity, StudySessionEntity, QWhere> {
  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterWhere>
  anyIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isCompleted'),
      );
    });
  }
}

extension StudySessionEntityQueryWhere
    on QueryBuilder<StudySessionEntity, StudySessionEntity, QWhereClause> {
  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterWhereClause>
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

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterWhereClause>
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

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterWhereClause>
  isCompletedEqualTo(bool isCompleted) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'isCompleted',
          value: [isCompleted],
        ),
      );
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterWhereClause>
  isCompletedNotEqualTo(bool isCompleted) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'isCompleted',
                lower: [],
                upper: [isCompleted],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'isCompleted',
                lower: [isCompleted],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'isCompleted',
                lower: [isCompleted],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'isCompleted',
                lower: [],
                upper: [isCompleted],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension StudySessionEntityQueryFilter
    on QueryBuilder<StudySessionEntity, StudySessionEntity, QFilterCondition> {
  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterFilterCondition>
  correctAnswersEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'correctAnswers', value: value),
      );
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterFilterCondition>
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

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterFilterCondition>
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

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterFilterCondition>
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

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterFilterCondition>
  endedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'endedAt', value: value),
      );
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterFilterCondition>
  endedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'endedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterFilterCondition>
  endedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'endedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterFilterCondition>
  endedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'endedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterFilterCondition>
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

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterFilterCondition>
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

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterFilterCondition>
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

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterFilterCondition>
  isCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isCompleted', value: value),
      );
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterFilterCondition>
  totalCardsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'totalCards', value: value),
      );
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterFilterCondition>
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

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterFilterCondition>
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

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterFilterCondition>
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

extension StudySessionEntityQueryObject
    on QueryBuilder<StudySessionEntity, StudySessionEntity, QFilterCondition> {}

extension StudySessionEntityQueryLinks
    on QueryBuilder<StudySessionEntity, StudySessionEntity, QFilterCondition> {
  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterFilterCondition>
  answers(FilterQuery<StudyAnswerEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'answers');
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterFilterCondition>
  answersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'answers', length, true, length, true);
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterFilterCondition>
  answersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'answers', 0, true, 0, true);
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterFilterCondition>
  answersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'answers', 0, false, 999999, true);
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterFilterCondition>
  answersLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'answers', 0, true, length, include);
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterFilterCondition>
  answersLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'answers', length, include, 999999, true);
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterFilterCondition>
  answersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
        r'answers',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension StudySessionEntityQuerySortBy
    on QueryBuilder<StudySessionEntity, StudySessionEntity, QSortBy> {
  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterSortBy>
  sortByCorrectAnswers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctAnswers', Sort.asc);
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterSortBy>
  sortByCorrectAnswersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctAnswers', Sort.desc);
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterSortBy>
  sortByEndedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endedAt', Sort.asc);
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterSortBy>
  sortByEndedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endedAt', Sort.desc);
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterSortBy>
  sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterSortBy>
  sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterSortBy>
  sortByTotalCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCards', Sort.asc);
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterSortBy>
  sortByTotalCardsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCards', Sort.desc);
    });
  }
}

extension StudySessionEntityQuerySortThenBy
    on QueryBuilder<StudySessionEntity, StudySessionEntity, QSortThenBy> {
  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterSortBy>
  thenByCorrectAnswers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctAnswers', Sort.asc);
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterSortBy>
  thenByCorrectAnswersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctAnswers', Sort.desc);
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterSortBy>
  thenByEndedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endedAt', Sort.asc);
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterSortBy>
  thenByEndedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endedAt', Sort.desc);
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterSortBy>
  thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterSortBy>
  thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterSortBy>
  thenByTotalCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCards', Sort.asc);
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QAfterSortBy>
  thenByTotalCardsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCards', Sort.desc);
    });
  }
}

extension StudySessionEntityQueryWhereDistinct
    on QueryBuilder<StudySessionEntity, StudySessionEntity, QDistinct> {
  QueryBuilder<StudySessionEntity, StudySessionEntity, QDistinct>
  distinctByCorrectAnswers() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'correctAnswers');
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QDistinct>
  distinctByEndedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endedAt');
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QDistinct>
  distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<StudySessionEntity, StudySessionEntity, QDistinct>
  distinctByTotalCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalCards');
    });
  }
}

extension StudySessionEntityQueryProperty
    on QueryBuilder<StudySessionEntity, StudySessionEntity, QQueryProperty> {
  QueryBuilder<StudySessionEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<StudySessionEntity, int, QQueryOperations>
  correctAnswersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'correctAnswers');
    });
  }

  QueryBuilder<StudySessionEntity, DateTime, QQueryOperations>
  endedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endedAt');
    });
  }

  QueryBuilder<StudySessionEntity, bool, QQueryOperations>
  isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<StudySessionEntity, int, QQueryOperations> totalCardsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalCards');
    });
  }
}

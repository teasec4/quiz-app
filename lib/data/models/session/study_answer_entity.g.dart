// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_answer_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStudyAnswerEntityCollection on Isar {
  IsarCollection<StudyAnswerEntity> get studyAnswerEntitys => this.collection();
}

const StudyAnswerEntitySchema = CollectionSchema(
  name: r'StudyAnswerEntity',
  id: 9071185127143497342,
  properties: {
    r'cardId': PropertySchema(id: 0, name: r'cardId', type: IsarType.long),
    r'isCorrect': PropertySchema(
      id: 1,
      name: r'isCorrect',
      type: IsarType.bool,
    ),
  },

  estimateSize: _studyAnswerEntityEstimateSize,
  serialize: _studyAnswerEntitySerialize,
  deserialize: _studyAnswerEntityDeserialize,
  deserializeProp: _studyAnswerEntityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'session': LinkSchema(
      id: -7443352969467983376,
      name: r'session',
      target: r'StudySessionEntity',
      single: true,
    ),
  },
  embeddedSchemas: {},

  getId: _studyAnswerEntityGetId,
  getLinks: _studyAnswerEntityGetLinks,
  attach: _studyAnswerEntityAttach,
  version: '3.3.0',
);

int _studyAnswerEntityEstimateSize(
  StudyAnswerEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _studyAnswerEntitySerialize(
  StudyAnswerEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.cardId);
  writer.writeBool(offsets[1], object.isCorrect);
}

StudyAnswerEntity _studyAnswerEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StudyAnswerEntity();
  object.cardId = reader.readLong(offsets[0]);
  object.id = id;
  object.isCorrect = reader.readBool(offsets[1]);
  return object;
}

P _studyAnswerEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _studyAnswerEntityGetId(StudyAnswerEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _studyAnswerEntityGetLinks(
  StudyAnswerEntity object,
) {
  return [object.session];
}

void _studyAnswerEntityAttach(
  IsarCollection<dynamic> col,
  Id id,
  StudyAnswerEntity object,
) {
  object.id = id;
  object.session.attach(
    col,
    col.isar.collection<StudySessionEntity>(),
    r'session',
    id,
  );
}

extension StudyAnswerEntityQueryWhereSort
    on QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QWhere> {
  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension StudyAnswerEntityQueryWhere
    on QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QWhereClause> {
  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterWhereClause>
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

  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterWhereClause>
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

extension StudyAnswerEntityQueryFilter
    on QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QFilterCondition> {
  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterFilterCondition>
  cardIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cardId', value: value),
      );
    });
  }

  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterFilterCondition>
  cardIdGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cardId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterFilterCondition>
  cardIdLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cardId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterFilterCondition>
  cardIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cardId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterFilterCondition>
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

  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterFilterCondition>
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

  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterFilterCondition>
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

  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterFilterCondition>
  isCorrectEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isCorrect', value: value),
      );
    });
  }
}

extension StudyAnswerEntityQueryObject
    on QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QFilterCondition> {}

extension StudyAnswerEntityQueryLinks
    on QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QFilterCondition> {
  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterFilterCondition>
  session(FilterQuery<StudySessionEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'session');
    });
  }

  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterFilterCondition>
  sessionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'session', 0, true, 0, true);
    });
  }
}

extension StudyAnswerEntityQuerySortBy
    on QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QSortBy> {
  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterSortBy>
  sortByCardId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardId', Sort.asc);
    });
  }

  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterSortBy>
  sortByCardIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardId', Sort.desc);
    });
  }

  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterSortBy>
  sortByIsCorrect() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCorrect', Sort.asc);
    });
  }

  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterSortBy>
  sortByIsCorrectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCorrect', Sort.desc);
    });
  }
}

extension StudyAnswerEntityQuerySortThenBy
    on QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QSortThenBy> {
  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterSortBy>
  thenByCardId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardId', Sort.asc);
    });
  }

  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterSortBy>
  thenByCardIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardId', Sort.desc);
    });
  }

  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterSortBy>
  thenByIsCorrect() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCorrect', Sort.asc);
    });
  }

  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QAfterSortBy>
  thenByIsCorrectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCorrect', Sort.desc);
    });
  }
}

extension StudyAnswerEntityQueryWhereDistinct
    on QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QDistinct> {
  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QDistinct>
  distinctByCardId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cardId');
    });
  }

  QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QDistinct>
  distinctByIsCorrect() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCorrect');
    });
  }
}

extension StudyAnswerEntityQueryProperty
    on QueryBuilder<StudyAnswerEntity, StudyAnswerEntity, QQueryProperty> {
  QueryBuilder<StudyAnswerEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<StudyAnswerEntity, int, QQueryOperations> cardIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cardId');
    });
  }

  QueryBuilder<StudyAnswerEntity, bool, QQueryOperations> isCorrectProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCorrect');
    });
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcard_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFlashCardEntityCollection on Isar {
  IsarCollection<FlashCardEntity> get flashCardEntitys => this.collection();
}

const FlashCardEntitySchema = CollectionSchema(
  name: r'FlashCardEntity',
  id: -8683071797499406053,
  properties: {
    r'back': PropertySchema(id: 0, name: r'back', type: IsarType.string),
    r'front': PropertySchema(id: 1, name: r'front', type: IsarType.string),
  },

  estimateSize: _flashCardEntityEstimateSize,
  serialize: _flashCardEntitySerialize,
  deserialize: _flashCardEntityDeserialize,
  deserializeProp: _flashCardEntityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'deck': LinkSchema(
      id: -3063862919761449329,
      name: r'deck',
      target: r'DeckEntity',
      single: true,
    ),
  },
  embeddedSchemas: {},

  getId: _flashCardEntityGetId,
  getLinks: _flashCardEntityGetLinks,
  attach: _flashCardEntityAttach,
  version: '3.3.0',
);

int _flashCardEntityEstimateSize(
  FlashCardEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.back.length * 3;
  bytesCount += 3 + object.front.length * 3;
  return bytesCount;
}

void _flashCardEntitySerialize(
  FlashCardEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.back);
  writer.writeString(offsets[1], object.front);
}

FlashCardEntity _flashCardEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FlashCardEntity();
  object.back = reader.readString(offsets[0]);
  object.front = reader.readString(offsets[1]);
  object.id = id;
  return object;
}

P _flashCardEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _flashCardEntityGetId(FlashCardEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _flashCardEntityGetLinks(FlashCardEntity object) {
  return [object.deck];
}

void _flashCardEntityAttach(
  IsarCollection<dynamic> col,
  Id id,
  FlashCardEntity object,
) {
  object.id = id;
  object.deck.attach(col, col.isar.collection<DeckEntity>(), r'deck', id);
}

extension FlashCardEntityQueryWhereSort
    on QueryBuilder<FlashCardEntity, FlashCardEntity, QWhere> {
  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FlashCardEntityQueryWhere
    on QueryBuilder<FlashCardEntity, FlashCardEntity, QWhereClause> {
  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterWhereClause>
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

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterWhereClause> idBetween(
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

extension FlashCardEntityQueryFilter
    on QueryBuilder<FlashCardEntity, FlashCardEntity, QFilterCondition> {
  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition>
  backEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'back',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition>
  backGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'back',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition>
  backLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'back',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition>
  backBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'back',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition>
  backStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'back',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition>
  backEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'back',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition>
  backContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'back',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition>
  backMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'back',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition>
  backIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'back', value: ''),
      );
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition>
  backIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'back', value: ''),
      );
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition>
  frontEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'front',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition>
  frontGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'front',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition>
  frontLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'front',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition>
  frontBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'front',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition>
  frontStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'front',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition>
  frontEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'front',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition>
  frontContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'front',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition>
  frontMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'front',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition>
  frontIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'front', value: ''),
      );
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition>
  frontIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'front', value: ''),
      );
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition>
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

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition>
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

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition>
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
}

extension FlashCardEntityQueryObject
    on QueryBuilder<FlashCardEntity, FlashCardEntity, QFilterCondition> {}

extension FlashCardEntityQueryLinks
    on QueryBuilder<FlashCardEntity, FlashCardEntity, QFilterCondition> {
  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition> deck(
    FilterQuery<DeckEntity> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'deck');
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterFilterCondition>
  deckIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'deck', 0, true, 0, true);
    });
  }
}

extension FlashCardEntityQuerySortBy
    on QueryBuilder<FlashCardEntity, FlashCardEntity, QSortBy> {
  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterSortBy> sortByBack() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'back', Sort.asc);
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterSortBy>
  sortByBackDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'back', Sort.desc);
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterSortBy> sortByFront() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'front', Sort.asc);
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterSortBy>
  sortByFrontDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'front', Sort.desc);
    });
  }
}

extension FlashCardEntityQuerySortThenBy
    on QueryBuilder<FlashCardEntity, FlashCardEntity, QSortThenBy> {
  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterSortBy> thenByBack() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'back', Sort.asc);
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterSortBy>
  thenByBackDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'back', Sort.desc);
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterSortBy> thenByFront() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'front', Sort.asc);
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterSortBy>
  thenByFrontDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'front', Sort.desc);
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension FlashCardEntityQueryWhereDistinct
    on QueryBuilder<FlashCardEntity, FlashCardEntity, QDistinct> {
  QueryBuilder<FlashCardEntity, FlashCardEntity, QDistinct> distinctByBack({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'back', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashCardEntity, FlashCardEntity, QDistinct> distinctByFront({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'front', caseSensitive: caseSensitive);
    });
  }
}

extension FlashCardEntityQueryProperty
    on QueryBuilder<FlashCardEntity, FlashCardEntity, QQueryProperty> {
  QueryBuilder<FlashCardEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FlashCardEntity, String, QQueryOperations> backProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'back');
    });
  }

  QueryBuilder<FlashCardEntity, String, QQueryOperations> frontProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'front');
    });
  }
}

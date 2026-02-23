class Folder {
  final String id;
  final String name;

  Folder({
    required this.id,
    required this.name,
  });

  Folder copyWith({String? name}) {
    return Folder(
      id: id,
      name: name ?? this.name,
    );
  }
}

class Deck {
  final String id;
  final String folderId;
  final String title;
  final int cardCount;
  final int learnedCount;

  Deck({
    required this.id,
    required this.folderId,
    required this.title,
    this.cardCount = 0,
    this.learnedCount = 0,
  });

  Deck copyWith({
    String? title,
    int? cardCount,
    int? learnedCount,
  }) {
    return Deck(
      id: id,
      folderId: folderId,
      title: title ?? this.title,
      cardCount: cardCount ?? this.cardCount,
      learnedCount: learnedCount ?? this.learnedCount,
    );
  }
}

class FlashCard {
  final String id;
  final String deckId;
  final String front;
  final String back;

  FlashCard({
    required this.id,
    required this.deckId,
    required this.front,
    required this.back,
  });

  FlashCard copyWith({
    String? deckId,
    String? front,
    String? back,
  }) {
    return FlashCard(
      id: id,
      deckId: deckId ?? this.deckId,
      front: front ?? this.front,
      back: back ?? this.back,
    );
  }
}

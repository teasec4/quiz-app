class Folder {
  final String id;
  final String name;
  final List<String> deckIds;

  Folder({required this.id, required this.name, required this.deckIds});

  Folder copyWith({String? name}) {
    return Folder(id: id, name: name ?? this.name, deckIds: deckIds);
  }
  
}

class Deck {
  final String id;
  final String folderId;
  final String title;

  Deck({required this.id, required this.folderId, required this.title});

  Deck copyWith({String? title}) {
    return Deck(id: id, folderId: folderId, title: title ?? this.title);
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

  FlashCard copyWith({String? front, String? back}) {
    return FlashCard(
      id: id,
      deckId: deckId,
      front: front ?? this.front,
      back: back ?? this.back
    );
  }
}

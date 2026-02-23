class Folder {
  final String id;
  final String name;
  final List<String> deckIds;

  Folder({required this.id, required this.name, required this.deckIds});

  Folder copyWith({String? name, List<String>? deckIds}) {
    return Folder(
      id: id,
      name: name ?? this.name,
      deckIds: deckIds ?? List.from(this.deckIds),
    );
  }

  List<String> getDecks() {
    return deckIds;
  }

  // FOR FUTURE USING IN creating DECK
  // void addDeckToFolder(String folderId, String deckId) {
  //   final index = folders.indexWhere((f) => f.id == folderId);
  //   if (index == -1) return;

  //   final folder = folders[index];

  //   final updatedFolder = folder.copyWith(
  //     deckIds: [...folder.deckIds, deckId],
  //   );

  //   folders[index] = updatedFolder;

  //   notifyListeners();
  // }
}

class Deck {
  final String id;
  final String folderId;
  final String title;
  final List<String> cardsId;
  final int learnedCount;

  Deck({
    required this.id,
    required this.folderId,
    required this.title,
    required this.cardsId,
    this.learnedCount = 0
  });

  Deck copyWith({String? title, List<String>? cardsId}) {
    return Deck(
      id: id,
      folderId: folderId,
      title: title ?? this.title,
      cardsId: cardsId ?? List.from(this.cardsId),
      learnedCount: learnedCount
    );
  }

  int getCardsCount() {
    return cardsId.length;
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
      back: back ?? this.back,
    );
  }
}

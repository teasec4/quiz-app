class Folder {
  final String id;
  final String name;
  final List<String> deckIds;

  Folder({required this.id, required this.name, required this.deckIds});

  Folder copyWith({
    String? name,
    List<String>? deckIds
  }) {
    return Folder(
      id: id, 
      name: name ?? this.name, 
      deckIds: deckIds ?? List.from(this.deckIds));
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

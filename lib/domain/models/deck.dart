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
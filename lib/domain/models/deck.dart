class Deck {
  final String id;
  final String folderId;
  final String title;

  Deck({
    required this.id,
    required this.folderId,
    required this.title,
  });

  Deck copyWith({
    String? title,
  }) {
    return Deck(
      id: id,
      folderId: folderId,
      title: title ?? this.title,
    );
  }
}
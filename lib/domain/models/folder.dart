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

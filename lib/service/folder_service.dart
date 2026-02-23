import 'package:bookexample/provider/mock_data_models.dart';
import 'package:uuid/uuid.dart';

class FolderService {
  Folder createFolder(String name) {
    return Folder(
      id: const Uuid().v4(),
      name: name,
    );
  }
}

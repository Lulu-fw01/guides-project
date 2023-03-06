import 'package:flutter_quill/flutter_quill.dart';

/// Guide repository interface.
abstract class IGuideRepository {
  Future<void> addNewGuide(Document quillDocument);
}

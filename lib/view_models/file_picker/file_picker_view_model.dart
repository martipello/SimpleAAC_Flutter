import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';

class FilePickerViewModel {
  FilePickerViewModel(this.picker);

  final ImagePicker picker;

  final pickedFileList = BehaviorSubject<List<XFile>?>();
  final _retrieveDataError = BehaviorSubject<String?>();

  Future<void> openImagePicker() async {
    try {
      final _pickedFileList = await picker.pickMultiImage(
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 100,
      );
      if (_pickedFileList?.isNotEmpty == true) {
        pickedFileList.add(_pickedFileList);
      }
    } catch (e) {
      pickedFileList.addError(e);
    }
  }

  Future<void> retrieveLostData() async {
    final response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      final _pickedFileList = pickedFileList.value;
      _pickedFileList?.add(response.file!);
      pickedFileList.add(_pickedFileList);
    } else {
      _retrieveDataError.addError(response.exception!.code);
    }
  }

  void removeImage(XFile imageFile) {
    final _pickedFileList = pickedFileList.value;
    _pickedFileList?.remove(imageFile);
    pickedFileList.add(_pickedFileList);
  }

  void dispose() {
    pickedFileList.close();
  }
}

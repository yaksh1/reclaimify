import 'package:image_picker/image_picker.dart';
import 'package:reclaimify/components/my_snackbar.dart';

pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    }
    MySnackBar().mySnackBar(
        header: "Image Selection cancelled", content: "No image is selected");
  }
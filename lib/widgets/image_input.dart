import 'dart:io';
// for using XFile
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  final void Function(File image) onPickImage;
  // we take this function as input so as to pass the selected image to the add_place.dart. Because in that file we add the title to provider

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  // variale of data type File

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedImage == null) {
      return;
      // means if the user opened camera but didn't click a picture
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
    });
    // we wrote .path so as to store XFile type value in File (normal file basically) type variable
    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      icon: const Icon(Icons.camera),
      label: const Text('Take picture'),
      onPressed: _takePicture,
    );

    if (_selectedImage != null) {
      // It shows preview when we take image and if we tap it it reopens camera to retake
      content = GestureDetector(
        // GestureDetector detects gestures
        onTap: _takePicture,
        child: Image.file(
          // .file is a constructor to show an image on the screen based on some file of type File
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}

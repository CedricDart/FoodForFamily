import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(List<File>) onImagesSelected;

  const ImagePickerWidget({Key? key, required this.onImagesSelected}) : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  List<File> _imageFiles = [];  // List to hold selected images

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final List<XFile>? pickedFiles = await picker.pickMultiImage();  // Allow multiple image selection

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        _imageFiles = pickedFiles.map((file) => File(file.path)).toList();  // Convert XFile to File
      });
      widget.onImagesSelected(_imageFiles);  // Pass the list of selected images to the parent widget
    } else {
      // Handle case when no image is selected
      print('No images selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16), // Padding inside the container
      decoration: BoxDecoration(
        color: Colors.white, // Background color (optional)
        border: Border.all(
          color: Colors.blue, // Border color
          width: 1.2,        // Border width
        ),
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      child: Column(
        children: [
          _imageFiles.isEmpty
              ? Text('No images selected.')
              : GridView.builder(
            shrinkWrap: true, // To make the GridView scrollable within the Column
            itemCount: _imageFiles.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,  // Display images in a grid with 3 columns
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return Image.file(_imageFiles[index], fit: BoxFit.cover);
            },
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: _pickImages,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple], // Add gradient background
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.photo_library, color: Colors.white), // Icon
                  SizedBox(width: 8),
                  Text(
                    'Foto toevoegen',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

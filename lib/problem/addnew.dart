import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddNewCourse extends StatefulWidget {
  @override
  State<AddNewCourse> createState() => _AddNewCourseState();
}

class _AddNewCourseState extends State<AddNewCourse> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();

    XFile? _courseImage;

    chooseImageFromGallery() async {
      final ImagePicker _picker = ImagePicker();
      _courseImage = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {});
    }

    return Container( 
      height: 400,
      decoration: BoxDecoration(
          color: Colors.lime,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Enter Course Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(hintText: 'Enter Course Description'),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                child: Center(
                  child: Material(
                      child: _courseImage == null ? IconButton(
                              onPressed: () => chooseImageFromGallery(),
                              icon: Icon(Icons.photo),
                            )
                          : Image.file(
                              File(_courseImage!.path),
                              fit: BoxFit.cover,
                            )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

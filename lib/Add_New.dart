import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class New_Course extends StatefulWidget {
  const New_Course({super.key});
    
  @override
  State<New_Course> createState() => _New_CourseState();
}

class _New_CourseState extends State<New_Course> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _desCriptionController = TextEditingController();

  XFile? _courseImage;
  // String? imageUrl;

  chooseImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    _courseImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  // wrightData() async {
  //   File imgFile = File(_courseImage!.path);
  //   FirebaseStorage _storage = FirebaseStorage.instance;
  //   UploadTask _uploadTask =
  //       _storage.ref('Images').child(_courseImage!.path).putFile(imgFile);
  //   TaskSnapshot snapshot = await _uploadTask;
  //   imageUrl = await snapshot.ref.getDownloadURL();
  //   print(imageUrl);
   
  //   CollectionReference _course =
  //       FirebaseFirestore.instance.collection("courses");
  //   _course.add({ 
  //     "course_name": _titleController.text,
  //     "course_details": _desCriptionController.text,
  //     "img": imageUrl,
  //   });
  //   print('SuccessFully Added');
  //   Navigator.pop(context); 
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: Column(children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(hintText: 'Course Name'),
          ),
          TextField(
            controller: _desCriptionController,
            decoration: InputDecoration(hintText: 'Course Details'),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: Center(
              child: Material(
                child: _courseImage == null
                    ? IconButton(
                        onPressed: () => chooseImageFromGallery(),
                        icon: Icon(
                          Icons.photo_album,
                          size: 50,
                        ),
                      )
                    : Image.file(
                        File(_courseImage!.path),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          // ElevatedButton(
          //     onPressed: () => wrightData(), child: Text('Add new Course')),
          SizedBox(
            height: 10,
          )
        ]),
      ),
    );
  }
}
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Update_Course extends StatefulWidget {
  String documentId;
  String courseTitle;
  String courseDetails;
  String courseImg;
  Update_Course(
      this.documentId, this.courseTitle, this.courseDetails, this.courseImg);

  @override
  State<Update_Course> createState() => _Update_CourseState();
}

class _Update_CourseState extends State<Update_Course> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _desCriptionController = TextEditingController();

  XFile? _courseImage;
  String? imageUrl;

  chooseImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    _courseImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  updatetData(selectedDocument) async {
    if (_courseImage == null) {
      CollectionReference _course =
          FirebaseFirestore.instance.collection("courses");
      _course.doc(selectedDocument).update({
        "course_name": _titleController.text,
        "course_details": _desCriptionController.text,
        "img": widget.courseImg,
      });
      print('SuccessFully Added');
      Navigator.pop(context);
    } else {
      File imgFile = File(_courseImage!.path);
      FirebaseStorage _storage = FirebaseStorage.instance;
      UploadTask _uploadTask =
          _storage.ref('Images').child(_courseImage!.path).putFile(imgFile);
      TaskSnapshot snapshot = await _uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
      print(imageUrl);

      CollectionReference _course =
          FirebaseFirestore.instance.collection("courses");
      _course.doc(selectedDocument).update({
        "course_name": _titleController.text,
        "course_details": _desCriptionController.text,
        "img": imageUrl,
      });
      print('SuccessFully Added');
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController.text = widget.courseTitle;
    _desCriptionController.text = widget.courseDetails;
  }

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
                    ? Stack(
                        children: [
                          Image.network(
                            widget.courseImg,
                            fit: BoxFit.cover,
                          ),
                          CircleAvatar(
                              child: IconButton(
                            onPressed: () => chooseImageFromGallery(),
                            icon: Icon(
                              Icons.photo_album,
                              size: 50,
                              color: Colors.blueGrey,
                            ),
                          ))
                        ],
                      )
                    : Image.file(
                        File(_courseImage!.path),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () => updatetData(widget.documentId),
              child: Text('Add new Course')),
          SizedBox(
            height: 10,
          )
        ]),
      ),
    );
  }
}

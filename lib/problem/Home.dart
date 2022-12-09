import 'package:first_crud_operation/problem/addnew.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _addNewCourses() {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) => AddNewCourse(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(onPressed: () => _addNewCourses(), icon: Icon(Icons.add)),
        ],
      ),
    );
  }
}

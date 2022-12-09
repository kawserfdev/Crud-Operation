import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_crud_operation/Add_New.dart';
import 'package:first_crud_operation/Update.dart';
import 'package:flutter/material.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({super.key});

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  addNewCourse() {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => New_Course());
  }

  Future<void> updateCourse(selectedDocument, title, description, img) {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => Update_Course(selectedDocument, title, description, img));
  }

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('courses').snapshots();

  Future<void> deleteCoursee(selectedDocument) {
    return FirebaseFirestore.instance
        .collection('courses')
        .doc(selectedDocument)
        .delete()
        .then((value) => print('course has been deleted'))
        .catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cousres'),
        centerTitle: true,
        backgroundColor: Colors.amber[700],
        actions: [
          IconButton(onPressed: () => addNewCourse(), icon: Icon(Icons.add))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Stack(
                    children: [
                      Container(
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            Expanded(child: Image.network(data['img'])),
                            Text(data['course_name']),
                            Text(data['course_details']),
                          ]),
                        ),
                      ),
                      Positioned(
                          right: 0,
                          child: Card(
                            child: Container(
                              height: 50,
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () => updateCourse(
                                          document.id,
                                          data['course_name'],
                                          data['course_details'],
                                          data['img']),
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.cyan,
                                      )),
                                  IconButton(
                                      onPressed: () =>
                                          deleteCoursee(document.id),
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}

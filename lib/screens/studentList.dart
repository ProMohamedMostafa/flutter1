import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:student_list/screens/student_details.dart';

class StudentList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return studentsState();
  }
}

class studentsState extends State<StudentList> {
  int count = 10;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Studnets"),
      ),
      body: GetStudntsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateTOEditPage("Add New Student");
        },
        tooltip: "Add New Student",
        child: Icon(Icons.add),
      ),
    );
  }

  ListView GetStudntsList() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.green,
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.check),
              ),
              title: Text("First Student $position"),
              subtitle: Text("Data From Student List"),
              trailing: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onTap: () {
                navigateTOEditPage("Edit Student");
              },
            ),
          );
        });
  }

  void navigateTOEditPage(String screenTitle) {
    Navigator.push(context, MaterialPageRoute(builder: (Context) {
      return StudentDetails(screenTitle);
    }));
  }
}

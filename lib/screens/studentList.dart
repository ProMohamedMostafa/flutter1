import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:student_list/screens/student_details.dart';
import 'dart:async';
import 'package:student_list/models/student.dart';
import 'package:student_list/utilities/sql_helper.dart';
import 'package:sqflite/sqflite.dart';

class StudentList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return studentsState();
  }
}

class studentsState extends State<StudentList> {
  SQL_Helper helper = new SQL_Helper();
  List<student> studentList;

  int count = 0;
  @override
  Widget build(BuildContext context) {
    if (studentList == null) {
      studentList = new List<student>();
      updatelistview();
    }
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Studnets"),
      ),
      body: GetStudntsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          student s = new student("", "", 1, "");
          navigateTOEditPage(s, "Add New Student");

          updatelistview();
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
                backgroundColor: ispassed(studentList[position].pass),
                child: getIcon(studentList[position].pass),
              ),
              title: Text(studentList[position].name),
              subtitle: Text(studentList[position].description),
              trailing: GestureDetector(
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onTap: () {
                  _delete(context, studentList[position]);
                  updatelistview();
                },
              ),
              onTap: () {
                navigateTOEditPage(this.studentList[position], "Edit Student");
              },
            ),
          );
        });
  }

  Color ispassed(int value) {
    switch (value) {
      case 1:
        return Colors.amber;
        break;
      case 2:
        return Colors.red;
        break;
      default:
        return Colors.green;
    }
  }

  Icon getIcon(int value) {
    switch (value) {
      case 1:
        return Icon(Icons.check);
        break;
      case 2:
        return Icon(Icons.close);
      default:
        return Icon(Icons.access_alarm);
    }
  }

  void _delete(BuildContext context, student s) async {
    int result = await helper.deleteStudent(s.id);
    if (result != 0) {
      showsnakBar(context, "Student has been deleted");
      updatelistview();
      //make update listview and show snakbar
    }
  }

  void updatelistview() {
    final Future<Database> db = helper.initializedDatabase();
    db.then((database) {
      Future<List<student>> students = helper.getStudentsList();
      students.then((value) {
        setState(() {
          this.studentList = value;
          this.count = value.length;
        });
      });
    });
  }

  void showsnakBar(BuildContext context, String msg) {
    final snackBar = SnackBar(content: Text(msg));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateTOEditPage(student st, String screenTitle) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (Context) {
      return StudentDetails(st, screenTitle);
    }));
    updatelistview();
  }
}

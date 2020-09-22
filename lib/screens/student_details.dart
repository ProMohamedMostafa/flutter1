import 'package:flutter/material.dart';
import 'dart:async';
import 'package:student_list/models/student.dart';
import 'package:student_list/utilities/sql_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_list/screens/studentList.dart';

class StudentDetails extends StatefulWidget {
  String sceentitle;
  student st;
  StudentDetails(student st, String sceentitle) {
    this.sceentitle = sceentitle;
    this.st = st;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return students(this.st, this.sceentitle);
  }
}

class students extends State<StudentDetails> {
  String screenTitle;
  student st;
  SQL_Helper _sql_helper = new SQL_Helper();
  students(student st, String screenTitle) {
    this.st = st;
    this.screenTitle = screenTitle;
  }
  static var _status = {"Successed", "Failed"}.toList();
  TextEditingController stuentName = new TextEditingController();
  TextEditingController studentDetails = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    stuentName.text = st.name;
    studentDetails.text = st.description;
    // TODO: implement build
    return WillPopScope(
        onWillPop: () {
          debugPrint("WillPopScope");
          GoBack();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(screenTitle),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 15, left: 10, right: 10),
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: DropdownButton(
                    items: _status.map((String DropDownItem) {
                      return DropdownMenuItem<String>(
                        value: DropDownItem,
                        child: Text(DropDownItem),
                      );
                    }).toList(),
                    value: getPass(st.pass),
                    onChanged: (selectedItem) {
                      setState(() {
                        setpassing(selectedItem);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 15,
                    bottom: 15,
                  ),
                  child: TextField(
                    controller: stuentName,
                    onChanged: (value) {
                      st.name = value;
                    },
                    decoration: InputDecoration(
                        labelText: "Name:",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 15,
                    bottom: 15,
                  ),
                  child: TextField(
                    controller: studentDetails,
                    onChanged: (value) {
                      st.description = value;
                    },
                    decoration: InputDecoration(
                        labelText: "Details:",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Row(
                    children: [
                      Expanded(
                          child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            debugPrint("Save Is pressed");
                            _save();
                          });
                        },
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          "SAVE",
                          textScaleFactor: 1.5,
                        ),
                      )),
                      Container(
                        margin: EdgeInsets.all(10),
                      ),
                      Expanded(
                          child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            debugPrint("Delete Is pressed");
                            _delete();
                          });
                        },
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          "Delete",
                          textScaleFactor: 1.5,
                        ),
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void setpassing(String stat) {
    switch (stat) {
      case "Successed":
        st.pass = 1;
        break;
      case "Failed":
        st.pass = 2;
    }
  }

  String getPass(int stat) {
    String pass;
    switch (stat) {
      case 1:
        pass = _status[0];
        break;
      case 2:
        pass = _status[1];
        break;
    }
    return pass;
  }

  void _save() async {
    GoBack();
    st.date = DateTime.now().toString();
    int result;
    if (st.id == null) {
      result = await _sql_helper.insertStudent(st);
    } else {
      result = await _sql_helper.updateStudent(st);
    }
    if (result == 0)
      showDialogForSave("Not Saved", "Not Saved");
    else {
      showDialogForSave("Saved", "Saved");
    }
  }

  void _delete() async {
    if (st.id == null) {
      showDialogForSave("No student deleted", "delete message");
      return;
    }
    int result = await _sql_helper.deleteStudent(st.id);
    if (result == 0) {
      showDialogForSave("No student deleted", "delete message");
    } else {
      showDialogForSave(" student deleted", "delete message");
    }
  }

  void showDialogForSave(String msg, String title) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void GoBack() {
    Navigator.pop(context, true);
  }
}

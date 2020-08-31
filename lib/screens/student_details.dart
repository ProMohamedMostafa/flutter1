import 'package:flutter/material.dart';

class StudentDetails extends StatefulWidget {
  String sceentitle;
  StudentDetails(this.sceentitle);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return students(this.sceentitle);
  }
}

class students extends State<StudentDetails> {
  String screenTitle;
  students(this.screenTitle);
  static var _status = {"Successed", "Failed"};
  TextEditingController StuentName = new TextEditingController();
  TextEditingController StudentDetails = new TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    value: 'Successed',
                    onChanged: (selectedItem) {
                      setState(() {
                        debugPrint("User Select $selectedItem");
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
                    controller: StuentName,
                    onChanged: (value) {
                      debugPrint("User Edit the Name");
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
                    controller: StudentDetails,
                    onChanged: (value) {
                      debugPrint("User Edit the Details");
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

  void GoBack() {
    Navigator.pop(context);
  }
}

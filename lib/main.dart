import 'package:flutter/material.dart';
import 'package:student_list/screens/studentList.dart';
import 'package:student_list/screens/student_details.dart';
import 'dart:async';

void main()  {
  //getFileContent();
  //print(await DownloadFile());
  runApp(
      MyApp()
  );

}

void getFileContent() async {
  String filecontent = await DownloadFile();
  print(filecontent);
}

Future<String> DownloadFile() {
  Future<String> Content = Future.delayed(Duration(seconds: 6), () {
    return "Internert Downloaded";
  });
  Future.delayed(Duration(seconds: 4), () {
    print("Hiiiiiii");
  });
  return Content;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO : implement build
    return MaterialApp(
      title: "Student List",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: StudentList(),
    );
  }
}

import 'dart:async';
import 'dart:core';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:student_list/models/student.dart';

class SQL_Helper {
  static SQL_Helper dbhelper;
  static Database _database;
  SQL_Helper._createInstance();

  factory SQL_Helper() {
    if (dbhelper == null) {
      dbhelper = SQL_Helper._createInstance();
    }
    return dbhelper;
  }
  Future<Database> initializedDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "students.db";
    var studentDb =
        await openDatabase(path, version: 1, onCreate: createDatabse);
    return studentDb;
  }
  // void createDataBase(Database)

  String tableName = "students_table";
  String id = "id";
  String name = "name";
  String description = "description";
  String pass = "pass";
  String date = "date";
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializedDatabase();
    }
    return _database;
  }

  void createDatabse(Database db, int version) async {
    String sql =
        "Create Table $tableName($id integer primary key autoincrement,$name Text,$description text,$pass integer,$date text)";
    await db.execute(sql);
  }

  Future<List<Map<String, dynamic>>> getstudentMapList() async {
    Database db = await this.database;

    var result = await db.query(tableName, orderBy: "$id ASC");
    return result;
  }

  Future<int> insertStudent(student st) async {
    Database db = await this.database;
    var result = await db.insert(tableName, st.toMap());
    return result;
  }

  Future<int> updateStudent(student st) async {
    Database db = await this.database;
    var result = await db
        .update(tableName, st.toMap(), where: "$id=?", whereArgs: [st.id]);
    return result;
  }

  Future<int> deleteStudent(int stID) async {
    Database db = await this.database;
    //var result = await db.rawDelete("Delete from $tableName where $id=$stID");
    var result = await db.delete(tableName, where: "$id=?", whereArgs: [stID]);
    return result;
  }

  Future<int> getcount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> all =
        await db.rawQuery("select count(*) from $tableName");
    int result = Sqflite.firstIntValue(all);
    return result;
  }

  Future<List<student>> getStudentsList() async {
    var studentsMapList = await getstudentMapList();
    int count = studentsMapList.length;
    if (count != 0) {
      List<student> students = new List<student>();
      for (int i = 0; i < count; i++) {
        students.add(student.getMap(studentsMapList[i]));
      }
      return students;
    }
    return null;
  }
}

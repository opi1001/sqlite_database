import 'package:database_sqflite/Views/DatabasePractice/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDbHelper {
  static Future<Database> initDb() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'ContactDB');
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
    );
  }

  static _onCreate(Database db, int version) async {
    var sql =
        ''' CREATE TABLE tbl contact(id INTEGER PRIMARY KEY,name TEXT,phone_TEXT)''';
    await db.execute(sql);
  }

  static Future<int> createContact(Contact contact) async {
    Database db = await MyDbHelper.initDb();
    return await db.insert('tbl_contact', contact.toMap());
  }

  Future<List<Contact>> readContact() async {
    Database db = await MyDbHelper.initDb();
    var contact = await db.query('tbl_Contact');

    List<Contact> contactList = contact.isNotEmpty
        ? contact.map((e) => Contact.fromMap(e)).toList()
        : [];
    return contactList;
  }

  static Future<int> updateContact(Contact contact) async {
    Database db = await MyDbHelper.initDb();
    return await db.update('tbl_contact', contact.toMap(),
        where: 'id = ?', whereArgs: [contact.id]);
  }

  static Future<int> deleteContact(int id) async {
    Database db = await MyDbHelper.initDb();
    return await db.delete('tbl_contact', where: 'id = ?', whereArgs: [id]);
  }
}

import 'dart:developer';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (database != null) return database;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'whatsapp_clone.db');
    return await openDatabase(
      path,
      version: 14,
      onCreate: _createDb,
      // onUpgrade: _upgradeDb
    );
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE userdata(
      id TEXT PRIMARY KEY,
      name TEXT,
      modile TEXT,
      profile TEXT,
      createdAt DATETIME,
      about TEXT
    )
  ''');

    await db.execute('''
        CREATE TABLE chats(
          id TEXT PRIMARY KEY,
          userId TEXT UNIQUE,
          name TEXT,
          lastMessage TEXT,
          timestamp INTEGER,
          profileUrl TEXT,
          isOnline INTEGER,
          isMuted INTEGER DEFAULT 0,
          isPin INTEGER DEFAULT 0
        )
      ''');

    await db.execute('''
        CREATE TABLE messages(
          id TEXT PRIMARY KEY,
          chatId TEXT,
          content TEXT,
          timestamp DATETIME,
          isSentByMe INTEGER DEFAULT 0,
          messageType TEXT DEFAULT 'text',
          messageReaction TEXT DEFAULT NULL, 
          FOREIGN KEY (chatId) REFERENCES chats (id)
        )
      ''');
  }

  Future<void> _upgradeDb(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 14) {
      await db.execute(
          "ALTER TABLE messages ADD COLUMN messageReaction TEXT DEFAULT NULL");
    }
  }

  //---------------------------------------------------------

  // Chat operations
  Future<Object> insertChat(Map<String, dynamic> chat) async {
    Database db = await database;
    // return await db.insert('chats', chat);
    List<Map> existingChats = await db.query(
      'chats',
      where: 'userId = ?',
      whereArgs: [chat['userId']],
    );

    if (existingChats.isEmpty) {
      return await db.insert('chats', chat);
    } else {
      // If the chat exists, update it
      return existingChats.first;
    }
  }

  Future<List<Map<String, dynamic>>> getChats() async {
    Database db = await database;
    return await db.query('chats', orderBy: 'timestamp DESC');
  }

  // Future<int> updateChat(Map<String, dynamic> chat) async {
  Future<int> updateChat(
      String id, String lastMessage, int timestamp) async {
    log('-=--=-===-=-=-=-==-=update the chat LastMessage is ${lastMessage}-=-=-==-=-');
    Database db = await database;
    return await db.update(
      'chats',
      {
        'lastMessage': lastMessage,
        'timestamp': timestamp,
      },
      where: 'id = ?',
      whereArgs: [
        id
      ],
    );
  }

  Future<int> deleteChat(String userId) async {
    Database db = await database;
    return await db.delete(
      'chats',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  //MuteChat
  Future<void> muteChat(String userId) async {
    Database db = await database;
    await db.update(
      'chats',
      {'isMuted': 1}, // Set isMuted to true
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  //UnMute
  Future<void> unmuteChat(String userId) async {
    Database db = await database;
    await db.update(
      'chats',
      {'isMuted': 0}, // Set isMuted to false
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  Future<void> pinChat(String chatId) async {
    Database db = await database;
    await db.update(
      'chats',
      {'isPin': 1}, // Set isPin to true
      where: 'id = ?',
      whereArgs: [chatId],
    );
  }

  Future<void> unpinChat(String chatId) async {
    Database db = await database;
    await db.update(
      'chats',
      {'isPin': 0}, // Set isPin to false
      where: 'id = ?',
      whereArgs: [chatId],
    );
  }

  // Message operations
  Future<int> insertMessage(Map<String, dynamic> message) async {
    log('----------msg add----------------');
    Database db = await database;
    return await db.insert('messages', message);
  }

  Future<List<Map<String, dynamic>>> getMessages(
      String chatId, {
        required int offset,
        required int limit,
      }) async {
    log('------------offset $offset--------- limit $limit -----------------');
    Database db = await database;
    return await db.query('messages',
        where: 'chatId = ?',
        whereArgs: [chatId],
        orderBy:
        'timestamp DESC', // Change ASC to DESC to get new messages first
        limit: limit,
        offset: offset
    );
  }

  Future<int> updateMessage(Map<String, dynamic> message) async {
    Database db = await database;
    return await db.update(
      'messages',
      message,
      where: 'id = ?',
      whereArgs: [message['id']],
    );
  }

  Future<int> addMessageReaction(String messageId, String reaction) async {
    Database db = await database;
    // log('---------------message recation in database $reaction---------------------');
    return await db.update(
      'messages',
      {'messageReaction': reaction}, // Update with the new reaction
      where: 'id = ?',
      whereArgs: [messageId],
    );
  }

  Future<int> deleteMessageReaction(String messageId) async {
    Database db = await database;
    return await db.update(
      'messages',
      {'messageReaction': null}, // Set reaction to null to remove it
      where: 'id = ?',
      whereArgs: [messageId],
    );
  }

  Future<Map<String, dynamic>?> getMessageReaction(String messageId) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'messages',
      where: 'id = ?',
      whereArgs: [messageId],
      limit: 1,
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<int> deleteMessage(String id) async {
    Database db = await database;
    return await db.delete(
      'messages',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteMessagesByChatId(String chatId) async {
    Database db = await database;
    return await db.delete(
      'messages',
      where: 'chatId = ?',
      whereArgs: [chatId],
    );
  }

  //----------------
  Future<int> insertUserData(Map<String, dynamic> user) async {
    log('_++_+_+_+_+_+_+_+_+_+_+_insertUserData+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_');
    Database db = await database;
    return await db.insert('userdata', user);
  }

  Future<List<Map<String, dynamic>>> getUserData() async {
    Database db = await database;
    return await db.query('userdata');
  }
}

//  Future<List<Map<String, dynamic>>> getMessages(String chatId) async {
//     Database db = await database;
//     return await db.query(
//       'messages',
//       where: 'chatId = ?',
//       whereArgs: [chatId],
//       orderBy: 'timestamp ASC',
//     );
//   }
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import '../model/cart_item.dart';
//
// class DatabaseService {
//   static final DatabaseService instance = DatabaseService._init();
//   static Database? _database;
//
//   DatabaseService._init();
//
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB('cart.db');
//     return _database!;
//   }
//
//   Future<Database> _initDB(String filePath) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, filePath);
//
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _createDB,
//     );
//   }
//
//   Future<void> _createDB(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE cart_items(
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         mealId INTEGER NOT NULL,
//         mealName TEXT NOT NULL,
//         price REAL NOT NULL,
//         quantity INTEGER NOT NULL,
//         image TEXT NOT NULL
//       )
//     ''');
//   }
//
//   Future<void> saveCartItem(CartItem item) async {
//     final db = await database;
//
//     // Check if item exists
//     final List<Map<String, dynamic>> existingItems = await db.query(
//       'cart_items',
//       where: 'mealId = ?',
//       whereArgs: [item.mealId],
//     );
//
//     if (existingItems.isNotEmpty) {
//       // Update existing item
//       await db.update(
//         'cart_items',
//         {
//           'quantity': item.quantity,
//           'price': item.price,
//         },
//         where: 'mealId = ?',
//         whereArgs: [item.mealId],
//       );
//     } else {
//       // Insert new item
//       await db.insert('cart_items', {
//         'mealId': item.mealId,
//         'mealName': item.mealName,
//         'price': item.price,
//         'quantity': item.quantity,
//         'image': item.image,
//       });
//     }
//   }
//
//   Future<List<CartItem>> getCartItems() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('cart_items');
//
//     return List.generate(maps.length, (i) {
//       return CartItem(
//         mealId: maps[i]['mealId'],
//         mealName: maps[i]['mealName'],
//         price: maps[i]['price'],
//         quantity: maps[i]['quantity'],
//         image: maps[i]['image'],
//       );
//     });
//   }
//
//   Future<void> removeCartItem(int mealId) async {
//     final db = await database;
//     await db.delete(
//       'cart_items',
//       where: 'mealId = ?',
//       whereArgs: [mealId],
//     );
//   }
//
//   Future<void> clearCart() async {
//     final db = await database;
//     await db.delete('cart_items');
//   }
//
//   Future<void> updateCartItemQuantity(int mealId, int quantity) async {
//     final db = await database;
//     await db.update(
//       'cart_items',
//       {'quantity': quantity},
//       where: 'mealId = ?',
//       whereArgs: [mealId],
//     );
//   }
// }

import 'package:meals_app/features/home/data/meal_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    // Initialize database if not already initialized
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    
    String path = join(await getDatabasesPath(), 'meals.db');
// '/Users/mac/Public/my storage/ meals.db
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await _createDatabase(db);
      },
    );
  }

  Future<void> _createDatabase(Database db) async {
    await db.execute('''
      CREATE TABLE meals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        imageUrl TEXT,
        name TEXT,
        calories REAL,
        description TEXT,
        rate REAL,
        time TEXT
      )
    ''');
  }

  Future<int> insertMeal(MealModel meal) async {
    Map<String, dynamic> mealMap = meal.toMap();
    final db = await database;
    return await db.insert('meals', mealMap);
  }

  Future<List<MealModel>> getMeals() async {
    final db = await database;
    List<Map<String, dynamic>> mealsJson = await db.query('meals');
    
    List<MealModel> meals = mealsJson.map((mealJson) {
      return MealModel.fromMap(mealJson);
    }).toList();
    return meals;
  }
}
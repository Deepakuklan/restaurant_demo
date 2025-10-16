import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteDatabaseService {
  static final SQLiteDatabaseService _instance = SQLiteDatabaseService._internal();
  factory SQLiteDatabaseService() => _instance;
  SQLiteDatabaseService._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'restaurant_pos.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create USUARIOS table
    await db.execute('''
      CREATE TABLE USUARIOS (
        Codigo_Acceso TEXT PRIMARY KEY,
        Clave TEXT,
        Nombre_Usuario TEXT,
        Codigo_Camarero TEXT,
        Es_camarero INTEGER DEFAULT 0,
        Tarjeta_Admin INTEGER DEFAULT 0
      )
    ''');

    // Create SECCIONES table
    await db.execute('''
      CREATE TABLE SECCIONES (
        Codigo TEXT PRIMARY KEY,
        Nombre TEXT,
        Activa INTEGER DEFAULT 1
      )
    ''');

    // Create MESAS table
    await db.execute('''
      CREATE TABLE MESAS (
        Codigo TEXT PRIMARY KEY,
        Codigo_Zona TEXT,
        Descripcion_MESA TEXT,
        Activa INTEGER DEFAULT 1,
        FOREIGN KEY (Codigo_Zona) REFERENCES SECCIONES(Codigo)
      )
    ''');

    // Create MENU table
    await db.execute('''
      CREATE TABLE MENU (
        Codigo TEXT PRIMARY KEY,
        Nombre_menu TEXT,
        Color_Menu TEXT
      )
    ''');

    // Create PRODUCTOS table
    await db.execute('''
      CREATE TABLE PRODUCTOS (
        Codigo TEXT PRIMARY KEY,
        Nombre TEXT,
        Codigo_Menu TEXT,
        Precio REAL,
        Tiene_Acompanamiento INTEGER DEFAULT 0,
        Tiene_Terminacion INTEGER DEFAULT 0,
        Tiene_Mezcla INTEGER DEFAULT 0,
        TIENE_SALSA INTEGER DEFAULT 0,
        FOREIGN KEY (Codigo_Menu) REFERENCES MENU(Codigo)
      )
    ''');

    // Create TERMINACION_PRODUCTOS table
    await db.execute('''
      CREATE TABLE TERMINACION_PRODUCTOS (
        Codigo TEXT PRIMARY KEY,
        Nombre TEXT
      )
    ''');

    // Create Acompanamientos table
    await db.execute('''
      CREATE TABLE Acompanamientos (
        Codigo TEXT PRIMARY KEY,
        Nombre TEXT
      )
    ''');

    // Create Salsas table
    await db.execute('''
      CREATE TABLE Salsas (
        Codigo TEXT PRIMARY KEY,
        Nombre TEXT
      )
    ''');

    // Create FACTURA_EN_ESPERA table
    await db.execute('''
      CREATE TABLE FACTURA_EN_ESPERA (
        Id TEXT PRIMARY KEY,
        Codigo_Vendedor TEXT,
        Codigo_Mesa TEXT,
        Codigo_Zona TEXT,
        ESTATUS INTEGER DEFAULT 1,
        Fecha_Creacion TEXT,
        FOREIGN KEY (Codigo_Mesa) REFERENCES MESAS(Codigo),
        FOREIGN KEY (Codigo_Zona) REFERENCES SECCIONES(Codigo)
      )
    ''');

    // Create FACTURAS_EN_ESPERA_DETALLE table
    await db.execute('''
      CREATE TABLE FACTURAS_EN_ESPERA_DETALLE (
        Id TEXT PRIMARY KEY,
        Factura_Id TEXT,
        Codigo_Producto TEXT,
        Nombre_Producto TEXT,
        Cantidad INTEGER,
        Precio REAL,
        Subtotal REAL,
        Terminacion TEXT,
        Acompanamiento TEXT,
        Salsa TEXT,
        Nota TEXT,
        Silla_Comensal INTEGER,
        Cantidad_Vasos INTEGER,
        FOREIGN KEY (Factura_Id) REFERENCES FACTURA_EN_ESPERA(Id)
      )
    ''');

    // Insert sample data
    await _insertSampleData(db);
  }

  Future<void> _insertSampleData(Database db) async {
    // Insert sample user (waiter)
    await db.insert('USUARIOS', {
      'Codigo_Acceso': '1234',
      'Clave': '1234',
      'Nombre_Usuario': 'Demo Waiter',
      'Codigo_Camarero': 'W001',
      'Es_camarero': 1,
      'Tarjeta_Admin': 1,
    });

    // Insert sample sections
    final sections = [
      {'Codigo': 'S001', 'Nombre': 'SALON', 'Activa': 1},
      {'Codigo': 'S002', 'Nombre': 'TERRAZA', 'Activa': 1},
      {'Codigo': 'S003', 'Nombre': 'BAR', 'Activa': 1},
      {'Codigo': 'S004', 'Nombre': 'BALCON', 'Activa': 1},
      {'Codigo': 'S005', 'Nombre': 'PISCINA', 'Activa': 1},
    ];
    for (var section in sections) {
      await db.insert('SECCIONES', section);
    }

    // Insert sample tables
    for (int i = 1; i <= 12; i++) {
      await db.insert('MESAS', {
        'Codigo': 'M$i',
        'Codigo_Zona': 'S001',
        'Descripcion_MESA': 'Mesa $i',
        'Activa': 1,
      });
    }

    // Insert sample menus
    final menus = [
      {'Codigo': 'MEN001', 'Nombre_menu': 'ENTRADAS', 'Color_Menu': '#FF6B00'},
      {'Codigo': 'MEN002', 'Nombre_menu': 'CARNES', 'Color_Menu': '#8B4513'},
      {'Codigo': 'MEN003', 'Nombre_menu': 'PARRILLADA', 'Color_Menu': '#DC143C'},
      {'Codigo': 'MEN004', 'Nombre_menu': 'BEBIDAS', 'Color_Menu': '#4169E1'},
      {'Codigo': 'MEN005', 'Nombre_menu': 'POSTRES', 'Color_Menu': '#FFD700'},
      {'Codigo': 'MEN006', 'Nombre_menu': 'PASTAS', 'Color_Menu': '#32CD32'},
    ];
    for (var menu in menus) {
      await db.insert('MENU', menu);
    }

    // Insert sample products
    final products = [
      {'Codigo': 'P001', 'Nombre': 'Ensalada César', 'Codigo_Menu': 'MEN001', 'Precio': 8.50, 'Tiene_Acompanamiento': 0, 'Tiene_Terminacion': 0, 'Tiene_Mezcla': 0, 'TIENE_SALSA': 1},
      {'Codigo': 'P002', 'Nombre': 'Sopa de Cebolla', 'Codigo_Menu': 'MEN001', 'Precio': 6.00, 'Tiene_Acompanamiento': 0, 'Tiene_Terminacion': 0, 'Tiene_Mezcla': 0, 'TIENE_SALSA': 0},
      {'Codigo': 'P003', 'Nombre': 'Filete de Res', 'Codigo_Menu': 'MEN002', 'Precio': 18.50, 'Tiene_Acompanamiento': 1, 'Tiene_Terminacion': 1, 'Tiene_Mezcla': 0, 'TIENE_SALSA': 1},
      {'Codigo': 'P004', 'Nombre': 'Pollo Asado', 'Codigo_Menu': 'MEN002', 'Precio': 14.00, 'Tiene_Acompanamiento': 1, 'Tiene_Terminacion': 0, 'Tiene_Mezcla': 0, 'TIENE_SALSA': 1},
      {'Codigo': 'P005', 'Nombre': 'Parrillada Mixta', 'Codigo_Menu': 'MEN003', 'Precio': 25.00, 'Tiene_Acompanamiento': 1, 'Tiene_Terminacion': 1, 'Tiene_Mezcla': 0, 'TIENE_SALSA': 1},
      {'Codigo': 'P006', 'Nombre': 'Coca Cola', 'Codigo_Menu': 'MEN004', 'Precio': 2.50, 'Tiene_Acompanamiento': 0, 'Tiene_Terminacion': 0, 'Tiene_Mezcla': 0, 'TIENE_SALSA': 0},
      {'Codigo': 'P007', 'Nombre': 'Jugo Natural', 'Codigo_Menu': 'MEN004', 'Precio': 3.50, 'Tiene_Acompanamiento': 0, 'Tiene_Terminacion': 0, 'Tiene_Mezcla': 0, 'TIENE_SALSA': 0},
      {'Codigo': 'P008', 'Nombre': 'Tiramisú', 'Codigo_Menu': 'MEN005', 'Precio': 5.50, 'Tiene_Acompanamiento': 0, 'Tiene_Terminacion': 0, 'Tiene_Mezcla': 0, 'TIENE_SALSA': 0},
      {'Codigo': 'P009', 'Nombre': 'Pasta Carbonara', 'Codigo_Menu': 'MEN006', 'Precio': 12.00, 'Tiene_Acompanamiento': 0, 'Tiene_Terminacion': 0, 'Tiene_Mezcla': 0, 'TIENE_SALSA': 0},
    ];
    for (var product in products) {
      await db.insert('PRODUCTOS', product);
    }

    // Insert terminaciones (cooking terms)
    final terms = [
      {'Codigo': 'T001', 'Nombre': 'BIEN COCIDO'},
      {'Codigo': 'T002', 'Nombre': 'TERMINO MEDIO'},
      {'Codigo': 'T003', 'Nombre': '¾'},
      {'Codigo': 'T004', 'Nombre': 'VUELTA Y VUELTA'},
    ];
    for (var term in terms) {
      await db.insert('TERMINACION_PRODUCTOS', term);
    }

    // Insert acompanamientos (side dishes)
    final sides = [
      {'Codigo': 'A001', 'Nombre': 'PURE'},
      {'Codigo': 'A002', 'Nombre': 'PAPAS FRITAS'},
      {'Codigo': 'A003', 'Nombre': 'TOSTONES'},
      {'Codigo': 'A004', 'Nombre': 'ENSALADA VERDE'},
    ];
    for (var side in sides) {
      await db.insert('Acompanamientos', side);
    }

    // Insert salsas (sauces)
    final sauces = [
      {'Codigo': 'SA001', 'Nombre': 'SALSA BBQ'},
      {'Codigo': 'SA002', 'Nombre': 'SALSA DE CHAMPIÑONES'},
      {'Codigo': 'SA003', 'Nombre': 'SALSA PICANTE'},
      {'Codigo': 'SA004', 'Nombre': 'SALSA DE AJO'},
    ];
    for (var sauce in sauces) {
      await db.insert('Salsas', sauce);
    }
  }

  Future<List<Map<String, dynamic>>> query(String sql, [List<dynamic>? arguments]) async {
    final db = await database;
    return await db.rawQuery(sql, arguments);
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    final db = await database;
    return await db.insert(table, values, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> update(String table, Map<String, dynamic> values, String where, List<dynamic> whereArgs) async {
    final db = await database;
    return await db.update(table, values, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(String table, String where, List<dynamic> whereArgs) async {
    final db = await database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}

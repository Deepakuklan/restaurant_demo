import 'package:mssql_connection/mssql_connection.dart';
import 'database_config.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  MssqlConnection? _connection;
  DatabaseConfig? _config;

  Future<void> initialize(DatabaseConfig config) async {
    _config = config;
  }

  Future<bool> testConnection(DatabaseConfig config) async {
    try {
      final connection = MssqlConnection.getInstance();
      final connected = await connection.connect(
        ip: config.instance,
        port: config.port.toString(),
        databaseName: config.database,
        username: config.username,
        password: config.password,
      );
      
      if (connected) {
        await connection.disconnect();
        return true;
      }
      return false;
    } catch (e) {
      print('Connection test failed: $e');
      return false;
    }
  }

  Future<MssqlConnection> getConnection() async {
    if (_config == null) {
      throw Exception('Database not configured');
    }

    if (_connection != null) {
      return _connection!;
    }

    final connection = MssqlConnection.getInstance();
    final connected = await connection.connect(
      ip: _config!.instance,
      port: _config!.port.toString(),
      databaseName: _config!.database,
      username: _config!.username,
      password: _config!.password,
    );

    if (!connected) {
      throw Exception('Failed to connect to database');
    }

    _connection = connection;
    return _connection!;
  }

  Future<void> disconnect() async {
    if (_connection != null) {
      await _connection!.disconnect();
      _connection = null;
    }
  }

  Future<List<Map<String, dynamic>>> query(String sql) async {
    try {
      final connection = await getConnection();
      final dynamic result = await connection.getData(sql);
      
      if (result is List) {
        final List<Map<String, dynamic>> mappedResult = [];
        for (var item in result) {
          if (item is Map) {
            mappedResult.add(Map<String, dynamic>.from(item));
          }
        }
        return mappedResult;
      }
      
      // If result is not a list, treat it as error
      throw Exception('Query failed: ${result.toString()}');
    } catch (e) {
      print('Query error: $e');
      rethrow;
    }
  }

  Future<bool> execute(String sql) async {
    try {
      final connection = await getConnection();
      final result = await connection.writeData(sql);
      return result == true;
    } catch (e) {
      print('Execute error: $e');
      rethrow;
    }
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class DatabaseConfig {
  static const String _keyInstance = 'db_instance';
  static const String _keyDatabase = 'db_database';
  static const String _keyUsername = 'db_username';
  static const String _keyPassword = 'db_password';
  static const String _keyPort = 'db_port';

  String instance;
  String database;
  String username;
  String password;
  int port;

  DatabaseConfig({
    required this.instance,
    required this.database,
    required this.username,
    required this.password,
    this.port = 1433,
  });

  static Future<DatabaseConfig> load() async {
    final prefs = await SharedPreferences.getInstance();
    return DatabaseConfig(
      instance: prefs.getString(_keyInstance) ?? 'localhost',
      database: prefs.getString(_keyDatabase) ?? '',
      username: prefs.getString(_keyUsername) ?? 'sa',
      password: prefs.getString(_keyPassword) ?? '',
      port: prefs.getInt(_keyPort) ?? 1433,
    );
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyInstance, instance);
    await prefs.setString(_keyDatabase, database);
    await prefs.setString(_keyUsername, username);
    await prefs.setString(_keyPassword, password);
    await prefs.setInt(_keyPort, port);
  }

  String getConnectionString() {
    return 'Server=$instance,$port;Database=$database;User Id=$username;Password=$password;';
  }
}

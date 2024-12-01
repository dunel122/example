import 'package:mysql1/mysql1.dart';

class DBConnection {
  // Set up your MySQL connection settings
  static Future<MySqlConnection> connect() async {
    try {
      final conn = await MySqlConnection.connect(
        ConnectionSettings(
          host: '192.168.0.31', // E.g., 'localhost' or an IP address
          port: 3306, // Default MySQL port
          user: 'test', // Your MySQL username
          password: '123', // Your MySQL password
          db: 'senior', // Your MySQL database name
        ),
      );
      return conn;
    } catch (e) {
      print('Error connecting to the database: $e');
      rethrow;
    }
  }

  // Fetch all seniorinfo from the database
  static Future<List<Map<String, dynamic>>> fetchSeniors() async {
    final conn = await connect();
    var results = await conn.query('SELECT * FROM seniorinfo');

    // Convert the query results into a list of maps
    List<Map<String, dynamic>> seniorsList = [];
    for (var row in results) {
      seniorsList.add({
        'fname': row['fname'],
        'lname': row['lname'],
        'seniorid': row['seniorid'],
      });
    }

    await conn.close();
    return seniorsList;
  }
}

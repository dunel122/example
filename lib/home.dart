import 'package:flutter/material.dart';
import 'dbconnection.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Map<String, dynamic>>> seniorsList;

  @override
  void initState() {
    super.initState();
    seniorsList = DBConnection.fetchSeniors(); // Fetch data when the page is loaded
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seniors List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: seniorsList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available.'));
          } else {
            var seniors = snapshot.data!;
            return ListView.builder(
              itemCount: seniors.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${seniors[index]['fname']} ${seniors[index]['lname']}'),
                  subtitle: Text('ID: ${seniors[index]['seniorid']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}

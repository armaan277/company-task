import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoadingData = true;

  final uid = FirebaseAuth.instance.currentUser!.uid;

  int counter = 0;

  final db = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    getDataFromDatabase();
    super.initState();
  }

  void getDataFromDatabase() async {
    DataSnapshot snapshot = await db.child('$uid/counter').get();
    if (snapshot.value is int) {
      counter = snapshot.value as int;
    }
    isLoadingData = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Home Screen'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              GoogleSignIn().disconnect();
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed('/login');
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: isLoadingData
            ? CircularProgressIndicator(
                color: Colors.amber,
              )
            : Text(
                '$counter',
                style: TextStyle(
                  fontSize: 50,
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          _incrementValue();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _incrementValue() {
    setState(() {
      counter++;
      db.child('$uid/counter').set(counter);
    });
  }
}

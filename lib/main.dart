import 'package:firebase_app/src/providers/usersinfo.dart';
import 'package:firebase_app/src/widgets/Register.dart';
import 'package:firebase_app/src/widgets/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'src/pages/homePage.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FireApp());
}

class FireApp extends StatelessWidget{

  // Create the initialization Future outside of `build`:
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (context) => UsersInfo()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MaterialApp',
        initialRoute: '/home',
        routes: {
          '/home': (context) => HomePage(),
          '/login': (context) => LoginModal(),
          '/register': (context) => RegisterRestaurant()
        },
      ),
    );
  }
}

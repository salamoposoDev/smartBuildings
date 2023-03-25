import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smartbuilding/page/home/home_page.dart';
import 'bloc/database_bloc.dart';
import 'firebase_options.dart';

void main() async {
  //hive
  await Hive.initFlutter();
  // open box
  var box = Hive.openBox('myBox');
  // firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DatabaseBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        scrollBehavior: MaterialScrollBehavior(),
      ),
    );
  }
}

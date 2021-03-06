import 'package:assignment_universalflow/firebase_options.dart';
import 'package:assignment_universalflow/provider/trans_prov.dart';
import 'package:assignment_universalflow/view/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Universal Flow',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  HomePage(),
      ),
    );
  }
}

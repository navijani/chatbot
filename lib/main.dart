import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:novax_chatbot/pages/home_page.dart';
import 'package:novax_chatbot/pages/image_generator_provider.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  await dotenv.load(); // Load .env variables
  runApp(
    ChangeNotifierProvider(
      create: (_) => AIProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatPage(),
    );
  }
}

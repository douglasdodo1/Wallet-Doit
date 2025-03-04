import 'package:flutter/material.dart';
import 'package:frontend/viewmodels/user_view_model.dart';
import 'package:frontend/views/home_page_view.dart';
import 'package:provider/provider.dart';
import 'package:frontend/viewmodels/payment_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PaymentViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePageView(),
    );
  }
}

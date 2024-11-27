import 'package:flutter/material.dart';
import 'package:flutter_task_app/viewmodels/form_viewmodel.dart';
import 'package:flutter_task_app/viewmodels/home_viewmodel.dart';
import 'package:flutter_task_app/viewmodels/login_viewmodel.dart';
import 'package:flutter_task_app/viewmodels/servicelist_viewmode.dart';
import 'package:flutter_task_app/views/form/form_screen.dart';
import 'package:flutter_task_app/views/home/home_screen.dart';
import 'package:flutter_task_app/views/login/login.dart';
import 'package:provider/provider.dart';
// Import FormScreen

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ServiceListViewModel()),
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) => FormViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Citizen Services',
      theme: ThemeData(primarySwatch: Colors.teal),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/form') {
          // Extract arguments passed to the FormScreen
          final args = settings.arguments as Map<String, dynamic>;

          // Retrieve serviceName and service from the arguments
          final serviceName = args['serviceName'];
          //final service = args['service'];

          return MaterialPageRoute(
            builder: (context) => FormScreen(
              service: serviceName,
            ),
          );
        }
        // Define other routes here
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => LoginScreen());
          case '/home':
            return MaterialPageRoute(builder: (context) => HomeScreen());
          default:
            return null;
        }
      },
    );
  }
}

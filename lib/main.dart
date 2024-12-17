import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts_mini_app/blocs/contact/contact_bloc.dart';
import 'package:flutter_contacts_mini_app/blocs/contact/contact_event.dart' as contact_event;
import 'package:flutter_contacts_mini_app/blocs/contact/contact_state.dart' as contact_state;
import 'package:flutter_contacts_mini_app/database/database_sqflite_helper.dart' as db_helper;
import 'package:flutter_contacts_mini_app/screens/contact_list_screen.dart';
import 'package:flutter_contacts_mini_app/screens/drawer_screen.dart';

void main() {
  // runApp(MyApp());

    final db_helper.ContactDatabase database = db_helper.ContactDatabase.instance;

   runApp(
    BlocProvider(
      create: (context) => ContactBloc(database),  // Provide the ContactBloc at the root
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Contact Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DrawerScreen(
        body: Center(child: Text('Welcome to the Contact Management App!')), // Default body content
      ),
    );
  }
}

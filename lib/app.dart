// import 'package:flutter/material.dart';
// import 'screens/contact_list_screen.dart';
// import 'screens/favorite_contact_list_screen.dart';
// import 'screens/add_new_contact_screen.dart';

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Contact Manager',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         buttonTheme: ButtonThemeData(
//           buttonColor: Colors.blue,  // Button color
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),  // Rounded button corners
//           ),
//         ),
//       ),
//       home: ContactListScreen(),  // Set home screen to the contact list screen
//       routes: {
//         '/contact-list': (context) => ContactListScreen(),
//         '/favorite-contacts': (context) => const FavoriteContactListScreen(),
//         '/add-contact': (context) => const AddNewContactScreen(),
//       },
//     );
//   }
// }

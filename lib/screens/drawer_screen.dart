import 'package:flutter/material.dart';
import 'package:flutter_contacts_mini_app/screens/contact_list_screen.dart';
import 'package:flutter_contacts_mini_app/screens/favorite_contact_list_screen.dart';
import 'package:flutter_contacts_mini_app/screens/add_new_contact_screen.dart';


class DrawerScreen extends StatelessWidget {
  final Widget body; // The content (body) of the screen
  const DrawerScreen({super.key,required  this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact App'),
      ),
      // Drawer widget
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Drawer header
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Contact Options',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            // Contact list screen
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Contact List'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactListScreen()),
                );
              },
            ),
            // Favorite contacts screen
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favorite Contacts'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoriteContactListScreen()),
                );
              },
            ),
            // Add new contact screen
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Add New Contact'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AddNewContactScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: body
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts_mini_app/blocs/contact/contact_bloc.dart';
import 'package:flutter_contacts_mini_app/blocs/contact/contact_event.dart' as contact_event;
import 'package:flutter_contacts_mini_app/blocs/contact/contact_state.dart' as contact_state;
import 'package:flutter_contacts_mini_app/screens/add_new_contact_screen.dart';
import 'package:flutter_contacts_mini_app/screens/update_contact_screen.dart';
import 'package:flutter_contacts_mini_app/screens/drawer_screen.dart';
import 'package:flutter_contacts_mini_app/models/contact.dart' as contact_model;

class FavoriteContactListScreen extends StatefulWidget {
  const FavoriteContactListScreen({super.key});

  @override
  _FavouriteContactListScreenState createState() => _FavouriteContactListScreenState();
}

class _FavouriteContactListScreenState extends State<FavoriteContactListScreen> {
  @override
  void initState() {
    super.initState();
    // Dispatch LoadContacts event to load contacts when the widget is initialized
    BlocProvider.of<ContactBloc>(context).add(contact_event.LoadContacts());
  }

  @override
  Widget build(BuildContext context) {
    return  DrawerScreen(body: Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: BlocBuilder<ContactBloc, contact_state.ContactState>(
        builder: (context, state) {
          if (state is contact_state.ContactLoadingState) {
            return const Center(child: CircularProgressIndicator()); // Show loading spinner
          } else if (state is contact_state.ContactLoadedState) {
            var contacts = state.contacts.where((contact) => contact.isFavorite).toList();
            

            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contactItem = contacts[index];
                // If no photoPath, fallback to a color for the avatar background
                final photoUrl =  contactItem.photoPath != null &&  contactItem.photoPath!.isNotEmpty
                    ? contactItem.photoPath
                    : null;

             

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: photoUrl != null 
                        ? FileImage(File(photoUrl))
                        : null, // Only use image if photoUrl is not null
                    backgroundColor: photoUrl == null 
                        ? Colors.blueGrey // Set a fallback color if there's no photo
                        : null, 
                    child: photoUrl == null 
                        ? Text(contactItem.name[0].toUpperCase()) // Display first letter of name if no photo
                        : null, 
                  ),
                  title: Text(contactItem.name),
                  subtitle: Text(contactItem.mobile),
                  onTap: () {
                    // Navigate to the Update Contact screen (if implemented)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateContactScreen(contact: contactItem),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is contact_state.ContactErrorState) {
            return const Center(child: Text("Failed to load")); // Show error message
          }
          return Container(); // Default empty container if no state is found
        },
      ),
    
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_contacts_mini_app/models/contact.dart';
import 'dart:io';

import 'package:flutter_contacts_mini_app/screens/update_contact_screen.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;

  const ContactCard({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: contact.photoPath.isNotEmpty
            ? Image.file(
                File(contact.photoPath),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            : const Icon(Icons.person, size: 50),
        title: Text(contact.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(contact.mobile),
        trailing: IconButton(
          icon: Icon(
            contact.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: contact.isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            // Toggle favorite status
            // BlocProvider.of<ContactBloc>(context).add(
            //   ToggleFavoriteContactEvent(contact.id!),
            // );
          },
        ),
        onTap: () {
          // Navigate to UpdateContactScreen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateContactScreen(contact: contact),
            ),
          );
        },
      ),
    );
  }
}

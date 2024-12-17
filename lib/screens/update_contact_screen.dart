import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts_mini_app/blocs/contact/contact_bloc.dart';
import 'package:flutter_contacts_mini_app/blocs/contact/contact_event.dart' as contact_event;
import 'package:flutter_contacts_mini_app/models/contact.dart';
import 'package:flutter_contacts_mini_app/widgets/contact_form.dart';

class UpdateContactScreen extends StatelessWidget {
  final Contact contact;  // Accepting the contact parameter

  const UpdateContactScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Contact')),
      body: ContactForm(contact: contact),  // Pass the contact for editing
    );
  }
}

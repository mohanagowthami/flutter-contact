import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts_mini_app/blocs/contact/contact_bloc.dart';
import 'package:flutter_contacts_mini_app/blocs/contact/contact_state.dart' as contact_state;
import 'package:flutter_contacts_mini_app/widgets/contact_form.dart';
import 'package:flutter_contacts_mini_app/screens/drawer_screen.dart';

class AddNewContactScreen extends StatelessWidget {
  const AddNewContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  DrawerScreen(body: Scaffold(
      appBar: AppBar(title: const Text('Add New Contact')),
      body: BlocBuilder<ContactBloc, contact_state.ContactState>(
        builder: (context, state) {
          // You can update UI based on state here
          if (state is contact_state.ContactLoadingState) {
            return const Center(child: CircularProgressIndicator()); // Show loading indicator
          } else if (state is contact_state.ContactErrorState) {
            return const Center(child: Text("something went wrong")); // Show error message
          }
          
          return const ContactForm(); // Use ContactForm to add a new contact
        },
      ),
    ));
  }
}

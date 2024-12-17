import 'package:flutter_contacts_mini_app/models/contact.dart';

abstract class ContactState {}

class ContactInitial extends ContactState {}

// State when contacts are loading.
class ContactLoadingState extends ContactState {}

// State when contacts have been successfully loaded.
class ContactLoadedState extends ContactState {
  final List<Contact> contacts;
  ContactLoadedState(this.contacts);  // Pass the list of contacts to the state
}

// State when there is an error (e.g., failure to load or update contacts).
class ContactErrorState extends ContactState {
  final String message;

  ContactErrorState(this.message); // Optional: Pass error message to state
}

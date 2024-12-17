import 'package:flutter_contacts_mini_app/models/contact.dart';

// Abstract class for ContactEvent to represent various actions.
abstract class ContactEvent {}

// Event for loading the list of contacts.
class LoadContacts extends ContactEvent {}

// Event for adding a new contact.
class AddContact extends ContactEvent {
  final Contact contact;

  AddContact(this.contact);
}

// Event for updating an existing contact.
class UpdateContact extends ContactEvent {
  final Contact contact;

  UpdateContact(this.contact);
}

// Event for deleting a contact.
class DeleteContact extends ContactEvent {
  final int contactId;

  DeleteContact(this.contactId);
}

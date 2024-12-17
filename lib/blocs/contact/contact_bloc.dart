import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts_mini_app/database/database_sqflite_helper.dart';
import 'package:flutter_contacts_mini_app/blocs/contact/contact_event.dart' as contact_event;
import 'package:flutter_contacts_mini_app/blocs/contact/contact_state.dart' as contact_state;

class ContactBloc extends Bloc<contact_event.ContactEvent, contact_state.ContactState> {
  final ContactDatabase _database;

  // Constructor to initialize the BLoC with the database
  ContactBloc(this._database) : super(contact_state.ContactInitial()) {
    // Register event handlers
    on<contact_event.LoadContacts>(_onLoadContacts);
    on<contact_event.AddContact>(_onAddContact);
    on<contact_event.UpdateContact>(_onUpdateContact);
    on<contact_event.DeleteContact>(_onDeleteContact);
  }

  // Event handler for loading contacts
  Future<void> _onLoadContacts(contact_event.LoadContacts event, Emitter<contact_state.ContactState> emit) async {
    try {
      emit(contact_state.ContactLoadingState()); // Show loading state
      final contacts = await _database.getContacts(); // Fetch contacts from the database
      print("contacts in onload $contacts");
      emit(contact_state.ContactLoadedState(contacts)); // Emit loaded state with contacts
    } catch (error) {
      emit(contact_state.ContactErrorState("Failed to load contacts.")); // Emit error state
    }
  }

  // Event handler for adding a contact
  Future<void> _onAddContact(contact_event.AddContact event, Emitter<contact_state.ContactState> emit) async {
    try {
      print("add new contact");
      await _database.createContact(event.contact); // Add the new contact to the database
     final contacts = await _database.getContacts(); // Fetch the contacts again
     print("contacts in add new contact operation: ${contacts.map((contact) => 'Name: ${contact.name}, Mobile: ${contact.mobile}, Landline: ${contact.landline}, Favorite: ${contact.isFavorite}').toList()}");
    emit(contact_state.ContactLoadedState(contacts)); // Refresh the contact list after adding
    } catch (error) {
      print("in adding contact $error");
      emit(contact_state.ContactErrorState("Failed to add contact.")); // Emit error state
    }
  }

  // Event handler for updating a contact
  Future<void> _onUpdateContact(contact_event.UpdateContact event, Emitter<contact_state.ContactState> emit) async {
    try {
      await _database.updateContact(event.contact); // Update the contact in the database
      add(contact_event.LoadContacts()); // Refresh the contact list after updating
    } catch (_) {
      emit(contact_state.ContactErrorState("Failed to update contact.")); // Emit error state
    }
  }

  // Event handler for deleting a contact
  Future<void> _onDeleteContact(contact_event.DeleteContact event, Emitter<contact_state.ContactState> emit) async {
    try {
      await _database.deleteContact(event.contactId); // Delete the contact from the database
      add(contact_event.LoadContacts()); // Refresh the contact list after deleting
    } catch (_) {
      emit(contact_state.ContactErrorState("Failed to delete contact.")); // Emit error state
    }
  }
}

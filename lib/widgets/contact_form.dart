


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts_mini_app/blocs/contact/contact_bloc.dart';
import 'package:flutter_contacts_mini_app/blocs/contact/contact_event.dart' as contact_event;
import 'package:flutter_contacts_mini_app/models/contact.dart' as contact_model;
import 'package:image_picker/image_picker.dart';

class ContactForm extends StatefulWidget {
  final contact_model.Contact? contact;  // To edit an existing contact

  const ContactForm({super.key, this.contact});

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _landlineController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _imagePicker = ImagePicker();
  XFile? _imageFile; // To store selected or captured photo
  bool _isFavorite = false; // To track favorite status

  @override
  void initState() {
    super.initState();

    // Pre-fill the form if contact is being edited
    if (widget.contact != null) {
      _nameController.text = widget.contact!.name ?? '';  // Ensure not null
      _mobileController.text = widget.contact!.mobile ?? '';  // Ensure not null
      _landlineController.text = widget.contact!.landline ?? '';  // Ensure not null
      _isFavorite = widget.contact!.isFavorite;

      // Optionally, handle the photo if you want to display it
      _imageFile =  widget.contact!.photoPath != null && widget.contact!.photoPath!.isNotEmpty
    ? XFile(widget.contact!.photoPath!)
    : null;
    }
  }

  // Save or update the contact
  void _saveOrUpdateContact() {
    if (_formKey.currentState!.validate()) {
      final updatedContact = contact_model.Contact(
        id: widget.contact?.id,  // Use the existing contact's ID if editing
        name: _nameController.text,
        mobile: _mobileController.text,
        landline: _landlineController.text,
        photoPath: _imageFile?.path ?? '', // If photo is selected, use its path
        isFavorite: _isFavorite, // Favorite status
      );

      if (widget.contact != null) {
        // If contact is being updated
        BlocProvider.of<ContactBloc>(context).add(contact_event.UpdateContact(updatedContact)); // Update event
      } else {
        // If contact is new
        BlocProvider.of<ContactBloc>(context).add(contact_event.AddContact(updatedContact)); // Add event
      }

      // Go back to the previous screen
      Navigator.pop(context);
    }
  }

  // Delete the contact
  void _deleteContact() {
    if (widget.contact != null && widget.contact!.id != null ) {
      BlocProvider.of<ContactBloc>(context).add(contact_event.DeleteContact(widget.contact!.id!)); // Delete event
      Navigator.pop(context);  // Go back after deletion
    }
  }

  // Pick image from gallery or take a photo with the camera
  Future<void> _pickImage() async {
    final action = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choose an option"),
          content: const Text("Would you like to pick an image from the gallery or take a photo with the camera?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 0); // 0 for Camera
              },
              child: const Text('Take a Photo'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, 1); // 1 for Gallery
              },
              child: const Text('Choose from Gallery'),
            ),
          ],
        );
      },
    );

    if (action != null) {
      XFile? pickedFile;
      if (action == 0) {
        pickedFile = await _imagePicker.pickImage(source: ImageSource.camera); // Camera
      } else if (action == 1) {
        pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery); // Gallery
      }

      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Contact Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _mobileController,
              decoration: const InputDecoration(labelText: 'Mobile'),
              keyboardType: TextInputType.phone,
            ),
            TextFormField(
              controller: _landlineController,
              decoration: const InputDecoration(labelText: 'Landline'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                color: Colors.grey[200],
                child: Row(
                  children: [
                    const Icon(Icons.camera_alt),
                    const SizedBox(width: 10),
                    Text(_imageFile == null ? 'Pick a photo' : 'Photo selected'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _isFavorite,
                  onChanged: (value) {
                    setState(() {
                      _isFavorite = value ?? false;
                    });
                  },
                ),
                const Text('Favorite'),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveOrUpdateContact,
              child: Text(widget.contact == null ? 'Save Contact' : 'Update Contact'),
            ),
            if (widget.contact != null) ...[
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _deleteContact,
              
                child: const Text('Delete Contact'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

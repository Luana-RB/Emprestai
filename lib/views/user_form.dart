// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:appteste/models/user/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appteste/provider/users_provider.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

//Load Data
  void _loadFormaData(User user) {
    _formData['id'] = user.id!;
    _formData['name'] = user.name!;
    _formData['email'] = user.email!;
    _formData['password'] = user.password!;
  }

//Set Load Data
  @override
  void didChangeDependencies() {
    final user = ModalRoute.of(context)?.settings.arguments as User;
    _loadFormaData(user);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    const title = 'UserForm';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(title),
        centerTitle: true,
        actions: [
//Save Button
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState!.validate();
              if (isValid) {
                _form.currentState!.save();
//Find User ID
                final userProvider =
                    Provider.of<UsersProvider>(context, listen: false);
                final existingUser = userProvider.findById(_formData['id']!);
//Update user's data
                if (existingUser != null) {
                  existingUser.setName = _formData['name']!;
                  existingUser.setEmail = _formData['email']!;
                  existingUser.setPassword = _formData['password']!;
                  userProvider.notifyListeners();
                } else {
//if user doesn't exists yet, creat new user
                  final newUser = User(
                    id: _formData['id']!,
                    name: _formData['name']!,
                    email: _formData['email']!,
                    password: _formData['password']!,
                  );
                  userProvider.put(newUser);
                  userProvider.notifyListeners();
                }
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
//Form
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: Column(
            children: [
//Name field
              TextFormField(
                initialValue: _formData['name'],
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return ('Insert a valid name');
                  }
                  return null;
                },
                onSaved: (value) => _formData['name'] = value!,
              ),
//Email field
              TextFormField(
                initialValue: _formData['email'],
                decoration: const InputDecoration(labelText: 'Email'),
                onSaved: (value) => _formData['email'] = value!,
              ),
//Password field
              TextFormField(
                initialValue: _formData['password'],
                decoration: const InputDecoration(labelText: 'Password'),
                onSaved: (value) => _formData['password'] = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

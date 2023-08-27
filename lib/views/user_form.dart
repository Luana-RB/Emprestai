import 'package:appteste/appbar.dart';
import 'package:flutter/material.dart';

class UserForm extends StatelessWidget {
  const UserForm({super.key});

  @override
  Widget build(BuildContext context) {
    var title = 'UserForm';
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBarPage(title: title)),
    );
  }
}

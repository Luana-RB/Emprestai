//import 'dart:ffi';

import 'package:appteste/appbar.dart';
import 'package:appteste/components/user_tile.dart';
//import 'package:appteste/models/user/user.dart';
import 'package:appteste/provider/users_provider.dart';
import 'package:appteste/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = 'UserList';
    final UsersProvider users = Provider.of(context);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBarPage(title: title)),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (ctx, i) => UserTile(user: users.byIndex(i)),
      ),
      floatingActionButton: FloatingActionButton(
        focusColor: Colors.pinkAccent,
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.USER_FORM);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

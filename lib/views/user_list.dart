//import 'dart:ffi';

import 'package:appteste/appbar.dart';
import 'package:appteste/components/user_tile.dart';
import 'package:appteste/models/user/user.dart';
import 'package:appteste/navigationbar.dart';
//import 'package:appteste/models/user/user.dart';
import 'package:appteste/provider/users_provider.dart';
import 'package:appteste/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
var _selectedIndex=0;
void onTap(int index)  {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.of(context).pushNamed('/user-list');
        break;
      case 1:
        Navigator.of(context).pushNamed('/');
        break;
      case 2:
        Navigator.of(context).pushNamed('/user-form');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var title = 'UserList';
    final UsersProvider users = Provider.of(context);



    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBarPage(title: title)),
      drawer: const MyDrawer(),
      bottomNavigationBar: CustomBottomNavigationBar(
      selectedIndex: _selectedIndex,
      onItemTapped: onTap,
      ),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (ctx, i) => UserTile(user: users.byIndex(i)),
      ),
      floatingActionButton: FloatingActionButton(
        focusColor: Colors.pinkAccent,
        onPressed: () {
          Navigator.of(context).pushNamed(
            AppRoutes.USER_FORM,
            arguments: User(
              id: '',
              name: '',
              email: '',
              password: '',
              groupName: '',
              avatarUrl: '',
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

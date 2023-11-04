import 'package:appteste/components/user_tile.dart';
import 'package:appteste/provider/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final UsersProvider users = Provider.of(context);

    return ListView.builder(
      itemCount: users.count,
      itemBuilder: (ctx, i) => UserTile(user: users.byIndex(i)),
    );
  }
}

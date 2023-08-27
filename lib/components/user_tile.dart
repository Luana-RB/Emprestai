import 'package:appteste/models/user/user.dart';
import 'package:appteste/provider/users_provider.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    final UsersProvider users = Provider.of(context);
    final avatar = user.avatarUrl == null || user.avatarUrl!.isEmpty
        ? const CircleAvatar(child: Icon(Icons.person_2))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl!));
    //User UI
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: SizedBox(
        width: 100,
        child: Row(children: [
          //Edit Button
          IconButton(
            icon: const Icon(Icons.edit),
            color: Colors.pinkAccent,
            onPressed: () {},
          ),
          //Delete Button
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.black12,
            onPressed: () {
              users.remove(users.byIndex(0));
            },
          ),
        ]),
      ),
    );
  }
}

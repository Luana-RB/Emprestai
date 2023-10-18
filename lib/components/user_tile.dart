import 'package:appteste/models/user/user.dart';
import 'package:appteste/provider/users_provider.dart';
import 'package:appteste/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null || user.avatarUrl!.isEmpty
        ? const CircleAvatar(child: Icon(Icons.person_2))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl!));
    //User UI
    return ListTile(
      leading: avatar,
      title: Text(user.name ?? 'Name'),
      subtitle: Text(user.email ?? 'Email'),
      trailing: SizedBox(
        width: 100,
        child: Row(children: [
          //Edit Button
          IconButton(
            icon: const Icon(Icons.edit),
            color: Colors.black12,
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.POSTS_FORM,
                arguments: user,
              );
            },
          ),
          //Delete Button
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.redAccent,
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Excluir Usuário'),
                  content: const Text('Tem certeza?'),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Não'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Sim'),
                        ),
                      ],
                    ),
                  ],
                ),
              ).then((confirmed) {
                if (confirmed) {
                  Provider.of<UsersProvider>(context, listen: false)
                      .remove(user);
                }
              });
            },
          ),
        ]),
      ),
    );
  }
}

class UserNameListTile extends StatelessWidget {
  const UserNameListTile({super.key, required this.user});
  final String user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user),
    );
  }
}

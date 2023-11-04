import 'package:appteste/models/user/user.dart';
import 'package:appteste/provider/users_provider.dart';
import 'package:appteste/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    //User UI
    return ListTile(
      title: Text(user.name ?? 'Name'),
      subtitle: const Text('Mensagem'),
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.CHAT_PAGE,
          arguments: user,
        );
      },
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
//Delete Button
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.redAccent,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Excluir Conversa'),
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
                ).then(
                  (confirmed) {
                    if (confirmed) {
                      Provider.of<UsersProvider>(context, listen: false)
                          .remove(user);
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

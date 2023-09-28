import 'package:appteste/models/posts/post_generico.dart';
import 'package:appteste/models/user/user.dart';
import 'package:appteste/routes/app_routes.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  final Post post;
  final User solicitant;
  final User? owner;
  final String? nomeUsuario;
  const PostPage({
    super.key,
    required this.post,
    this.nomeUsuario,
    required this.solicitant,
    this.owner,
  });

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  String? _solicitantAvatarUrl;
  String? _ownerAvatarUrl;
  String? _solicitantName;
  String? _ownerName;

  final scrollController = ScrollController();
  bool isCurrentUserPostCreator() {
    return widget.post.creatorName == widget.nomeUsuario;
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {});
    _solicitantAvatarUrl = widget.solicitant.avatarUrl;
    _solicitantName = widget.solicitant.name;
  }

  @override
  Widget build(BuildContext context) {
    final String status = widget.post.status.toString();
    Color colorName;
    switch (status) {
      case 'Solicitado':
        colorName = Colors.pinkAccent;
      case 'Emprestado':
        colorName = Colors.orangeAccent;
      case 'Devolvido':
        colorName = Colors.green;
        break;
      default:
        colorName = Colors.black;
    }

    bool isCurrentUserCreator = isCurrentUserPostCreator();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorName,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.post.status.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: <Widget>[
//Edit Button
          if (isCurrentUserCreator)
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.POSTS_FORM,
                  arguments: widget.post,
                );
              },
            )
          else
//Chat Button
            IconButton(
              icon: const Icon(
                Icons.chat,
                color: Colors.white,
              ),
              onPressed: () {},
            )
        ],
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
//Header
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: colorName.withOpacity(0.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
//Title
                  Text(
                    widget.post.title.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorName,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
//Image
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    widget.post.imageUrl.toString(),
                    width: 480,
                    height: 310,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
//Description
            SizedBox(
              width: 480,
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.post.description.toString(),
                      softWrap: true,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.contain,
//Solicitant Image
                      child: CircleAvatar(
                        backgroundColor: colorName.withOpacity(0.3),
                        radius: 50,
                        foregroundImage: _solicitantAvatarUrl != null
                            ? NetworkImage(_solicitantAvatarUrl!)
                            : null,
                        child: Text(
                          (_solicitantName.toString()[0].toUpperCase()),
                          style: const TextStyle(fontSize: 42),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
//Solicitant Name
                    SizedBox(
                      child: Text(
                        _solicitantName.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.contain,
//Owner Image
                      child: CircleAvatar(
                        backgroundColor: colorName.withOpacity(0.3),
                        radius: 50,
                        foregroundImage: _ownerAvatarUrl != null
                            ? NetworkImage(_ownerAvatarUrl!)
                            : null,
                        child: Text(
                          _ownerName != null
                              ? _ownerName.toString()[0].toUpperCase()
                              : '?',
                          style: const TextStyle(fontSize: 42),
                        ),
                      ),
                    ),
//Owner Name
                    SizedBox(
                      child: Text(
                        _ownerName != null ? _ownerName.toString() : ' ',
                        style: const TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
              ],
            ),
//Date of Lending
            const Row(
              children: [
                SizedBox(
                  height: 30.0,
                  width: 50.0,
                  child: Text(
                    'SEG',
                    style: TextStyle(),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );

    //Date of returning
  }
}

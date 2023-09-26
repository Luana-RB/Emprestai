// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:appteste/models/posts/post_generico.dart';
import 'package:appteste/provider/posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostsForm extends StatefulWidget {
  const PostsForm({Key? key}) : super(key: key);

  @override
  State<PostsForm> createState() => _PostsFormState();
}

class _PostsFormState extends State<PostsForm> {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

//Load Data
  void _loadFormaData(Post post) {
    _formData['id'] = post.id!;
    _formData['title'] = post.title!;
    _formData['status'] = post.status!;
    _formData['imageUrl'] = post.imageUrl!;
    _formData['description'] = post.description!;
    _formData['creatorName'] = post.creatorName!;
    _formData['creatorProfileLink'] = post.creatorProfileLink!;
    // _formData['creatorImageUrl'] = post.creatorImageUrl!;
    // _formData['ownerName'] = post.ownerName!;
    //_formData['ownerProfileLink'] = post.ownerProfileLink!;
    //_formData['ownerImageUrl'] = post.ownerImageUrl!;
    _formData['dateOfLending'] = post.dateOfLending!;
    //_formData['dateOfReturning'] = post.dateOfReturning!;
  }

  @override
  void didChangeDependencies() {
    final post = ModalRoute.of(context)?.settings.arguments as Post?;
    if (post != null) {
      _loadFormaData(post);
    } else {
      _formData.clear();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Create a Post';
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
                final postProvider =
                    Provider.of<PostsProvider>(context, listen: false);
                final existingPost = postProvider.findById(_formData['id']!);
//Update user's data
                if (existingPost != null) {
                  existingPost.setId = _formData['id']!;
                  existingPost.setTitle = _formData['title']!;
                  existingPost.setStatus = _formData['status']!;
                  existingPost.setImageUrl = _formData['imageUrl']!;
                  existingPost.setDescription = _formData['description']!;
                  //existingPost.setCreatorImageUrl =_formData['creatorImageUrl']!;
                  existingPost.setCreatorName = _formData['creatorName']!;
                  // existingPost.setOwnerName= _formData['ownerName']!;
                  // existingPost.setOwnerProfileLink = _formData['ownerProfileLink']!;
                  // existingPost.setOwnerImageUrl = _formData['ownerImageUrl']!;
                  existingPost.setDateOfLending = _formData['dateOfLending']!;
                  //existingPost.setDateOfReturning = _formData['dateOfReturning']!;
                  postProvider.notifyListeners();
                } else {
//if user doesn't exists yet, creat new user
                  final newPost = Post(
                    id: _formData['id'],
                    title: _formData['title'],
                    status: _formData['status'],
                    imageUrl: _formData['imageUrl'],
                    description: _formData['description'],
                    creatorName: _formData['creatorName'],
                    creatorProfileLink: _formData['creatorProfileLink'],
                    //creatorImageUrl: _formData['creatorImageUrl'],
                    //ownerName: _formData['ownerName'],
                    //ownerProfileLink:  _formData['ownerProfileLink'],
                    //ownerImageUrl: _formData['ownerImageUrl'],
                    dateOfLending: _formData['dateOfLending'],
                    //dateOfReturning: _formData['dateOfReturning'],
                  );
                  postProvider.put(newPost);
                  postProvider.notifyListeners();
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
//Id field
              TextFormField(
                initialValue: _formData['id'],
                decoration: const InputDecoration(labelText: 'id'),
                onSaved: (value) => _formData['id'] = value!,
              ),
//Title field
              TextFormField(
                initialValue: _formData['title'],
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return ('Insert a valid title');
                  }
                  return null;
                },
                onSaved: (value) => _formData['title'] = value!,
              ),
//Status field
              TextFormField(
                initialValue: _formData['status'],
                decoration: const InputDecoration(labelText: 'status'),
                onSaved: (value) => _formData['status'] = value!,
              ),
//Image field
              TextFormField(
                initialValue: _formData['imageUrl'],
                decoration: const InputDecoration(labelText: 'imageUrl'),
                onSaved: (value) => _formData['imageUrl'] = value!,
              ),
//Description field
              TextFormField(
                initialValue: _formData['description'],
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => _formData['description'] = value!,
              ),
//CreatorName field
              TextFormField(
                initialValue: _formData['creatorName'],
                decoration: const InputDecoration(labelText: 'Creator Name'),
                onSaved: (value) => _formData['creatorName'] = value!,
              ),
              TextFormField(
                initialValue: _formData['creatorProfileLink'],
                decoration:
                    const InputDecoration(labelText: 'creatorProfileLink'),
                onSaved: (value) => _formData['creatorProfileLink'] = value!,
              ),
              TextFormField(
                initialValue: _formData['dateOfLending'],
                decoration: const InputDecoration(labelText: 'date Of Lending'),
                onSaved: (value) => _formData['dateOfLending'] = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

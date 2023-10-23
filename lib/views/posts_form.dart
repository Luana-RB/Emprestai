// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
import 'package:appteste/components/post_picture.dart';
import 'package:appteste/models/posts/post_generico.dart';
import 'package:appteste/models/user/user.dart';
import 'package:appteste/provider/posts_provider.dart';
import 'package:appteste/provider/users_provider.dart';
import 'package:appteste/views/post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

class PostsForm extends StatefulWidget {
  const PostsForm({Key? key, required this.idUsuario}) : super(key: key);
  final String idUsuario;

  @override
  State<PostsForm> createState() => _PostsFormState();
}

class StatusButtonController {
  String selectedStatus = 'Solicitado';
}

class _PostsFormState extends State<PostsForm> {
  final _form = GlobalKey<FormState>();
  final Map<String, Object> _formData = {};
  List<User> displayedUsers = [];

//Load Data
  void _loadFormaData(Post post) {
    _formData['id'] = post.id!;
    _formData['title'] = post.title!;
    _formData['status'] = post.status!;
    _formData['description'] = post.description!;
    _formData['creatorName'] = post.creatorId!;
    _formData['ownerId'] = post.ownerId != null ? post.ownerId! : 'null';
    _formData['dateOfLending'] = post.dateOfLending;
    _formData['dateOfReturning'] =
        post.dateOfReturning != null ? post.dateOfReturning! : 'null';
  }

  @override
  void initState() {
    super.initState();
    displayedUsers = [];
  }

// Status
  final StatusButtonController _statusButtonController =
      StatusButtonController();
  String selectedStatus = 'Solicitado';
  late DateTime selectedLendingDate;
  late DateTime? selectedReturningDate;

  @override
  void didChangeDependencies() {
    final post = ModalRoute.of(context)?.settings.arguments as Post?;
    if (post != null) {
      _loadFormaData(post);
      selectedStatus = _formData['status'].toString();
      selectedLendingDate = post.dateOfLending;
      selectedReturningDate = post.dateOfReturning;
    } else {
      selectedLendingDate = DateTime.now();
      selectedReturningDate = null;
    }
    super.didChangeDependencies();
  }

//Calendário
  Future<DateTime?> _selectLendingDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: selectedLendingDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null) {
      setState(() {
        selectedLendingDate = selectedDate;
      });
    }
    return selectedDate;
  }

  Future<DateTime?> _selectReturningDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: selectedReturningDate ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null) {
      if (selectedDate.isBefore(selectedLendingDate)) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'O dia da devolução não pode ser anterior ao dia de empréstimo.'),
          ),
        );
      } else {
        setState(() {
          selectedReturningDate = selectedDate;
        });
      }
    }
    return selectedDate;
  }

//Owner search
  final TextEditingController _searchController = TextEditingController();
  User? selectedOwner;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const title = '';
//Find User
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final User? thisUser = usersProvider.findById(widget.idUsuario.toString());
    String userId = thisUser != null ? thisUser.id.toString() : 'null';

    final UsersProvider users = Provider.of(context);

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

                final postProvider =
                    Provider.of<PostsProvider>(context, listen: false);
                final Post thisPost;

//Status Controller
                var selectedStatus = _statusButtonController.selectedStatus;

//Update post's data
                if (_formData['id'] != null) {
                  final existingPost =
                      postProvider.findById(_formData['id']!.toString());
                  selectedStatus = _formData['status'].toString();
                  existingPost!.setTitle = _formData['title']!.toString();
                  existingPost.setStatus = selectedStatus;
                  // existingPost.setImageUrl = _formData['imageUrl']!.toString();
                  existingPost.setDescription =
                      _formData['description']!.toString();
                  existingPost.setDateOfLending = selectedLendingDate;
                  if (selectedReturningDate != null) {
                    existingPost.setDateOfReturning = selectedReturningDate!;
                  }
                  if (selectedOwner != null) {
                    existingPost.setOwnerId = selectedOwner!.id.toString();
                  }

                  postProvider.notifyListeners();
                  thisPost = existingPost;
                } else {
//if post doesn't exists yet, creat new post
                  selectedStatus = 'Solicitado';
                  final newPost = Post(
                    id: null,
                    title: _formData['title'].toString(),
                    status: selectedStatus,
                    description: _formData['description'].toString(),
                    creatorId: userId,
                    ownerId: selectedOwner?.id,
                    dateOfLending: selectedLendingDate,
                    dateOfReturning: selectedReturningDate,
                  );
                  postProvider.put(newPost);
                  postProvider.notifyListeners();
                  thisPost = newPost;
                }

//Goes to post page after updated/created
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostPage(
                      post: thisPost,
                      idUsuario: widget.idUsuario,
                    ),
                  ),
                );
                // Navigator.pop(context);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: _formData['title'] != null
                          ? _formData['title'].toString()
                          : '',
                      decoration: const InputDecoration(labelText: 'Titulo'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return ('Insira um título');
                        }
                        return null;
                      },
                      onSaved: (value) => _formData['title'] = value!,
                    ),
                  ),
                  const SizedBox(width: 20),
// Status
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedStatus,
                      onChanged: (newValue) {
                        setState(() {
                          selectedStatus = newValue!;
                        });
                      },
                      items: ['Solicitado', 'Emprestado', 'Devolvido']
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      onSaved: (value) => _formData['status'] = value!,
                      decoration: const InputDecoration(
                        labelText: 'Status',
                      ),
                    ),
                  ),
                ],
              ),
//Image field
              PostPicture(
                postId: _formData['id'].toString(),
                isSelect: false,
                width: 0.5,
                height: 0.25,
              ),
//Description field
              TextFormField(
                initialValue: _formData['description'] != null
                    ? _formData['description'].toString()
                    : '',
                decoration: const InputDecoration(labelText: 'Descrição'),
                maxLines: null,
                maxLength: 200,
                onSaved: (value) => _formData['description'] = value!,
              ),
              const SizedBox(height: 20),
//Owner field
              TypeAheadField<User>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Pesquisar nome do dono (se houver)',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                suggestionsCallback: (pattern) {
                  return users.all
                      .where((user) => user.name!
                          .toLowerCase()
                          .contains(pattern.toLowerCase()))
                      .toList()
                    ..sort((a, b) =>
                        a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
                },
                itemBuilder: (context, User suggestion) {
                  return ListTile(
                    title: Text(suggestion.name.toString()),
                  );
                },
                onSuggestionSelected: (User suggestion) {
                  setState(() {
                    selectedOwner = suggestion;
                    _searchController.text = suggestion.name.toString();
                  });
                },
              ),
              const SizedBox(height: 15),
//Lending date field
              TextButton(
                onPressed: () async {
                  _selectLendingDate(context);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.pinkAccent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
                child: const Text(
                  'Selecionar Data de Empréstimo',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 6),
//Returning date field
              TextButton(
                onPressed: () async {
                  _selectReturningDate(context);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.pinkAccent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
                child: const Text(
                  'Selecionar Data de Devolução',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

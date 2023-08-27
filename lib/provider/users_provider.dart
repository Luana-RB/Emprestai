import 'dart:math';

import 'package:appteste/data/dummy_users.dart';
import 'package:appteste/models/user/user.dart';
import 'package:flutter/foundation.dart';

class UsersProvider extends ChangeNotifier {
  final Map<String, User> _items = {...dummyUsers};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(User user) {
    if (user.id == null) {
      return;
    }
    //if user is not null
    //if user already exists, it will update it
    if (user.id != null &&
        !user.id!.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
      _items.update(user.id!, (_) => user);
    }
    //if user doesn't exists yet, it will creat it
    else {
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(
          id,
          () => User(
                id: id,
                name: user.name,
                email: user.email,
                password: user.password,
                groupName: user.groupName,
                avatarUrl: user.avatarUrl,
              ));
    }
    notifyListeners();
  }

  void remove(User user) {
    if (user.id != null) {
      _items.remove(user.id);
      notifyListeners();
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/models/groups.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/services/group.dart';
import 'package:hatarakujikan_app/services/user.dart';
import 'package:location/location.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  Status _status = Status.Uninitialized;
  FirebaseAuth _auth;
  User _fUser;
  UserService _userService = UserService();
  GroupService _groupService = GroupService();
  UserModel _user;
  List<GroupModel> _groups;
  GroupModel _group;

  Status get status => _status;
  User get fUser => _fUser;
  UserModel get user => _user;
  List<GroupModel> get groups => _groups;
  GroupModel get group => _group;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rePassword = TextEditingController();
  bool isHidden = false;
  bool isReHidden = false;

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanged);
  }

  void changeHidden() {
    isHidden = !isHidden;
    notifyListeners();
  }

  void changeReHidden() {
    isReHidden = !isReHidden;
    notifyListeners();
  }

  Future<bool> signIn() async {
    if (email.text == null) return false;
    if (password.text == null) return false;
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp() async {
    if (name.text == null) return false;
    if (email.text == null) return false;
    if (password.text == null) return false;
    if (password.text != rePassword.text) return false;
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      )
          .then((value) {
        _userService.create({
          'id': value.user.uid,
          'name': name.text.trim(),
          'email': email.text.trim(),
          'password': password.text.trim(),
          'workLv': 0,
          'lastWorkId': '',
          'lastBreakId': '',
          'groups': [],
          'createdAt': DateTime.now(),
        });
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateEmail() async {
    if (name.text == null) return false;
    if (email.text == null) return false;
    try {
      await _auth.currentUser.updateEmail(email.text.trim()).then((value) {
        _userService.update({
          'id': _auth.currentUser.uid,
          'name': name.text.trim(),
          'email': email.text.trim(),
        });
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updatePassword() async {
    if (password.text == null) return false;
    if (password.text != rePassword.text) return false;
    try {
      await _auth.currentUser
          .updatePassword(password.text.trim())
          .then((value) {
        _userService.update({
          'id': _auth.currentUser.uid,
          'password': password.text.trim(),
        });
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    _user = null;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController() {
    name.text = '';
    email.text = '';
    password.text = '';
    rePassword.text = '';
  }

  Future reloadUserModel() async {
    _user = await _userService.select(userId: _fUser.uid);
    _groups = await _groupService.selectList(groups: _user.groups);
    if (_user.groups.length > 0) {
      String _groupId = '';
      for (GroupsModel _groupsModel in _user.groups) {
        if (_groupsModel.fixed == true) {
          _groupId = _groupsModel.groupId;
        }
      }
      var contain = _groups.where((e) => e.id == _groupId);
      _group = contain.first;
    }
    notifyListeners();
  }

  Future _onStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _fUser = firebaseUser;
      _status = Status.Authenticated;
      _user = await _userService.select(userId: _fUser.uid);
      _groups = await _groupService.selectList(groups: _user.groups);
      if (_user.groups.length > 0) {
        String _groupId = '';
        for (GroupsModel _groupsModel in _user.groups) {
          if (_groupsModel.fixed == true) {
            _groupId = _groupsModel.groupId;
          }
        }
        var contain = _groups.where((e) => e.id == _groupId);
        _group = contain.first;
      }
    }
    notifyListeners();
  }

  Future<bool> checkLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<List<String>> getLocation() async {
    Location location = Location();
    LocationData _locationData = await location.getLocation();
    List<String> _locations = [
      _locationData.latitude.toString(),
      _locationData.longitude.toString(),
    ];
    return _locations;
  }

  void changeGroup(GroupModel groupModel) {
    _group = groupModel;
    notifyListeners();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/services/group.dart';
import 'package:hatarakujikan_app/services/user.dart';
import 'package:location/location.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  Status _status = Status.Uninitialized;
  FirebaseAuth? _auth;
  User? _fUser;
  GroupService _groupService = GroupService();
  UserService _userService = UserService();
  List<GroupModel> _groups = [];
  GroupModel? _group;
  UserModel? _user;

  Status get status => _status;
  User? get fUser => _fUser;
  List<GroupModel> get groups => _groups;
  GroupModel? get group => _group;
  UserModel? get user => _user;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rePassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController newRePassword = TextEditingController();
  TextEditingController recordPassword = TextEditingController();
  bool isHidden = false;
  bool isReHidden = false;

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth?.authStateChanges().listen(_onStateChanged);
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
    if (email.text == '') return false;
    if (password.text == '') return false;
    String _token = await setToken();
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth!
          .signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      )
          .then((value) {
        _userService.update({
          'id': value.user?.uid,
          'token': _token,
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

  Future<bool> signUp() async {
    if (name.text == '') return false;
    if (email.text == '') return false;
    if (password.text == '') return false;
    if (password.text != rePassword.text) return false;
    String _token = await setToken();
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth!
          .createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      )
          .then((value) {
        _userService.create({
          'id': value.user?.uid,
          'number': '',
          'name': name.text.trim(),
          'email': email.text.trim(),
          'password': password.text.trim(),
          'recordPassword': '',
          'workLv': 0,
          'lastWorkId': '',
          'lastBreakId': '',
          'token': _token,
          'smartphone': true,
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
    if (name.text == '') return false;
    if (email.text == '') return false;
    try {
      await _auth?.currentUser?.updateEmail(email.text.trim()).then((value) {
        _userService.update({
          'id': _auth?.currentUser?.uid,
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
    if (password.text == '') return false;
    if (newPassword.text == '') return false;
    if (newPassword.text != newRePassword.text) return false;
    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: _auth?.currentUser?.email ?? '',
        password: password.text.trim(),
      );
      await _auth?.signInWithCredential(credential);
      await _auth?.currentUser!
          .updatePassword(newPassword.text.trim())
          .then((value) {
        _userService.update({
          'id': _auth?.currentUser?.uid,
          'password': newPassword.text.trim(),
        });
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateRecordPassword() async {
    if (recordPassword.text == '') return false;
    if (recordPassword.text.length > 8) return false;
    try {
      _userService.update({
        'id': _auth?.currentUser?.uid,
        'recordPassword': recordPassword.text.trim(),
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future delete() async {
    _userService.delete({'id': _auth?.currentUser?.uid});
    if (_groups.length > 0) {
      for (GroupModel _group in _groups) {
        List<String> _userIds = _group.userIds;
        _userIds.remove(_auth?.currentUser?.uid);
        _groupService.update({
          'id': _group.id,
          'userIds': _userIds,
        });
      }
    }
    await _auth?.currentUser?.delete();
    _status = Status.Unauthenticated;
    _user = null;
    await removePrefs('groupId');
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future signOut() async {
    await _auth!.signOut();
    _status = Status.Unauthenticated;
    _user = null;
    await removePrefs('groupId');
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController() {
    name.text = '';
    email.text = '';
    password.text = '';
    rePassword.text = '';
    newPassword.text = '';
    newRePassword.text = '';
    recordPassword.text = '';
  }

  Future reloadUser() async {
    _user = await _userService.select(id: _fUser?.uid);
    if (_user != null) {
      _groups = await _groupService.selectListUser(userId: _user?.id);
    }
    if (_groups.length > 0) {
      String? _groupId = await getPrefs('groupId');
      if (_groupId == null) {
        await setPrefs('groupId', _groups.first.id);
        var contain = _groups.where((e) => e.id == _groups.first.id);
        _group = contain.first;
      } else {
        var contain = _groups.where((e) => e.id == _groupId);
        _group = contain.first;
      }
    } else {
      _group = null;
    }
    notifyListeners();
  }

  Future _onStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _fUser = firebaseUser;
      _status = Status.Authenticated;
      await _userService.select(id: _fUser?.uid).then((value) {
        _user = value;
      });
      if (_user != null) {
        _groups = await _groupService.selectListUser(userId: _user?.id);
      }
      if (_groups.length > 0) {
        String? _groupId = await getPrefs('groupId');
        if (_groupId == null) {
          await setPrefs('groupId', _groups.first.id);
          var contain = _groups.where((e) => e.id == _groups.first.id);
          _group = contain.first;
        } else {
          var contain = _groups.where((e) => e.id == _groupId);
          _group = contain.first;
        }
      } else {
        _group = null;
      }
    }
    notifyListeners();
  }

  Future<String> setToken() async {
    String _token = '';
    Stream<String> _tokenStream;
    await FirebaseMessaging.instance.getToken().then((value) {
      _token = value ?? '';
    });
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream.listen((value) {
      _token = value;
    });
    return _token;
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

  Future<List<double>> futureLocation() async {
    List<double> _locations = [];
    bool isLocation = await checkLocation();
    if (isLocation == true) {
      List<String> _tmp = await getLocation();
      _locations = [
        double.parse(_tmp.first),
        double.parse(_tmp.last),
      ];
    }
    return _locations;
  }

  void changeGroup(GroupModel groupModel) {
    _group = groupModel;
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? streamNotice({String? userId}) {
    Stream<QuerySnapshot<Map<String, dynamic>>>? _ret;
    _ret = FirebaseFirestore.instance
        .collection('user')
        .doc(userId ?? 'error')
        .collection('notice')
        .where('read', isEqualTo: false)
        .snapshots();
    return _ret;
  }

  int tabsIndex = 0;

  void changeTabs(int index) {
    tabsIndex = index;
    notifyListeners();
  }
}

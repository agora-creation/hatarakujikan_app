class GroupsModel {
  String _groupId;
  bool fixed;

  String get groupId => _groupId;

  GroupsModel.fromMap(Map data) {
    _groupId = data['groupId'];
    fixed = data['fixed'];
  }

  Map toMap() => {
        'groupId': groupId,
        'fixed': fixed,
      };
}

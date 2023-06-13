class UserData {
  final String name;
  final String regNo;
  final String type;

  UserData({
    required this.name,
    required this.regNo,
    required this.type,
  });

  factory UserData.fromJson(Map<String, dynamic> snapshot) {
    return UserData(
        name: snapshot['name'],
        regNo: snapshot['regNo'],
        type: snapshot['type']);
  }
}

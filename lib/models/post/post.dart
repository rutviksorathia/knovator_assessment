class Post {
  String userId;
  String id;
  String title;
  String body;
  bool markAsRead;
  int time;
  bool isTimerStarted;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
    this.markAsRead = false,
    this.time = 0,
    this.isTimerStarted = false,
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      userId: map["userId"].toString(),
      id: map["id"].toString(),
      title: map["title"].toString(),
      body: map["body"].toString(),
      markAsRead: map["markAsRead"] ?? false,
      time: map["time"] ?? ([10, 20, 25]..shuffle()).first,
      isTimerStarted: map["isTimerStarted"] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "id": id,
      "title": title,
      "body": body,
      "markAsRead": markAsRead,
      "time": time,
      "isTimerStarted": isTimerStarted
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

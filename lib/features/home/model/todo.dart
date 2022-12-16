class TodoModel {
  final String? id;
  final String title;
  final String content;
  final DateTime date;
  final String userId;

  TodoModel({
    this.id,
    required this.title,
    this.content = '',
    required this.date,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'date': date.millisecondsSinceEpoch,
      'userId': userId,
    };
  }

  factory TodoModel.fromMap(String id, Map<String, dynamic> map) {
    return TodoModel(
      id: id,
      title: map['title'] as String,
      content: map['content'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      userId: map['userId'] as String,
    );
  }
}

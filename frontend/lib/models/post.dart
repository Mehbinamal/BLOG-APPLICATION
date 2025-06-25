class Post {
  final String id;
  final String title;
  final String content;
  final String author;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'].toString(),
      title: json['title'],
      content: json['content'],
      author: json['author'].toString(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
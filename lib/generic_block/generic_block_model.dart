class GenericBlockModel {
  final String blockId;
  final String title;
  final String content;

  GenericBlockModel({
    required this.blockId,
    required this.title,
    required this.content,
  });

  factory GenericBlockModel.fromJson(String blockId, Map<String, dynamic> json) {
    return GenericBlockModel(
      blockId: blockId,
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }

  GenericBlockModel copyWith({
    String? title,
    String? content,
  }) {
    return GenericBlockModel(
      blockId: blockId,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }
}

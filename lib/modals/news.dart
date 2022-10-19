class News {
  final String title;
  final String description;
  final String publishedAt;
  final String source;
  final String imageUrl;
  News(
      {required this.title,
      required this.description,
      required this.imageUrl,
      required this.publishedAt,
      required this.source});
  factory News.fromjson(Map<String, dynamic> json) {
    return News(
        title: json["title"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        publishedAt: json["publishedAt"],
        source: json["source"]);
  }

  static Map<String, dynamic> toJson(News n) => {
        'title': n.title,
        'description': n.description,
        'publishedAt': n.publishedAt,
        'source': n.source,
        'imageUrl': n.imageUrl,
      };
}

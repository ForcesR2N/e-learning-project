class Data {
  final String title;
  final String image;
  final String videoUrl;
  final String description;

  Data( {
    required this.description,
    required this.title,
    required this.image,
    required this.videoUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      title: json['title'],
      image: json['image'],
      videoUrl: json['video_url'],
      description: json['description'],
    );
  }
}

class SearchVideo {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String videoUrl;
  final DateTime publishedAt;
  final String channelId;
  final String channelTitle;

  // Constructor

  SearchVideo({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.publishedAt,
    required this.channelId,
    required this.channelTitle,
  });

  factory SearchVideo.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('id')) {
      return SearchVideo(
        id: json['id']['videoId'],
        title: json['snippet']['title'],
        description: json['snippet']['description'],
        thumbnailUrl: json['snippet']['thumbnails']['high']['url'],
        videoUrl: 'https://www.youtube.com/watch?v=${json['id']['videoId']}',
        publishedAt: DateTime.parse(json['snippet']['publishedAt']),
        channelId: json['snippet']['channelId'],
        channelTitle: json['snippet']['channelTitle'],
      );
    } else {
      return SearchVideo(
        id: json["videoId"],
        title: json['title'],
        description: json['description'],
        thumbnailUrl: json['thumbnailUrl'],
        videoUrl: json['videoUrl'],
        publishedAt: DateTime.parse(json['publishedAt']),
        channelId: json['channelId'],
        channelTitle: json['channelTitle'],
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "videoId": id,
      'title': title,
      'description': description,
      'thumbnailUrl': thumbnailUrl,
      'videoUrl': videoUrl,
      'publishedAt': publishedAt.toIso8601String(),
      'channelId': channelId,
      'channelTitle': channelTitle,
    };
  }
}

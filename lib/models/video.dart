class Video {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String videoUrl;
  final int viewCount;
  final int likeCount;
  final DateTime publishedAt;
  final String channelId;
  final String channelTitle;

  Video({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.viewCount,
    required this.likeCount,
    required this.publishedAt,
    required this.channelId,
    required this.channelTitle,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('id')) {
      return Video(
        id: json['id'],
        title: json['snippet']['title'],
        description: json['snippet']['description'],
        thumbnailUrl: json['snippet']['thumbnails']['high']['url'],
        videoUrl: 'https://www.youtube.com/watch?v=${json['id']}',
        viewCount: int.parse(json['statistics']['viewCount']),
        likeCount: int.parse(json['statistics']['likeCount']),
        publishedAt: DateTime.parse(json['snippet']['publishedAt']),
        channelId: json['snippet']['channelId'],
        channelTitle: json['snippet']['channelTitle'],
      );
    } else {
      return Video(
        // Quando iniciar o dispositivo os favoritos armazenados serão recuperados aqui
        id: json['videoId'],
        title: json['title'],
        description: json['description'],
        thumbnailUrl: json['thumbnailUrl'],
        videoUrl: json['videoUrl'],
        viewCount: json['viewCount'],
        likeCount: json['likeCount'],
        publishedAt: DateTime.parse(json['publishedAt']),
        channelId: json['channelId'],
        channelTitle: json['channelTitle'],
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'videoId':
          id, // Troca a key do id para diferenciar a recuperação a partir do dispositivo
      'title': title,
      'description': description,
      'thumbnailUrl': thumbnailUrl,
      'videoUrl': videoUrl,
      'viewCount': viewCount,
      'likeCount': likeCount,
      'publishedAt': publishedAt.toIso8601String(),
      'channelId': channelId,
      'channelTitle': channelTitle,
    };
  }
}

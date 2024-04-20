class Video {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String videoUrl;
  //final int viewCount;
  //final int likeCount;
  //final int dislikeCount;
  final DateTime publishedAt;
  final String channelId;
  final String channelTitle;
  //final String channelAvatarUrl;

  // Constructor

  Video({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.videoUrl,
    //required this.viewCount,
    //required this.likeCount,
    //required this.dislikeCount,
    required this.publishedAt,
    required this.channelId,
    required this.channelTitle,
    //required this.channelAvatarUrl,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('id')) {
      return Video(
        id: json['id']['videoId'],
        title: json['snippet']['title'],
        description: json['snippet']['description'],
        thumbnailUrl: json['snippet']['thumbnails']['high']['url'],
        videoUrl: 'https://www.youtube.com/watch?v=${json['id']['videoId']}',
        //viewCount: json['statistics']['viewCount'],
        //likeCount: json['statistics']['likeCount'],
        //dislikeCount: json['statistics']['dislikeCount'],
        publishedAt: DateTime.parse(json['snippet']['publishedAt']),
        channelId: json['snippet']['channelId'],
        channelTitle: json['snippet']['channelTitle'],
        //channelAvatarUrl: json['snippet']['thumbnails']['default']['url'],
      );
    } else {
      return Video(
        id: json["videoId"],
        title: json['title'],
        description: json['description'],
        thumbnailUrl: json['thumbnailUrl'],
        videoUrl: json['videoUrl'],
        //viewCount: json['viewCount'],
        //likeCount: json['likeCount'],
        //dislikeCount: json['dislikeCount'],
        publishedAt: DateTime.parse(json['publishedAt']),
        channelId: json['channelId'],
        channelTitle: json['channelTitle'],
        //channelAvatarUrl: json['channelAvatarUrl'],
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
      //'viewCount': viewCount,
      //'likeCount': likeCount,
      //'dislikeCount': dislikeCount,
      'publishedAt': publishedAt.toIso8601String(),
      'channelId': channelId,
      'channelTitle': channelTitle,
      //'channelAvatarUrl': channelAvatarUrl,
    };
  }
}

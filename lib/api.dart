import 'dart:convert';

import 'package:fav_youtube_with_bloc/models/video.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final API_KEY = dotenv.env['API_KEY'];

class Api {
  String _search = "";
  String _nextToken = "";

  search(String search) async {
    _search = search;
    http.Response response = await http.get(Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"));

    return decode(response);
  }

  nextPage() async {
    http.Response response = await http.get(Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"));

    return decode(response);
  }

  List<Video> decode(http.Response response) {
    if (response.statusCode == 200) {
      _nextToken = json.decode(response.body)['nextPageToken'];
      var decoded = json.decode(response.body);
      print(decoded);
      List<Video> videos = decoded["items"].map<Video>((map) {
        return Video.fromJson(map);
      }).toList();
      print(videos);
      return videos;
    } else {
      throw Exception('Failed to search');
    }
  }

  videoInfo(String videoId) async {
    http.Response response = await http.get(Uri.parse(
        "https://www.googleapis.com/youtube/v3/videos?id=${videoId}&key=$API_KEY&part=snippet,contentDetails,statistics,status"));

    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      return decoded["items"];
    } else {
      throw Exception('Failed to search');
    }
  }

  channelInfo(String channelId) async {
    http.Response response = await http.get(Uri.parse(
        'https://www.googleapis.com/youtube/v3/channels?id=${channelId}&key=$API_KEY&part=snippet'));

    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      return decoded["items"];
    } else {
      throw Exception('Failed to search');
    }
  }
}

/*
"https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"
"http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json"
*/
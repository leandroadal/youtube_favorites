import 'dart:convert';

import 'package:fav_youtube_with_bloc/models/search.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'models/video.dart';

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

  List<SearchVideo> decode(http.Response response) {
    if (response.statusCode == 200) {
      _nextToken = json.decode(response.body)['nextPageToken'];
      var decoded = json.decode(response.body);
      print(decoded);
      List<SearchVideo> videos = decoded["items"].map<SearchVideo>((map) {
        return SearchVideo.fromJson(map);
      }).toList();
      print(videos);
      return videos;
    } else {
      throw Exception('Failed to search');
    }
  }

  Future<Video> videoInfo(String videoId) async {
    http.Response response = await http.get(Uri.parse(
        "https://www.googleapis.com/youtube/v3/videos?id=${videoId}&key=$API_KEY&part=snippet,contentDetails,statistics,status"));

    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      return Video.fromJson(decoded["items"][0]);
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

import 'dart:convert';
import 'dart:developer';

import 'package:flutter_final_project/common/utils.dart';
import 'package:flutter_final_project/models/movie_detailed.dart';
import 'package:flutter_final_project/models/movierecommendation.dart';
import 'package:flutter_final_project/models/search_movie.dart';
import 'package:flutter_final_project/models/tv_series.dart';
import 'package:flutter_final_project/models/upcoming.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://api.themoviedb.org/3/";
var key = "?api_key = $apikey";
late String endPoint;

class ApiService {
  Future<Upcoming> getUpcomingMovie() async {
    endPoint =
        "movie/upcoming?api_key=3106a9dd73840348d290e1bff5d0d499&language=zh-TW";
    final url = "$baseUrl$endPoint";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Success");

      return Upcoming.fromJson(jsonDecode(response.body));
    }
    throw Exception("無法載入即將上映的電影");
  }

  Future<Upcoming> getNowplayingMovie() async {
    endPoint =
        "movie/now_playing?api_key=3106a9dd73840348d290e1bff5d0d499&language=zh-TW";
    final url = "$baseUrl$endPoint";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Success");

      return Upcoming.fromJson(jsonDecode(response.body));
    }
    throw Exception("無法載入正在上映的電影");
  }

  Future<TopRated> getTopratedMovie() async {
    endPoint =
        "tv/top_rated?api_key=3106a9dd73840348d290e1bff5d0d499&language=zh-TW";
    final url = "$baseUrl$endPoint";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Success");

      return TopRated.fromJson(jsonDecode(response.body));
    }
    throw Exception("無法載入熱門上映的電影");
  }

  Future<SearchMovie> getSearchMovie(String searchText) async {
    endPoint = "search/movie?query=$searchText";
    final url = "$baseUrl$endPoint";
    print("search url is $url");
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization':
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMTA2YTlkZDczODQwMzQ4ZDI5MGUxYmZmNWQwZDQ5OSIsInN1YiI6IjY2NDllZDhmOTUwMTUxOWM5ZDFkODFmMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.J9x9lh55I0qxeU5CzTO2rVTNbm6AdrNSFKH-aWBcWCk"
    });

    if (response.statusCode == 200) {
      log("Success");

      return SearchMovie.fromJson(jsonDecode(response.body));
    }
    throw Exception("無法載入搜尋的電影");
  }

  Future<MovieRecommendation> getPopularMovie() async {
    endPoint =
        "movie/popular?api_key=3106a9dd73840348d290e1bff5d0d499&language=zh-TW";
    final url = "$baseUrl$endPoint";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Success");

      return MovieRecommendation.fromJson(jsonDecode(response.body));
    }
    throw Exception("無法載入受歡迎的電影");
  }

  Future<MovieDetailed> getDetailedMovie(int movieId) async {
    endPoint =
        "movie/$movieId?api_key=3106a9dd73840348d290e1bff5d0d499&language=zh-TW";
    final url = "$baseUrl$endPoint";
    print("search url is $url");

    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      log("Success");

      return MovieDetailed.fromJson(jsonDecode(response.body));
    }
    throw Exception("無法載入電影詳情");
  }

  Future<MovieRecommendation> getRecommendationMovie(int movieId) async {
    final endPoint = 'movie/$movieId/recommendations';
    final url =
        '$baseUrl$endPoint?api_key=3106a9dd73840348d290e1bff5d0d499&language=zh-TW';
    print("recommendation url is $url");

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        log("Success");
        return MovieRecommendation.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("無法載入推薦的電影 Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("無法載入推薦的電影 錯誤: $e");
    }
  }
}

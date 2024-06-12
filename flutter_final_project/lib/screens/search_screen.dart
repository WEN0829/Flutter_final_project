// ignore_for_file: unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_project/common/utils.dart';
import 'package:flutter_final_project/models/movierecommendation.dart';
import 'package:flutter_final_project/models/search_movie.dart';
import 'package:flutter_final_project/screens/movie_detailed_screen.dart';
import 'package:flutter_final_project/services/api_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchcontroller = TextEditingController();
  ApiService apiService = ApiService();
  SearchMovie? searchMovie;
  late Future<MovieRecommendation> popularMovie;

  void search(String query) {
    apiService.getSearchMovie(query).then((results) {
      setState(() {
        searchMovie = results;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    popularMovie = apiService.getPopularMovie();
  }

  @override
  void dispose() {
    searchcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(
              const Duration(seconds: 1),
            );
            if (searchcontroller.text.isEmpty) {
              setState(() {
                popularMovie = apiService.getPopularMovie();
              });
            } else {
              search(searchcontroller.text);
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CupertinoSearchTextField(
                    controller: searchcontroller,
                    placeholder: '搜尋節目、電影......',
                    padding: const EdgeInsets.all(10.0),
                    prefixIcon: const Icon(
                      CupertinoIcons.search,
                      size: 22,
                      color: Colors.grey,
                    ),
                    suffixIcon: const Icon(
                      Icons.cancel,
                      color: Colors.grey,
                    ),
                    style: const TextStyle(color: Colors.white),
                    backgroundColor: Colors.grey.withOpacity(0.3),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(
                          () {
                            searchMovie = null;
                            popularMovie = apiService.getPopularMovie();
                          },
                        );
                      } else {
                        search(searchcontroller.text);
                      }
                    },
                  ),
                ),
                searchcontroller.text.isEmpty
                    ? FutureBuilder(
                        future: popularMovie,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data?.results;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "  節目與電影推薦 ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                ListView.builder(
                                  itemCount: data!.length,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MovieDetailScreen(
                                              movieId: data[index].id,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 150,
                                        margin: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.network(
                                                "$imageurl${data[index].posterPath}"),
                                            const SizedBox(width: 15),
                                            Expanded(
                                              child: Text(
                                                data[index].title,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const Icon(
                                              Icons.play_circle_outline,
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      )
                    : searchMovie == null
                        ? const SizedBox.shrink()
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: searchMovie?.results.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 5,
                                    childAspectRatio: 1.2 / 2),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetailScreen(
                                          movieId:
                                              searchMovie!.results[index].id),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    searchMovie!.results[index].backdropPath ==
                                            null
                                        ? Image.asset(
                                            "assets/netflix.png",
                                            height: 170,
                                          )
                                        : CachedNetworkImage(
                                            imageUrl:
                                                "$imageurl${searchMovie!.results[index].backdropPath}",
                                            height: 170,
                                          ),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        searchMovie!
                                            .results[index].originalTitle,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

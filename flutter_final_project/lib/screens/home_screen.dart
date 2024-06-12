import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_project/common/utils.dart';
import 'package:flutter_final_project/models/tv_series.dart';
import 'package:flutter_final_project/models/upcoming.dart';
import 'package:flutter_final_project/screens/search_screen.dart';
import 'package:flutter_final_project/services/api_service.dart';
import 'package:flutter_final_project/widgets/custom.dart';
import 'package:flutter_final_project/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Upcoming> upcomingmovies;
  late Future<Upcoming> nowplayingmovies;
  late Future<TopRated> topratedmovies;

  ApiService apiservice = ApiService();
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    setState(() {
      upcomingmovies = apiservice.getUpcomingMovie();
      nowplayingmovies = apiservice.getNowplayingMovie();
      topratedmovies = apiservice.getTopratedMovie();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundcolor,
        title: Image.asset(
          "assets/logo.png",
          height: 50,
          width: 120,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.cast,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  ),
                );
              },
              child: const Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(
            const Duration(seconds: 1),
          );
          _refreshData();
        },
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
          itemCount: 3,
          itemBuilder: (context, index) {
            if (index == 0) {
              return FutureBuilder(
                future: topratedmovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Custom(data: snapshot.data!);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              );
            } else if (index == 1) {
              return SizedBox(
                height: 220,
                child: MovieCard(
                  future: upcomingmovies,
                  headLineText: "即將上映",
                ),
              );
            } else {
              return SizedBox(
                height: 220,
                child: MovieCard(
                  future: nowplayingmovies,
                  headLineText: "現正熱映中",
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

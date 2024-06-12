import 'package:flutter/material.dart';
import 'package:flutter_final_project/screens/home_screen.dart';
import 'package:flutter_final_project/screens/more_screen.dart';
import 'package:flutter_final_project/screens/search_screen.dart';

class BottomNavigatorBar extends StatelessWidget {
  const BottomNavigatorBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: const Color.fromARGB(255, 29, 28, 28),
          height: 55,
          child: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: "首頁",
                iconMargin: EdgeInsets.only(bottom: 1.0),
              ),
              Tab(
                icon: Icon(Icons.search),
                text: "搜尋",
                iconMargin: EdgeInsets.only(bottom: 1.0),
              ),
              Tab(
                icon: Icon(Icons.video_library_outlined),
                text: "熱播新片",
                iconMargin: EdgeInsets.only(bottom: 1.0),
              ),
            ],
            indicatorColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: Color(0xff999999),
          ),
        ),
        body: const TabBarView(
          children: [
            HomeScreen(),
            SearchScreen(),
            MoreScreen(),
          ],
        ),
      ),
    );
  }
}

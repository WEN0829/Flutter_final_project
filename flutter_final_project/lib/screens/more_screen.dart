import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_final_project/screens/search_screen.dart';
import 'package:flutter_final_project/widgets/coming_soon.dart';
import 'package:flutter_final_project/widgets/watching_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black,
            title: const Text(
              "熱播新片",
              style: TextStyle(
                color: Colors.white,
              ),
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
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ),
                      );
                    }
                  },
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
            bottom: TabBar(
              dividerColor: Colors.black,
              isScrollable: false,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                  border: Border.all(width: 5)),
              labelColor: Colors.black,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              unselectedLabelColor: Colors.white,
              tabs: const [
                Tab(
                  text: "     🍿 即將上線        ",
                ),
                Tab(
                  text: "     🔥 大家都在看      ",
                )
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    ComingSoonMovie(
                      imageUrl:
                          'https://miro.medium.com/v2/resize:fit:1024/1*P_YU8dGinbCy6GHlgq5OQA.jpeg',
                      overview:
                          '鎮上一名小男孩不知去向後，謎樣的秘密實驗、恐怖的超自然力量，以及一位詭異的小女孩，也跟著浮出檯面。',
                      logoUrl: AssetImage('assets/1.jpg'),
                      month: "6",
                      day: "19",
                      title: "怪奇物語",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ComingSoonMovie(
                      imageUrl:
                          'https://www.pinkvilla.com/images/2022-09/rrr-review.jpg',
                      overview:
                          '這部恢弘鉅作以獨立前的印度為背景，描述一名無畏戰士展開危險任務，與效力英方的鐵血警察展開交鋒。',
                      logoUrl: AssetImage('assets/2.jpg'),
                      month: "6",
                      day: "07",
                      title: "R R R",
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    WatchingMovie(
                      imageUrl:
                          'http://pic8.iqiyipic.com/image/20240425/3d/51/a_100572068_m_601_zh-TW_m1_720_405.webp',
                      overview: '緊繃的婚姻關係、每況愈下的生意和世代差異，且看這間傳統糕餅店的一家人如何應對。',
                      logoUrl: AssetImage(
                        'assets/images.png',
                      ),
                      month: "6",
                      day: "07",
                      title: "我的婆婆怎麼這麼可愛",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    WatchingMovie(
                      imageUrl:
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlbrGKIeZc70uBglKwULHv6gNhhhfwo11ohw&s',
                      overview:
                          '八個人參加一檔誘人又危險的節目，被困在一座 8 層樓的神秘建築中，撐得越久，最後到手的獎金也越豐厚。',
                      logoUrl: AssetImage('assets/3.jpg'),
                      month: "6",
                      day: "07",
                      title: "The 8 Show",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

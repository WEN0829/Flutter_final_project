import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_final_project/common/utils.dart';
import 'package:flutter_final_project/models/tv_series.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Custom extends StatelessWidget {
  final TopRated data;
  const Custom({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
      child: CarouselSlider.builder(
        itemCount: data.results.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          var url = data.results[index].backdropPath.toString();

          return GestureDetector(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                CachedNetworkImage(
                  imageUrl: "$imageurl$url",
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  data.results[index].name,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
        options: CarouselOptions(
          height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
          aspectRatio: 16 / 9,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
          initialPage: 0,
        ),
      ),
    );
  }
}

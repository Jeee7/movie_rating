import 'package:flutter/material.dart';
import 'package:movie_rating/const/divider.dart';
import 'package:shimmer/shimmer.dart';

class MovieCard extends StatelessWidget {
  final String? title;
  final String? imageUrl;
  final bool isLoading;

  const MovieCard({
    this.title,
    this.imageUrl,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        width: 140,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade800,
          highlightColor: Colors.grey.shade600,
          period: const Duration(milliseconds: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              // const SizedBox(height: 8),
              // Container(
              //   height: 16,
              //   width: 100,
              //   color: Colors.grey,
              // ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: 140,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl!,
              height: 200,
              width: 140,
              fit: BoxFit.fill,
            ),
          ),
          // gapHeight(8),
          // Text(
          //   title!,
          //   maxLines: 2,
          //   overflow: TextOverflow.ellipsis,
          //   style: Theme.of(context).textTheme.bodyMedium,
          // ),
        ],
      ),
    );
  }
}

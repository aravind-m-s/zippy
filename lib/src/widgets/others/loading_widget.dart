import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: Colors.grey,
        highlightColor: Colors.grey.shade400,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Field Label Widget"),
            Skeleton.leaf(
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width - 48,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Field Label Widget"),
            Skeleton.leaf(
              child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 48,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
            const SizedBox(height: 16),
            const Text("Field Label Widget"),
            Skeleton.leaf(
              child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 48,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
            const SizedBox(height: 16),
            const Text("Field Label Widget"),
            Skeleton.leaf(
              child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 48,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

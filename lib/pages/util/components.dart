import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:luca_ui/pages/util/fullscreen.dart';
import 'package:luca_ui/pages/util/location_list.dart';
import 'package:luca_ui/pages/util/walls_category.dart';

class Components {
  static Widget buildImageWidget(String imageUrl) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullScreenImagePage(imageUrl: imageUrl),
            ),
          );
        },
        child: Hero(
          tag: imageUrl,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LocationListItem(
                imageUrl: imageUrl,
                scrollController: scrollController,
              ),
            ),
          ),
        ),
      );
    });
  }

  static Widget buildPlaceholder() {
    return Builder(builder: (context) {
      return Center(
        child: LoadingAnimationWidget.newtonCradle(
          size: 35,
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    });
  }

  static Widget buildErrorWidget() {
    return Container(
      color: Colors.transparent,
      child: const Icon(
        Icons.error,
        color: Colors.red,
      ),
    );
  }

  static Widget buildCircularIndicator() {
    return Builder(builder: (context) {
      return Center(
        child: LoadingAnimationWidget.fallingDot(
          size: 35,
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    });
  }
}

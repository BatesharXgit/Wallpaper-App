import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

class Category extends StatefulWidget {
  const Category({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Category> createState() => CategoryState();
}

class CategoryState extends State<Category> {
  final List<String> categories = [
    'Cityscapes',
    'Landscapes',
    'Amoled',
    'Space',
    'Stock',
    'Minimalist',
    'Nature',
    'Animals',
    'Sci-Fi',
    'Games',
  ];

  final List<String> recommendImages = [
    'https://i.pinimg.com/236x/fb/bc/86/fbbc8631cb2b794a97dcc055332bf62c.jpg',
    'https://i.pinimg.com/236x/ea/e3/2e/eae32e059a98fa742366e91876d4094f.jpg',
    'https://i.pinimg.com/236x/28/76/53/2876533599b7cefd228c103a56dbd3e2.jpg',
    'https://i.pinimg.com/236x/95/b5/13/95b51303c4140ebb54bafb8860acc7f3.jpg',
    'https://i.pinimg.com/236x/8c/24/7f/8c247fbf0059d5877645138543a0cc71.jpg',
    'https://i.pinimg.com/236x/ab/e5/ec/abe5ec30eee55c49bb31df37d10607bb.jpg',
    'https://i.pinimg.com/236x/01/3e/36/013e361d223ad9f02827ca29f3a5d07c.jpg',
    'https://i.pinimg.com/236x/29/66/c5/2966c557738e04a34d01ec0965459746.jpg',
    'https://i.pinimg.com/236x/91/d0/9c/91d09c8624697f7931b4edbcd5fb4891.jpg',
    'https://i.pinimg.com/236x/91/d0/9c/91d09c8624697f7931b4edbcd5fb4891.jpg',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.background;
    Color primaryColor = Theme.of(context).colorScheme.primary;
    // Color secondaryColor = Theme.of(context).colorScheme.secondary;
    // Color tertiaryColor = Theme.of(context).colorScheme.tertiary;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: Text(
          'Categories',
          style: GoogleFonts.orbitron(
            color: primaryColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 180,
              child: ListView.builder(
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(recommendImages[index]),
                                fit: BoxFit.cover),
                            color: Colors.black),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

// void _navigateToCategoryPage(String category) {
//   switch (category) {
//     case 'Morning':
//       Get.to(MorningPage(), transition: Transition.leftToRightWithFade);
//       break;
//     case 'Night':
//       Get.to(NightPage(), transition: Transition.rightToLeftWithFade);
//       break;
//     case 'Birthday':
//       Get.to(BirthdayPage(), transition: Transition.leftToRightWithFade);
//       break;
//     case 'Inspirational':
//       Get.to(MorningPage(), transition: Transition.rightToLeftWithFade);
//       break;
//     case 'Religion':
//       Get.to(ReligionPage(), transition: Transition.leftToRightWithFade);
//       break;
//     case 'Avengers':
//       Get.to(const AvengersPage(), transition: Transition.cupertino);
//       break;
//     // case 'Leadership':
//     //   Get.to(const LeadershipPage(), transition: Transition.cupertino);
//     //   break;
//     // case 'Happiness':
//     //   Get.to(const HappinessPage(), transition: Transition.cupertino);
//     //   break;
//     // case 'Movies':
//     //   Get.to(const MoviesPage(), transition: Transition.cupertino);
//     //   break;
//     // case 'Hindi':
//     //   Get.to(const HindiPage(), transition: Transition.cupertino);
//     //   break;
//     // case 'Best Wishes':
//     //   Get.to(const BestWishesPage(), transition: Transition.cupertino);
//     //   break;
//     // case 'Future':
//     //   Get.to(const FuturePage(), transition: Transition.cupertino);
//     //   break;
//     // case 'Friendship':
//     //   Get.to(const FriendshipPage(), transition: Transition.cupertino);
//     //   break;
//     // case 'Sports':
//     //   Get.to(const SportsPage(), transition: Transition.cupertino);
//     //   break;
//     // case 'Technology':
//     //   Get.to(const TechnologyPage(), transition: Transition.cupertino);
//     //   break;
//     // case 'Humor':
//     //   Get.to(const HumorPage(), transition: Transition.cupertino);
//     //   break;
//     // case 'Dreams':
//     //   Get.to(const DreamsPage(), transition: Transition.cupertino);
//     //   break;
//     // case 'Success':
//     //   Get.to(const SuccessPage(), transition: Transition.cupertino);
//     //   break;
//     // case 'Motivational':
//     //   Get.to(const MotivationalPage(), transition: Transition.cupertino);
//     //   break;
//     // case 'Strength':
//     //   Get.to(const StrengthPage(), transition: Transition.cupertino);
//     //   break;
//     default:
//       break;
//   }
// }

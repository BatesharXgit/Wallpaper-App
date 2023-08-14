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
    'AI',
    'Movies',
    'Superheroes',
    'Space',
    'Sports',
    'Stock',
    'Minimalist',
    'Fantasy',
  ];

  final List<String> images = [
    'assets/images/car.png', // nature
    'assets/images/car.png', // abstract
    'assets/images/car.png', //cars
    'assets/images/car.png', // Illustrations
    'assets/images/car.png', //animals
    'assets/images/car.png', // Sci-Fi
    'assets/images/car.png', //Animation
    'assets/images/car.png', //Games
  ];

  final List<String> numbers = [
    'Nature',
    'Abstract',
    'Cars',
    'Illustrations',
    'Animals',
    'Sci-Fi',
    'Animation',
    'Games',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: AnimationLimiter(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const SizedBox(width: 20),
                  Text(
                    'Category',
                    style: GoogleFonts.orbitron(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 2),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Stack(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.50,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                        width: 0.2, color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width *
                                        0.55,
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 24, 24, 24),
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -30,
                                  left: 10,
                                  right: 10,
                                  child: Image.asset(images[index]),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  right: 10,
                                  child: Text(
                                    numbers[index],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const SizedBox(width: 20),
                  Text(
                    'Recommend',
                    style: GoogleFonts.orbitron(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 2),
              Expanded(
                child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: GestureDetector(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  decoration: BoxDecoration(
                                    color: Color(0xB700FF00),
                                    border: Border.all(
                                        width: 0.2, color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xB700FF00)
                                            .withOpacity(0.1),
                                        blurRadius: 6,
                                        offset: const Offset(1, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          categories[index],
                                          style: GoogleFonts.kanit(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                    ],
                                  ),
                                ),
                                // onTap: () => _navigateToCategoryPage(category1),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
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

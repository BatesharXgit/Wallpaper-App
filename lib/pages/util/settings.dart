import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart'; // Add this line

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _clearCache(BuildContext context) async {
    await DefaultCacheManager().emptyCache(); // Clear the cache
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color(0xFF1E1E2A),
        content: Text('Cache cleared successfully 😊',
            style: GoogleFonts.kanit(color: Colors.white)),
        duration: Duration(seconds: 3), // Adjust the duration as needed
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
          style: GoogleFonts.orbitron(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Color(0xFF131321),
      ),
      backgroundColor: Color(0xFF131321),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: AnimationLimiter(
          child: Center(
            child: Column(
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 375),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  SizedBox(height: 20),
                  Text(
                    'LUCA',
                    style: TextStyle(
                      fontFamily: 'Anurati',
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                  Text(
                    'Harmonize Your Experience!',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: 300,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Color(0xFF1E1E2A),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.info_outline),
                          title: const Text('About'),
                          subtitle: Text('Find out more about Luca',
                              style: TextStyle(color: Colors.grey)),
                          iconColor: Colors.white,
                          textColor: Colors.white,
                          onTap: () {
                            _showAboutAppBottomSheet(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.list_outlined),
                          title: const Text('Changelog'),
                          subtitle: Text('Recent improvements and fixes',
                              style: TextStyle(color: Colors.grey)),
                          iconColor: Colors.white,
                          textColor: Colors.white,
                          onTap: () {
                            _showChangelogBottomSheet(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.delete_outline),
                          title: const Text('Clear Cache'),
                          subtitle: Text('Clear all cached data',
                              style: TextStyle(color: Colors.grey)),
                          iconColor: Colors.white,
                          textColor: Colors.white,
                          onTap: () {
                            _clearCache(
                                context); // Call the function to clear cache and show snackbar
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: 300,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Color(0xFF1E1E2A),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.workspace_premium_outlined),
                          title: const Text('Liscenses'),
                          subtitle: Text('View open source liscenses',
                              style: TextStyle(color: Colors.grey)),
                          iconColor: Colors.white,
                          textColor: Colors.white,
                          onTap: () {
                            showLicensePage(
                                context: context); // Show the licenses page
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.policy_outlined),
                          title: const Text('Privacy Policy'),
                          subtitle: Text('Luca privacy policy',
                              style: TextStyle(color: Colors.grey)),
                          iconColor: Colors.white,
                          textColor: Colors.white,
                          onTap: () {
                            // Handle App Information menu item tap
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: 300,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Color(0xFF1E1E2A),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.logout_outlined),
                          title: const Text('Logout'),
                          subtitle: Text('Logout of your account',
                              style: TextStyle(color: Colors.grey)),
                          iconColor: Colors.white,
                          textColor: Colors.white,
                          onTap: () {
                            // Handle Share and Feedback menu item tap
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.delete_outline),
                          title: const Text('Delete Account'),
                          subtitle: Text('Warning! This cannot be undone',
                              style: TextStyle(color: Colors.grey)),
                          iconColor: Colors.red,
                          textColor: Colors.white,
                          onTap: () {
                            // Handle App Information menu item tap
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    color: Colors.transparent,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showAboutAppBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          color: Color(0xFF1E1E2A),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'About the App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '🌟 Immerse yourself in the world of Luca – the ultimate wallpaper app. Discover an extensive selection of static and dynamic wallpapers across various categories, all presented through a beautifully designed and intuitive interface. Elevate your device\'s aesthetic with Luca\'s stunning visuals that cater to every mood and style. 🎨📱',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Version: 1.0.0',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

void _showChangelogBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Container(
        color: Color(0xFF1E1E2A),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '🚀 Luca Initial Release Changelog',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ChangelogEntry(
              version: '1.0.0',
              date: 'October, 2023',
              changes: [
                '🎉 Welcome to the world of Luca - Your Ultimate Wallpaper Experience!',
                '🖼️ Explore a captivating collection of dynamic and static wallpapers.',
                '🎨 Immerse yourself in the beautifully designed user interface for seamless browsing.',
              ],
            ),
          ],
        ),
      );
    },
  );
}

class ChangelogEntry extends StatelessWidget {
  final String version;
  final String date;
  final List<String> changes;

  ChangelogEntry({
    required this.version,
    required this.date,
    required this.changes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Version $version',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Released on $date',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: changes.map((change) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('•', style: TextStyle(color: Colors.white, fontSize: 18)),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    change,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}

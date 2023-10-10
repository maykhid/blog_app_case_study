import 'package:blog_app_case_study/app/features/posts/ui/views/screen/home_screen.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget getViewForIndex(int index) {
      switch (index) {
        case 0:
          return const HomeScreen();
        // case 1:
        //   return const BookmarkScreen();
        default:
          return const HomeScreen();
      }
    }

    void setCurrentTabTo({required int newTabIndex}) {
      setState(() {
        currentTabIndex = newTabIndex;
      });
    }

    return Scaffold(
      // backgroundColor: ImpactlyAppColors.backgroundColor,
      body: getViewForIndex(currentTabIndex),
      // extendBodyBehindAppBar: true,
      // extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 10,
        unselectedFontSize: 10,
        iconSize: 30,
        unselectedItemColor: Colors.black.withOpacity(0.4),
        selectedLabelStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.grey.withOpacity(0.1),
          fontWeight: FontWeight.w400,
        ),
        // iconSize: 15,
        type: BottomNavigationBarType.fixed,
        onTap: (newTab) => setCurrentTabTo(newTabIndex: newTab),
        backgroundColor: Colors.teal,
        currentIndex: currentTabIndex,
        items: <BottomNavigationBarItem>[
          // dashboard
          BottomNavigationBarItem(
            icon: BottomItemIcon(
              color: currentTabIndex == 0 ? Colors.blue : Colors.white,
              icon: Icons.home,
            ),
            label: 'Posts',
          ),

          // book mark
          BottomNavigationBarItem(
            icon: BottomItemIcon(
              color: currentTabIndex == 1 ? Colors.blue : Colors.white,
              icon: Icons.bookmark,
            ),
            label: 'Bookmarks',
          ),
        ],
        selectedItemColor: Colors.white,
      ),
    );
  }
}

class BottomItemIcon extends StatelessWidget {
  const BottomItemIcon(
      {Key? key, required this.color, required this.icon, this.height = 18})
      : super(key: key);

  final Color color;
  final double height;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7.0),
      child: SizedBox(
          height: height,
          // padding: const EdgeInsets.only(bottom: 5),
          child: Icon(icon)),
    );
  }
}
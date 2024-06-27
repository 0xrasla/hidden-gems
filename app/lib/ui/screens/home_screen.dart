import 'package:app/ui/screens/main_screen.dart';
import 'package:app/ui/screens/map_screen.dart';
import 'package:app/ui/screens/trending_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/ri.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> screens = [
    MainScreen(),
    MapScreen(),
    TrendingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: screens.elementAt(_selectedIndex),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.black,
                  child: BottomNavigationBar(
                    enableFeedback: false,
                    type: BottomNavigationBarType.fixed,
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: InkWell(
                          onTap: () => _onItemTapped(0),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _selectedIndex == 0
                                  ? Colors.white
                                  : Colors.transparent,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Iconify(
                              Ri.home_2_line,
                              color: _selectedIndex == 0
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: InkWell(
                          onTap: () => _onItemTapped(1),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _selectedIndex == 1
                                  ? Colors.white
                                  : Colors.transparent,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Iconify(
                              Ri.map_2_line,
                              color: _selectedIndex == 1
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        label: 'Map',
                      ),
                      BottomNavigationBarItem(
                        icon: InkWell(
                          onTap: () => _onItemTapped(2),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _selectedIndex == 2
                                  ? Colors.white
                                  : Colors.transparent,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Iconify(
                              Ph.fire_bold,
                              color: _selectedIndex == 2
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        label: 'Trending',
                      ),
                    ],
                    currentIndex: _selectedIndex,
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.grey,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    onTap: _onItemTapped,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

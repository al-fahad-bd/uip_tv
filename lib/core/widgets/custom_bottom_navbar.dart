import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uip_tv/core/theme/theme_class.dart';
import 'package:uip_tv/presentation/screens/post_screen.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black),
          color: ThemeClass.primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(
              icon: Icons.home_filled,
              isSelected: _selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            NavItem(
              icon: Icons.desktop_windows_rounded,
              isSelected: _selectedIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
            NavItem(
              icon: Icons.file_download,
              isSelected: _selectedIndex == 2,
              onTap:
                  () => context.pushNamed(
                    PostScreen.routeName,
                  ), // Use Go Router to navigate
            ),
            NavItem(
              icon: Icons.person_outline,
              isSelected: _selectedIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: isSelected ? Colors.redAccent : Colors.grey,
        size: 28,
      ),
    );
  }
}

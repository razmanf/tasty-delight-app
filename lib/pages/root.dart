import 'package:flutter/material.dart';
import 'package:food_app/theme/color.dart';
import 'package:food_app/widgets/BackgroundWrapper.dart';
import 'package:food_app/widgets/bottombar_item.dart';
import '../providers/user_provider.dart';
import 'home.dart';
import 'cart_page.dart';
import 'profile_page.dart';
import 'notifications_page.dart';
import 'favourites_page.dart';
import 'package:provider/provider.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int _activeTab = 0;

  List<IconData> _tapIcons = [
    Icons.home_rounded,
    Icons.favorite,
    Icons.shopping_cart_rounded,
    Icons.notifications,
    Icons.person_rounded
  ];

  // Updated _pages list with Provider
  List<Widget> get _pages => [
    Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        return BackgroundWrapper(
          child: HomePage(
            firstName: userProvider.firstName,
            lastName: userProvider.lastName,
          ),
        );
      },
    ),
    BackgroundWrapper(child: const FavouritesPage()),
    BackgroundWrapper(child: const CartPage()),
    BackgroundWrapper(child: const NotificationsPage()),
    BackgroundWrapper(child: const ProfilePage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      bottomNavigationBar: _buildBottomBar(),
      body: _buildBarPage(),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      height: 75,
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: bottomBarColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withValues(),
            blurRadius: .5,
            spreadRadius: .5,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          _tapIcons.length,
          (index) => BottomBarItem(
            _tapIcons[index],
            isActive: _activeTab == index,
            activeColor: shadowColor,
            onTap: () {
              setState(() {
                _activeTab = index;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBarPage() {
    return IndexedStack(
      index: _activeTab,
      children: List.generate(
        _tapIcons.length,
        (index) => _pages[index],
      ),

    );
  }
}

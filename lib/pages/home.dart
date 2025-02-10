import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/pages/login_signup.dart';
import 'package:food_app/pages/notifications_page.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:food_app/theme/color.dart';
import 'package:food_app/utils/data.dart';
import 'package:food_app/widgets/category_item.dart';
import 'package:food_app/widgets/custom_textbox.dart';
import 'package:food_app/widgets/notification_box.dart';
import 'package:food_app/widgets/popular_item.dart';
import 'package:food_app/pages/meal_detail.dart';
import 'package:food_app/widgets/feature_item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final String firstName;
  final String lastName;

  const HomePage({
    Key? key,
    required this.firstName, // Required parameter
    required this.lastName, // Required parameter
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out? This will terminate the current session and all previous details will be lost.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<UserProvider>(context, listen: false).logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginSignup()),
                  (route) => false,
                );// Add any session termination logic here
              },
              child:
                  const Text('Log Out', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  // Widget _buildDrawer() {
  //   return Drawer(
  //     child: ListView(
  //       padding: EdgeInsets.zero,
  //       children: [
  //         const DrawerHeader(
  //           decoration: BoxDecoration(color: primary),
  //           child: Text('Menu', style: TextStyle(color: Colors.white)),
  //         ),
  //         ListTile(
  //           leading: const Icon(Icons.person),
  //           title: const Text('Profile'),
  //           onTap: () {
  //             Navigator.pop(context);
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(builder: (context) => const ProfilePage()),
  //             );
  //           },
  //         ),
  //         // Add more drawer items as needed
  //       ],
  //     ),
  //   );
  // }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text("Welcome, ${widget.firstName} ${widget.lastName}!"),
              // child: IconButton(
              //   icon: const Icon(Icons.clear_all_rounded, size: 28),
              //   onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout, size: 28),
            onPressed: () => _logout(context),
          ),
        ],
      ),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: const Text(
              "Find Your Meals",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildSearch(),
          const SizedBox(
            height: 25,
          ),
          _buildAdsImage(),
          const SizedBox(
            height: 25,
          ),
          _buildCategories(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "See all",
                  style: TextStyle(fontSize: 14, color: darker),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          _buildPopulars(),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              "Featured",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: _buildFeatured(),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  _buildSearch() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: CustomTextBox(
        hint: "Search",
        prefix: Icon(Icons.search, color: darker),
        suffix: Icon(
          Icons.filter_list_outlined,
          color: primary,
        ),
      ),
    );
  }

  _buildAdsImage() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            "https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fHByb2ZpbGV8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
          ),
        ),
      ),
    );
  }

  _buildCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(bottom: 5, left: 15),
      child: Row(
        children: [
          CategoryItem(
            data: {
              "name": "All",
              "icon": FontAwesomeIcons.tableCells,
            },
            seleted: true,
          ),
          ...List.generate(
            categories.length,
            (index) => CategoryItem(data: categories[index]),
          )
        ],
      ),
    );
  }

  _buildPopulars() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: 15),
      child: Row(
        children: List.generate(
          populars.length,
          (index) => PopularItem(
            data: populars[index],
            onTap: () => _navigateToMealDetail(populars[index]),
          ),
        ),
      ),
    );
  }

  _buildFeatured() {
    return Column(
      children: List.generate(
        featured.length,
            (index) => FeatureItem(
          data: featured[index],
          onTap: () => _navigateToMealDetail(featured[index]),
        ),
      ),
    );
  }

  void _navigateToMealDetail(Map<String, dynamic> mealData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealDetailPage(
          mealName: mealData['name'],
          price: mealData['price'],
          imagePath: mealData['image'],
        ),
      ),
    );
  }
}

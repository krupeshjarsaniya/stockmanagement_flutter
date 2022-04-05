import 'package:flutter/material.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/screen/dashbord_screen.dart';
import 'package:stoke_management/screen/melting_screen.dart';
import 'package:stoke_management/screen/more_screen.dart';
import 'package:stoke_management/screen/profile_screen.dart';
import 'package:stoke_management/screen/vendor_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    DashBordScreen(),
    VendorScreen(),
    MeltingScreen(),
    ProfileScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorConstant.bottombarColor,
        selectedItemColor: ColorConstant.bottombarSelectedItem,
        unselectedItemColor: Colors.black.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 11,
        elevation: 200,
        currentIndex: _selectedIndex,
        //New
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: "Dashboard",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.line_weight_sharp),
              label: "Vendors",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.calculate_rounded),
              label: "Meltings",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: "More",
              backgroundColor: Colors.black),
        ],
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

// import 'dart:collection';

import 'package:chop_ya/src/features/core/screens/driver/chats/chat_screen.dart';
import 'package:chop_ya/src/features/core/screens/driver/history/history_screen.dart';
import 'package:chop_ya/src/features/core/screens/driver/map/map_view.dart';
import 'package:chop_ya/src/features/core/screens/driver/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:chop_ya/src/features/core/screens/driver/dashboard/dashboard.dart';

class NavBar extends StatefulWidget {



  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

// current index
int _currentIdex = 0;

// list of screens to navigate to
final List<Widget> _screens = [
   Dashboard(),
  const ChatScreen(),
  const MapView(),
  const HistoryScreen(),
  const ProfileScreen(),

];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens [_currentIdex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
        decoration: BoxDecoration(
          color: const Color(0xFF36454f),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),

        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF36454f),
          selectedItemColor: const Color(0xFFf9f9f9),
          unselectedItemColor: const Color(0xFFf9f9f9).withOpacity(.60),
          selectedFontSize: 14,
          unselectedFontSize: 13,
            
          // backgroundColor: Colors.red[800],
          
          iconSize: 28,
          currentIndex: _currentIdex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              
              ),
              BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),
              label: 'Chat',
              // backgroundColor: Colors.blue,
              ),
              BottomNavigationBarItem(
              icon: Icon(Icons.location_pin),
              label: 'Map',
              // backgroundColor: Colors.blue,
              ),
              BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
              // backgroundColor: Colors.blue,
              ),
              BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Acount',
              // backgroundColor: Colors.blue,
              ),
          ],
          onTap: (index) {
            setState(() {
              _currentIdex = index;
            });
          },
          ),
      ),
    );
  }
}



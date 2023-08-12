import 'package:flutter/material.dart';
import 'package:chop_ya/src/features/core/screens/dashboard/dashboard.dart';

class NavBar extends StatefulWidget {



  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

// current index
int _currentIdex = 0;

// list of screens to navigate to
final List<Widget> _screens = [
  const Dashboard(),
  // const ChatScreen(),
  // const HistoryScreen(),
  // const NotificationScreen(),
  // const AcountScreen(),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens [_currentIdex],
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.history),
            label: 'History',
            // backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            label: 'Notification',
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
    );
  }
}



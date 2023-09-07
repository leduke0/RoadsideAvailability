import 'package:chop_ya/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {

    String? name;
   String? email;

   MyDrawer({ super.key, this.name, this.email });


  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // drawer header
          Container(
            height: 165,
            color: Colors.grey.shade100,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.teal,

              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 70,
                  ),

                  const SizedBox(width: 15,),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Text(
                        widget.name.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),

                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.email.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                        ),

                        overflow: TextOverflow.ellipsis,
                      ),
                      
                  ],)
                ],
              ),
            ),  
          ),

          // drawer body
          GestureDetector(
            onTap: () {

            },
            child: const ListTile(
              leading: Icon(Icons.home, color: Colors.teal, size: 30,),
              title: Text("Home", style: TextStyle(),),
            ),
            ),
            GestureDetector(
            onTap: () {

            },
            child: const ListTile(
              leading: Icon(Icons.payment, color: Colors.teal, size: 30,),
              title: Text("Payments", style: TextStyle(),),
            ),
            ),
            GestureDetector(
            onTap: () {

            },
            child: const ListTile(
              leading: Icon(Icons.info, color: Colors.teal, size: 30,),
              title: Text("About", style: TextStyle(),),
            ),
            ),
            GestureDetector(
            onTap: () {

            },
            child: const ListTile(
              leading: Icon(Icons.bookmark_added, color: Colors.teal, size: 30,),
              title: Text("Terms and conditions", style: TextStyle(),),
            ),
            ),
            GestureDetector(
            onTap: () {
              // sign out function
              AuthenticationRepository.instance.logout();
            },
            child: const ListTile(
              leading: Icon(Icons.logout, color: Colors.teal, size: 30,),
              title: Text("Sign Out", style: TextStyle(),),
            ),
            ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({ super. key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Image.asset('assets/images/rapair.jpg'),
            const Text('Welcome to Chop Ya'),
            const Text('Please login to continue'),
            const Text('Or create an account'),
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Login'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Register'),
                ),
              ],
            )
          ],
        )
      )
    );
  }
}
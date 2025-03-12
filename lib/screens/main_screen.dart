import 'package:flutter/material.dart';

import 'dummy_card_screen.dart';
import 'homescreen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Navigation Page"),
      ),
      body: Padding(
          padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                Homescreen()
              ));
            }, child: Text("Notes App")),
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DummyCardScreen()
              ));
            }, child: Text("Dummy Screen")),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
class DummyCardScreen extends StatefulWidget {
  const DummyCardScreen({super.key});

  @override
  State<DummyCardScreen> createState() => _DummyCardScreenState();
}

class _DummyCardScreenState extends State<DummyCardScreen> {
  List count = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dummy Screen"),
      ),
      body:  Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("data"),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: count.length,
                itemBuilder: (context,index){
                  return Card(
                    child: ListTile(
                      title: Text("Count ${count[index]}"),
                    ),
                  );
                }
            ),
          ),
        ],
      ),
      // Padding(
      //     padding: EdgeInsets.all(20),
      //     child: Row(
      //       children: [
      //
      //         // const SizedBox(width: ,),
      //         // ListView.builder(
      //         //     itemCount: count.length,
      //         //     itemBuilder: (context,index){
      //         //       return Card(
      //         //         child: ListTile(
      //         //           title: Text("Count ${count[index]}"),
      //         //         ),
      //         //       );
      //         //     }
      //         // ),
      //       ],
      //     ),
      // ),
    );
  }
}




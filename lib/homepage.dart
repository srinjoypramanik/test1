import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
          backgroundColor: Colors.white,
              centerTitle: true,

        title: Row(
          mainAxisSize: MainAxisSize.min,     //Fix row size horizontally
          children: [
             Icon(
              Icons.local_taxi_rounded,
              color: Colors.black,
               size: 30,
            ),

             SizedBox(width: 3),

             Text(
              'Uber',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      body: const Center(
        child: Text('WELCOME TO UBER',
          style: TextStyle(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

  }
}

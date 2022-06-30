import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Loading',style: TextStyle(color: Colors.white70,fontSize: 50,fontFamily: "Curvy"),),
            SizedBox(height: 20),
            SpinKitWave(
            color: Colors.white70,
            size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}

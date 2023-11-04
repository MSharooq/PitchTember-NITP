import 'package:flutter/material.dart';
void main(){
  runApp(const MakeAMillion());
}
class MakeAMillion extends StatelessWidget {
  const MakeAMillion({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Make A Million',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Make A Million'),
        ),
        body: Center(
          child: Text('Make A Million'),
        ),
      ),
    );
  }
}

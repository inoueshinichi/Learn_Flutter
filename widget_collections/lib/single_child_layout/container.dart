import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class ContainerPage extends StatelessWidget {
  const ContainerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Container Page')),
      backgroundColor: Colors.amber,
      body: Column(
        children: [
          Spacer(),
          Container(
              // padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              // 個要素に制限をかける
              constraints: const BoxConstraints(maxHeight: 100), 
              child: Container(
                color: Colors.green,
                width: 300,
                height: 200,
                transform: Matrix4.rotationZ(pi / 6),
                child: Container(
                  margin: EdgeInsets.all(8),
                  color: Colors.black,
                  child: Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        width: 10.0,
                        color: Colors.red,
                      )
                    )
                  )
                )
              )
          ),
          Spacer(),
        ],
      ),
    );
  }
}

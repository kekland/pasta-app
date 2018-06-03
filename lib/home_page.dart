import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  createNewPasta() {

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Your pastas'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewPasta,
        child: Icon(Icons.add)
      ),
    );
  }
}

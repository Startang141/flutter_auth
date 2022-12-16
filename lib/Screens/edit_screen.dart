import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreen();
}

class _EditScreen extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Edit Page',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: "Edit Your Categories Name",
            labelText: "Edit Categories",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            suffixIcon: Container(
              margin: const EdgeInsets.fromLTRB(0, 8, 12, 8),
              child: ElevatedButton(
                child: const Text("Edit"),
                onPressed: () {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}

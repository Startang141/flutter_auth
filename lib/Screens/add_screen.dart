import 'package:flutter/material.dart';
import 'package:flutterapp/Services/auth_services.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreen();
}

class _AddScreen extends State<AddScreen> {
  final TextEditingController categoryName = TextEditingController();

  Future doAddCategory(String name) async {
    final response = await AuthServices().requestAddCategory(name);
    print(response.body);
    Navigator.pushNamed(context, "/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Add Page',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: TextFormField(
          controller: categoryName,
          decoration: InputDecoration(
            hintText: "Input Your Categories Name",
            labelText: "Add Categories",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            suffixIcon: Container(
              margin: const EdgeInsets.fromLTRB(0, 8, 12, 8),
              child: ElevatedButton(
                child: const Text("Add"),
                onPressed: () async {
                  await doAddCategory(categoryName.text);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

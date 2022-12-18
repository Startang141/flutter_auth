import 'package:flutter/material.dart';

import 'package:flutterapp/Services/auth_services.dart';
import 'package:flutterapp/components/category.dart';

class EditScreen extends StatefulWidget {
  Category category;

  EditScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreen();
}

class _EditScreen extends State<EditScreen> {
  final TextEditingController editCategoryTxt = TextEditingController();

  @override
  void initState() {
    super.initState();
    editCategoryTxt.text = widget.category!.name;
  }

  doEditCategory() async {
    final name = editCategoryTxt.text;
    final response = await AuthServices().requestUpdate(widget.category, name!);
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
          controller: editCategoryTxt,
          decoration: InputDecoration(
            hintText: "Edit Your Categories Name",
            labelText: "Edit Categories",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            suffixIcon: Container(
              margin: const EdgeInsets.fromLTRB(0, 8, 12, 8),
              child: ElevatedButton(
                child: const Text("Edit"),
                onPressed: () {
                  doEditCategory();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

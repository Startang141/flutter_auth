import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterapp/Screens/login_screen.dart';
import 'package:flutterapp/Services/category_services.dart';
import 'package:flutterapp/components/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/auth_services.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  List listCategory = [];
  String name = '';
  final TextEditingController addCategoryTxt = TextEditingController();

  getKategori() async {
    final response = await AuthServices().getKategori();
    print('respone from kategori');
    print(response);
    var dataResponse = json.decode(response.body);
    setState(() {
      var listRespon = dataResponse['data'];
      print(listRespon);
      for (var i = 0; i < listRespon.length; i++) {
        listCategory.add(Category.fromJson(listRespon[i]));
      }
    });
  }

  doAddCategory() async {
    final name = addCategoryTxt.text;
    final response = await CategoryService().addCategory(name);
    print(response.body);
    Navigator.pushNamed(context, "/");
  }

  getUser() async {
    final sharedPref = await SharedPreferences.getInstance();
    setState(() {
      const key = 'name';
      final value = sharedPref.get(key);
      name = '$value';
    });
  }

  logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    const key = 'token';
    final value = preferences.get(key);
    setState(() {
      preferences.remove('token');
      preferences.clear();
    });

    final token = '$value';
    // print(token);
    http.Response response = await AuthServices.logout(token);
    print(response.body);
    // final response = await AuthServices().logout(token);

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const LoginScreen(),
        ),
        (route) => false);
  }

  @override
  void initState() {
    getUser();
    doAddCategory();
    super.initState();
    getKategori();
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
          'Dashboard',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: () {
              logOut();
            },
          )
        ],
      ),
      body: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        decoration: const BoxDecoration(
          color: Color(0xff000000),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 48.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, $name',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const Text(
                            'Mari Menjelajah',
                            style: TextStyle(
                              color: Color.fromARGB(196, 255, 255, 255),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'List Categories',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(16),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Input Your Categories Name",
                          labelText: "Add Categories",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          suffixIcon: Container(
                            margin: const EdgeInsets.fromLTRB(0, 8, 12, 8),
                            child: ElevatedButton(
                              child: const Text("Add"),
                              onPressed: () {
                                doAddCategory();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                          ),
                        ),
                        child: ListView.builder(
                            itemCount: listCategory.length,
                            itemBuilder: (context, index) {
                              var kategori = listCategory[index];
                              return Dismissible(
                                key: UniqueKey(),
                                background: Container(
                                  color: Colors.yellowAccent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.create_rounded,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                secondaryBackground: Container(
                                  color: Colors.redAccent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
                                        Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 1,
                                        blurRadius: 9,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18),
                                      child: Text(
                                        kategori.name,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

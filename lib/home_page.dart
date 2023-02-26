import 'dart:convert';

import 'package:flutter/material.dart';
import 'add_page.dart';
import 'detail_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'model/categories.dart';
import 'model/products.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

  List<IconData> menus = [
    Icons.home_rounded,
    Icons.favorite_rounded,
    Icons.notifications,
    Icons.person
  ];



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

    backgroundColor: Colors.grey.shade300,
    appBar: AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leadingWidth: 130,
    leading: Padding(
    padding: const EdgeInsets.only(left: 20),
    child: Row(
    children: [
    const Icon(
    Icons.bubble_chart_rounded,
    color: Color(0xFF102A68),
    ),
    RichText(
    text: TextSpan(children: [
    TextSpan(
    text: 'GRO',
    style: GoogleFonts.poppins().copyWith(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Color(0xFFff5621))),
    TextSpan(
    text: 'CERY',
    style: GoogleFonts.poppins().copyWith(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Color(0xFF102A68))),
    ])),
    ],
    ),
    ),
    actions: [
    Container(
    padding: const EdgeInsets.all(2),
    decoration: const BoxDecoration(
    shape: BoxShape.circle, color: Color(0xFFF8FAFF)),
    child: IconButton(
    onPressed: () {},
    icon: const Icon(
    Icons.shopping_basket_rounded,
    color: Color(0xFFff5621),
    ))),
    const SizedBox(
    width: 20,
    )
    ],
    ),



      //backgroundColor: Colors.white30,
     body: FutureBuilder<http.Response>(
        builder: (context, snapshot) {
          if (snapshot != null && snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => AddFood(
                            jsonDecode(snapshot.data!.body.toString())[index]),
                      ),
                    )
                        .then(
                          (value) {
                        if (value == true) {
                          setState(() {});
                        }
                      },
                    );
                  },

                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(20)
                        ),
                        height: 200,
                        width: double.infinity,
                        child: Image(
                            image: NetworkImage((jsonDecode(
                                snapshot.data!.body.toString())[index]
                            ['image'])
                                .toString())),
                      ),
                      Text(
                        (jsonDecode(snapshot.data!.body.toString())[index]
                        ['name'])
                            .toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (context) => AddFood(jsonDecode(
                                        snapshot.data!.body.toString())[index]),
                                  ),
                                )
                                    .then(
                                      (value) {
                                    if (value == true) {
                                      setState(() {});
                                    }
                                  },
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(15),
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(20),
                                    border: Border.all(),
                                    color: Colors.green),
                                child: Text(
                                  "Edit",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () {
                                deleteFood((jsonDecode(snapshot.data!.body
                                    .toString())[index]['id']))
                                    .then(
                                      (value) {
                                    setState(() {});
                                  },
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(15),
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(20),
                                    border: Border.all(),
                                    color: Colors.red),
                                child: Text("Delete",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: jsonDecode(snapshot.data!.body.toString()).length,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
        future: getFood(),
      ),

    );

  }

  Future<http.Response> getFood() async {
    var response = await http
        .get(Uri.parse("https://6315acaa5b85ba9b11e4aa90.mockapi.io/Grocery"));
    return response;
  }

  Future<void> deleteFood(id) async {
    var response1 = await http.delete(
        Uri.parse("https://6315acaa5b85ba9b11e4aa90.mockapi.io/Grocery/$id"));
  }
}
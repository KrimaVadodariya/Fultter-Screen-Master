import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddFood extends StatefulWidget {
  AddFood(this.map);

  Map? map;

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  TextEditingController foodNameController = TextEditingController();
  TextEditingController foodImageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    foodNameController.text = widget.map == null ? "" : widget.map!['name'];
    foodImageController.text = widget.map == null ? "" : widget.map!['image'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Add Food",
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios)),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      // border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.trim().length == 0) {
                              return 'Enter Valid Name';
                            }
                            return null;
                          },
                          controller: foodNameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Enter Food Name",
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.trim().length == 0) {
                              return 'Enter Valid Name';
                            }
                            return null;
                          },
                          controller: foodImageController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Enter Food Image Link",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(
                            () async {
                          if (_formKey.currentState!.validate()) {
                            if (widget.map == null) {
                              addFood().then(
                                    (value) => Navigator.of(context).pop(true),
                              );
                            } else {
                              updateFood(widget.map!['id']).then(
                                    (value) => Navigator.of(context).pop(true),
                              );
                            }
                          }
                        },
                      );
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addFood() async {
    Map map = {};
    map['name'] = foodNameController.text;
    map['image'] = foodImageController.text;

    var response1 = await http.post(
        Uri.parse("https://6315acaa5b85ba9b11e4aa90.mockapi.io/Grocery"),
        body: map);
    print(response1.body);
  }

  Future<void> updateFood(id) async {
    Map map = {};
    map['name'] = foodNameController.text;
    map['image'] = foodImageController.text;

    var response1 = await http.put(
        Uri.parse("https://6315acaa5b85ba9b11e4aa90.mockapi.io/Grocery/$id"),
        body: map);
    print(response1.body);
  }
}

import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'model/categories.dart';
import 'model/products.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentCategory = 'Fruits';
  int currentMenu = 0;
  List<Product> dataProduct =
      products.where((element) => element.category == 'Fruits').toList();
  List<IconData> menus = [
    Icons.home_rounded,
    Icons.favorite_rounded,
    Icons.notifications,
    Icons.person
  ];
  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xFFF8FAFF)),
              child: TextField(
                autofocus: false,
                onChanged: (value) {
                  setState(() {
                    value != ''
                        ? dataProduct = products
                            .where((element) => element.name
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList()
                        : dataProduct = products
                            .where((element) =>
                                element.category == currentCategory)
                            .toList();
                  });
                },
                decoration: InputDecoration(
                    hintText: 'Search want to buy',
                    hintStyle: GoogleFonts.poppins()
                        .copyWith(fontSize: 14, color: Color(0xFF102A68)),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: Color(0xFF102A68),
                    ),
                    suffixIcon: const Icon(
                      Icons.tune_rounded,
                      color: Color(0xFF102A68),
                    ),
                    border: InputBorder.none),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: categories
                  .map((e) => GestureDetector(
                        onTap: () {
                          setState(() {
                            currentCategory = e;
                            dataProduct = products
                                .where((element) => element.category == e)
                                .toList();
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(microseconds: 200),
                          height: 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              currentCategory == e
                                  ? Text(
                                      e,
                                      style: GoogleFonts.poppins().copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF102A68)),
                                    )
                                  : Text(
                                      e,
                                      style: GoogleFonts.poppins().copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF102A68)
                                              .withOpacity(0.7)),
                                    ),
                              currentCategory == e
                                  ? Container(
                                      height: 5,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xFFff5621),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: dataProduct.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Wrap(
                      runSpacing: 20,
                      spacing: 20,
                      children: dataProduct
                          .map((e) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailPage(product: e)));
                                },
                                child: ItemProduct(
                                  product: e,
                                ),
                              ))
                          .toList(),
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.shopping_cart_outlined,
                          size: 120,
                          color: Color(0xFFff5621),
                        ),
                        Text(
                          'Product Empty',
                          style: GoogleFonts.poppins()
                              .copyWith(fontSize: 18, color: Color(0xFFff5621)),
                        )
                      ],
                    ),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Color(0xFF102A68).withOpacity(0.4),
                  blurRadius: 10,
                  spreadRadius: 5)
            ],
            color: Color(0xFFF8FAFF)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
              menus.length,
              (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        currentMenu = index;
                      });
                    },
                    child: Icon(
                      menus[index],
                      color: currentMenu == index
                          ? Color(0xFFFE9D34)
                          : Colors.grey,
                    ),
                  )),
        ),
      ),
    );
  }
}

class ItemProduct extends StatelessWidget {
  final Product product;
  const ItemProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 2 - 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Color(0xFFF8FAFF)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/${product.images[0]}',
                  height: 100,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                product.name,
                style: GoogleFonts.poppins().copyWith(
                    color: Color(0xFF102A68),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Text(
                '${product.calorie} Cal',
                style: GoogleFonts.poppins().copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF102A68).withOpacity(0.7)),
              ),
              Row(
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: '\$${product.price}',
                        style: GoogleFonts.poppins().copyWith(
                          color: Color(0xFFFE9D34),
                          fontWeight: FontWeight.bold,
                        )),
                    TextSpan(
                        text: ' /kg',
                        style: GoogleFonts.poppins().copyWith(
                            color: Color(0xFF102A68),
                            fontWeight: FontWeight.bold))
                  ])),
                  const Spacer(),
                  Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFff5621)),
                      child: const Icon(
                        Icons.add,
                        color: Color(0xFFF8FAFF),
                        size: 16,
                      ))
                ],
              )
            ],
          ),
        ));
  }
}

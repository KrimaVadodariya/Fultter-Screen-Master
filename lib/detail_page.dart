import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'model/products.dart';

class DetailPage extends StatefulWidget {
  final Product product;
  const DetailPage({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int currentImage = 0;
  int quantity = 1;
  Widget indicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 5,
      margin: const EdgeInsets.all(2),
      width: index == currentImage ? 20 : 5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: index == currentImage
              ? Color(0xFF102A68)
              : Color(0xFF102A68).withOpacity(0.5)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 90,
        leading: Container(
          height: 50,
          width: 50,
          margin: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Color(0xFFF8FAFF)),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Color(0xFF102A68),
              )),
        ),
        actions: [
          Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Color(0xFFF8FAFF)),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border_rounded,
                  color: Color(0xFFFE9D34),

                )),
          ),
          const SizedBox(width: 20)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  CarouselSlider.builder(
                      itemCount: widget.product.images.length,
                      itemBuilder: (context, index, realIndex) {
                        return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Image.asset(
                              'assets/${widget.product.images[index]}',
                              fit: BoxFit.fitWidth,
                            ));
                      },
                      options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentImage = index;
                            });
                          },
                          viewportFraction: 1,
                          aspectRatio: 1)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(widget.product.images.length, (index) {
                        return indicator(index);
                      })
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(30)),
                  color: Color(0xFFF8FAFF),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF102A68).withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 10)
                  ]),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade400),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Color(0xFFFE9D34),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '${widget.product.rate} (2K)',
                            style: GoogleFonts.poppins().copyWith(
                              color: Color(0xFF102A68),
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.local_fire_department_rounded,
                            color: Color(0xFFff5621),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '${widget.product.calorie} Cal',
                            style: GoogleFonts.poppins().copyWith(
                              color: Color(0xFF102A68),
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.fire_truck_rounded,
                            color: Color(0xFFff5621),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Fri 26.12',
                            style: GoogleFonts.poppins().copyWith(
                              color: Color(0xFF102A68),
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        widget.product.name,
                        style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF102A68),
                            fontSize: 20),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (quantity > 1) {
                                  quantity--;
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF102A68).withOpacity(0.5)),
                              child: Center(
                                child: Text(
                                  '-',
                                  style: GoogleFonts.poppins().copyWith(
                                      fontSize: 16, color: Color(0xFFF8FAFF)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '$quantity kg',
                            style: GoogleFonts.poppins().copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF102A68).withOpacity(0.8)),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFff5621)),
                              child: Center(
                                child: Text(
                                  '+',
                                  style: GoogleFonts.poppins().copyWith(
                                      fontSize: 16, color: Color(0xFFF8FAFF)),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ReadMoreText(
                        widget.product.description,
                        trimLines: 3,
                        colorClickableText: Color(0xFFff5621),
                        trimCollapsedText: 'Read More',
                        trimExpandedText: 'Show Less',
                        moreStyle: GoogleFonts.poppins()
                            .copyWith(color: Color(0xFFff5621)),
                        lessStyle: GoogleFonts.poppins()
                            .copyWith(color: Color(0xFFff5621)),
                        trimMode: TrimMode.Line,
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.poppins().copyWith(
                            color: Color(0xFF102A68).withOpacity(0.8),
                            fontSize: 14,
                            height: 1.8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Price',
                            style: GoogleFonts.poppins().copyWith(
                                fontSize: 14,
                                color: Color(0xFF102A68).withOpacity(0.6)),
                          ),
                          Text(
                              '\$${(widget.product.price * quantity).toStringAsFixed(2)}',
                              style: GoogleFonts.poppins().copyWith(
                                  fontSize: 20,
                                  color: Color(0xFF102A68),
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      const Spacer(),
                      TextButton(
                          onPressed: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0xFFff5621)),
                            child: Text(
                              'Add to Cart',
                              style: GoogleFonts.poppins().copyWith(
                                  fontSize: 16,
                                  color: Color(0xFFF8FAFF),
                                  fontWeight: FontWeight.bold),
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

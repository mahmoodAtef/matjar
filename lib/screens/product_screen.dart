import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../models/home_model.dart';

class ProductScreen extends StatelessWidget {
  var model;
  ProductScreen(this.model);

  @override
  Widget build(BuildContext context) {
    model['images'].add(model['image']);
    List links = model['images'];
    late List<Image> images = List.generate(
        links.length,
        (index) => Image(
              image: NetworkImage(links[index]),
            ));
    for (int i = 0; i < links.length; i++) {}
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model['name'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    CarouselSlider(
                        options: CarouselOptions(
                          aspectRatio: 16 / 9,
                          viewportFraction: 1,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 4),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 900),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          height: MediaQuery.of(context).size.height / 3,
                        ),
                        items: images),
                    model['discount'] != 0
                        ? Text(
                            '  ${model['discount']} %  ',
                            style: TextStyle(
                                fontSize: 20,
                                backgroundColor: Colors.deepOrange,
                                color: Colors.white),
                          )
                        : Container(),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text(
                      ' Price : ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.deepOrange),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      model['price'].toString() + ' LE',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    model['discount'] != 0
                        ? Text(model['old_price'].toString() + ' LE',
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 20,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.black))
                        : Container(),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  ' Description : ',
                  style: TextStyle(
                    backgroundColor: Colors.deepOrange,
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(model['description']),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () {},
                      child: Icon(Icons.shopping_cart),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.favorite_border,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

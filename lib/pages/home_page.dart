import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almatjar/cubit/cubit.dart';
import 'package:almatjar/cubit/states.dart';
import 'package:almatjar/models/home_model.dart';
import 'package:almatjar/screens/product_screen.dart';
import '../models/categories.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeModel = HomeModel();
    ShopCubit.get(context)
        .getHomeData()
        .then((value) => {homeModel = ShopCubit.get(context).homeModel});
    var model = CategoriesModel();
    ShopCubit.get(context).getCategoriesData()
        .then((value) => {model = ShopCubit.get(context).categoriesModel});
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        ShopCubit.get(context)
            .getHomeData()
            .then((value) => {homeModel = ShopCubit.get(context).homeModel});
        ShopCubit.get(context).getCategoriesData()
            .then((value) => {model = ShopCubit.get(context).categoriesModel});
      },
      builder: (context, state) {
        return (homeModel.data.banners.length == 0 &&
                model.categoriesDataModel.categoriesData.length == 0)
            ? Center(child: CircularProgressIndicator(),)
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 16 / 9,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 4),
                        autoPlayAnimationDuration: Duration(milliseconds: 900),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        height: MediaQuery.of(context).size.height / 3,
                      ),
                      items: homeModel.data.banners.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(),
                                child: Image(image: NetworkImage(i['image'])));
                          },
                        );
                      }).toList(),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Categories',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w800),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      height: 110,
                      child: Card(
                        elevation: 3,
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 110,
                                  width: 110,
                                  child: Stack(
                                    alignment:
                                        AlignmentDirectional.bottomCenter,
                                    children: [
                                      Image(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(model
                                            .categoriesDataModel
                                            .categoriesData[index]['image']),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        color: Colors.black.withOpacity(.7),
                                        child: Text(
                                          model.categoriesDataModel
                                              .categoriesData[index]['name'],
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Container(
                                width: 5,
                                color: Colors.grey[200],
                              );
                            },
                            itemCount: model
                                .categoriesDataModel.categoriesData.length),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Products',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      color: Colors.grey[200],
                      child: GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        padding: EdgeInsets.all(2.5),
                        children: List.generate(
                            homeModel.data.products.length,
                            (index) => ProductBuilder(
                                homeModel.data.products[index], context)),
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        shrinkWrap: true,
                        childAspectRatio: 1 / 1.6,
                      ),
                    )
                  ],
                ),
              );
      },
    );
  }

  Widget ProductBuilder(model, context) {
    return InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProductScreen(model)));
        },
        child: Card(
          elevation: 5,
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image(
                          image: NetworkImage(
                            model['image'],
                          ),
                          height: 200),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      model['name'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          height: 1.1),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          '${model['price'].toString()} LE',
                          style: TextStyle(color: Colors.deepOrange),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (model['discount'] != 0)
                          Text(
                            model['old_price'].toString(),
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.black),
                          ),
                        Spacer(),
                        IconButton(
                            onPressed: () {

                              ShopCubit.get(context).changeFav(productId: model['id']).then((value) {

                                print ('id : '+model['id'].toString()+' '+ value.toString());
                              });

                            },
                            icon:
                            CircleAvatar(child: const Icon(Icons.favorite_border,color: Colors.white,)
                              ,backgroundColor:
                                ShopCubit.get(context).favorites[model['id']]! ?Colors.deepOrange: Colors.grey,),)
                      ],
                    )
                  ],
                ),
              ),
              if (model['discount'] != 0)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    padding: EdgeInsets.all(1.5),
                    color: Colors.deepOrange,
                    child: Text(
                      'Discount ${model['discount']}%',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
            ],
            alignment: AlignmentDirectional.bottomStart,
          ),
        ));
  }
}

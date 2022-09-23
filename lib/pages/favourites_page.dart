import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almatjar/cubit/cubit.dart';
import 'package:almatjar/cubit/states.dart';
import 'package:almatjar/models/favourites_model.dart';
import 'package:almatjar/models/home_model.dart';
import 'package:almatjar/screens/product_screen.dart';



class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var favouritesModel = ShopCubit.get(context).favoritesModel;
    ShopCubit.get(context).getFavData().then((value) => {favouritesModel = ShopCubit.get(context).favoritesModel,
      print(favouritesModel.data.data.length.toString())});
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
         favouritesModel = ShopCubit.get(context).favoritesModel;
      },
      builder: (context, state) {

        return state is ShopFavoritesLoadingState
            ? const Center(child: CircularProgressIndicator(),)
            :  ListView.separated(itemBuilder: (context, index) => ProductBuilder(favouritesModel.data.data[index].product,
            context), separatorBuilder: (context,index)=>Container(height: 1,width: double.infinity,color: Colors.grey,)
            , itemCount: favouritesModel.data.data.length);
      },
    );
  }

  Widget ProductBuilder(Product model, context) {
    return InkWell(
        onTap: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => ProductScreen(model)));
        },
        child: Padding(padding: EdgeInsets.all(0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  height: 200,
                  width: 160,
                  color: Colors.white,
                  child: Image(
                    image: NetworkImage(
                        model.image),
                  ),
                ),
                Expanded(
                    child: Column(
                      children: [
                        Text( model.name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 15,
                        ) ,
                        Row(children: [
                          Text(
                            model.price.round().toString(),
                            style: TextStyle(color: Colors.deepOrange,
                                fontSize: 20, fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(width: 30,),
                          Text(
                            model.oldPrice.toString(),
                            style: TextStyle(color: Colors.grey[600],decoration: TextDecoration.lineThrough,decorationColor: Colors.black,
                                fontSize: 20, fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Spacer(),
                          Text(
                            "LE",
                            style: TextStyle(color: Colors.deepOrange,
                                fontSize: 20, fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                          FloatingActionButton(onPressed: (){},child: Icon(Icons.add_shopping_cart),mini: true),
                          SizedBox(width: 10,),
                          FloatingActionButton( onPressed: () {
                            ShopCubit.get(context).changeFav(productId: model.id).then((value) {
                              ShopCubit.get(context).getFavData();
                              print ('id : '+model.id.toString()+' ');
                            });
                          },child: Icon(Icons.favorite),mini: true)

                        ],)

                      ],
                    ))
              ],
            ),
          ),));
  }
}

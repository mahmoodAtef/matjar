
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almatjar/cubit/cubit.dart';
import 'package:almatjar/cubit/states.dart';

import '../models/categories.dart';
class  CategoriesPage extends StatelessWidget {
  const  CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = CategoriesModel();
    ShopCubit.get(context)
        .getCategoriesData()
        .then((value) => {model = ShopCubit.get(context).categoriesModel});
    return BlocConsumer<ShopCubit,ShopStates> (builder: (context, state) =>
       model.categoriesDataModel.categoriesData.length == 0? Center(child: CircularProgressIndicator(),): SingleChildScrollView(child: GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      padding: EdgeInsets.all(2.5),
      children: List.generate(
          model.categoriesDataModel.categoriesData.length,
              (index) =>
              categoryBuilder(image: model.categoriesDataModel.categoriesData[index]['image'],
                  name:model.categoriesDataModel.categoriesData[index]['name']
              )),
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      shrinkWrap: true,
      childAspectRatio: 1 / 1,
    ),)
    , listener: (context,state){}
    )
    ;}
  Widget categoryBuilder({required String image , required String name})
  {
    return InkWell(onTap: (){},child: Card(elevation: 5,shadowColor: Colors.black,child:Container(height: 100,width: 100,
      child:
      Column(children: [
        Expanded(child:  Image(image: NetworkImage(image),),),
      Container(color: Colors.black.withOpacity(.7),child:   Text(name ,textAlign: TextAlign.center,style: TextStyle(fontSize: 18 ,color: Colors.white, )),width: double.infinity,)
      ],),),),);
  }
}

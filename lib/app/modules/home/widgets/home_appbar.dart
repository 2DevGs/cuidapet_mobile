
import 'package:cuidapet_mobile/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends SliverAppBar {

  HomeAppBar( HomeController controller, {super.key}) 
      : super(
        expandedHeight: 100,
        collapsedHeight: 100,
        elevation: 0,
        flexibleSpace: _CuidapetAppBar(controller: controller,),
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        pinned: true,
      );

}

class _CuidapetAppBar extends StatelessWidget {

  final HomeController controller;

  const _CuidapetAppBar({required this.controller});

   @override
   Widget build(BuildContext context) {

    final outLineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Colors.grey[200]!)
    );

      return AppBar(
        backgroundColor: Colors.grey[100],
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(
            bottom: 12.0
          ),
          child: const Text(
            'CuidaPet',
            style: TextStyle(
              color: Colors.white,
            ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: (){
                controller.goToAdrressPage();
              }, 
              icon: Icon(Icons.location_on, color: Colors.black,),
            ),
          ],
          elevation: 0,
          flexibleSpace: Stack(
            children: [
              Container(
                height: 110.h,
                color: context.primaryColor,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 0.9.sw,
                  child: Material(
                    borderRadius: BorderRadius.circular(30),
                    elevation: 4,
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        suffixIcon: Icon(
                          Icons.search, 
                          size: 25,
                          color: Colors.grey,
                        ),
                        border: outLineInputBorder,
                        focusedBorder: outLineInputBorder,
                        enabledBorder: outLineInputBorder,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
      );
  }
}
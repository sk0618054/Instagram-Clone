import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/global_variables.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/colors.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {



  int _page = 0;

  late PageController pageController ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          'assets/ic_instagram.svg',
          color: primaryColor,
          height: 32,
        ),
        actions: [
          IconButton(
              onPressed: () =>navigationTapped(0), icon: const Icon(Icons.home),color:_page==0? primaryColor:secondaryColor,),
          IconButton(
              onPressed: () =>navigationTapped(1), icon: const Icon(Icons.search),color:_page==1? primaryColor:secondaryColor,),
          IconButton(
              onPressed:() =>navigationTapped(2), icon: const Icon(Icons.add_a_photo),color:_page==2? primaryColor:secondaryColor,),
          IconButton(
              onPressed: () =>navigationTapped(3), icon: const Icon(Icons.favorite),color:_page==3? primaryColor:secondaryColor,),
          IconButton(
              onPressed:() =>navigationTapped(4), icon: const Icon(Icons.person),color:_page==4? primaryColor:secondaryColor,),
          // IconButton(
          //     onPressed:() =>navigationTapped(5), icon: const Icon(Icons.message_outlined),color:_page==5? primaryColor:secondaryColor,),
        ],
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: homeScreenItem,
        controller: pageController,
        onPageChanged:onPageChanged ,
      ),
    );
  }
}

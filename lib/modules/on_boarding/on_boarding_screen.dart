// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:untitled/modules/shop_login/shop_login.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BoardingModel {
  final String title;
  final String img;
  final String body;

  BoardingModel({
    required this.body,
    required this.img,
    required this.title,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      NavigateAndFinish(context, ShopLoginScreen());
    });
  }

  List<BoardingModel> boarding = [
    BoardingModel(
        body: "On Board Body 1",
        img: 'assets/images/Self checkout-rafiki.svg',
        title: "On Board Title 1"),
    BoardingModel(
        body: "On Board Body 2",
        img: 'assets/images/Cash Payment-rafiki.svg',
        title: "On Board Title 2"),
    BoardingModel(
        body: "On Board Body 3",
        img: 'assets/images/Shopping-rafiki.svg',
        title: "On Board Title 3"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {
                  submit();
                },
                child: const Text('SKIP'))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: boardController,
                  onPageChanged: (value) {
                    if (value == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      isLast = false;
                    }
                  },
                  physics: const BouncingScrollPhysics(),
                  itemCount: boarding.length,
                  itemBuilder: (context, index) =>
                      BuildBoardingItem(boarding[index]),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        expansionFactor: 3,
                        spacing: 5,
                        dotColor: Colors.grey),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget BuildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SvgPicture.asset(
              model.img,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            model.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            model.body,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      );
}

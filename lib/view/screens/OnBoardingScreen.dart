import 'package:flutter/material.dart';
import 'package:shop_app/view/screens/LoginScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../components.dart';

class BoardingModel {
  String title;

  String body;

  BoardingModel({required this.title, required this.body});
}

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  PageController _pageController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    List models = [
      BoardingModel(title: "On Board 1 title", body: "On Board 1 body"),
      BoardingModel(title: "On Board 2 title", body: "On Board 2 body"),
      BoardingModel(title: "On Board 3 title", body: "On Board 3 body"),
    ];
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(LoginScreen.routeName),
              child: const Text(
                "SKIP",
                style: TextStyle(
                  fontSize: 18,
                  color: primaryColor,
                ),
              )),
          const SizedBox(width: 30),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                itemCount: models.length,
                onPageChanged: (index) {
                  if (index == models.length - 1) {
                    isLast = true;
                  } else {
                    isLast = false;
                  }
                },
                itemBuilder: (ctx, index) => onBoardingItem(models[index]),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: models.length,
                  effect: const ExpandingDotsEffect(
                      activeDotColor: primaryColor,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5,
                      expansionFactor: 4),
                ),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: primaryColor,
                  child: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    if (isLast) {
                      print("push to login ");
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                      return;
                    }
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.fastLinearToSlowEaseIn);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget onBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Image(image: AssetImage("assets/images/onboarding1.png")),
          const SizedBox(height: 50),
          Text(
            model.title,
            style: titleTextStyle ,
          ),
          const SizedBox(height: 10),
          Text(
            model.body,
            style: subTitleTextStyle,
          ),
        ],
      );
}

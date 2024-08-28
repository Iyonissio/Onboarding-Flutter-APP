import 'package:flutter/material.dart';
import 'package:ola_mundo/Components/color.dart';
import 'package:ola_mundo/Onboarding/onboarding_items.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => pageController
                          .jumpToPage(controller.items.length - 1),
                      child: const Text("Skip")),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: controller.items.length,
                    onDotClicked: (index) => pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeIn),
                    effect: const WormEffect(
                        dotHeight: 12,
                        dotWidth: 12,
                        activeDotColor: primaryColor),
                  ),
                  TextButton(
                      onPressed: () => pageController.nextPage(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeIn),
                      child: const Text("Next")),
                ],
              ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
            onPageChanged: (index) => setState(
                () => isLastPage = controller.items.length - 1 == index),
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(controller.items[index].image),
                  const SizedBox(height: 15),
                  Text(
                    controller.items[index].title,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    controller.items[index].description,
                    style: const TextStyle(color: Colors.grey, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget getStarted() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: primaryColor),
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
      child: TextButton(
          onPressed: () {},
          child: Text(
            "Get Started",
            style: TextStyle(color: Colors.white, fontSize: 16),
          )),
    );
  }
}

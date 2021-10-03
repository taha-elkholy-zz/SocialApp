import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cash_helper.dart';
import 'package:social_app/shared/styles/colors.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // refer to the current page index in the
  // on boarding list,
  // if last one it will be = true
  bool _isLast = false;

  // controller of the page view and smooth indicator
  var pageController = PageController();

  // list of the screens will be shown in onBoarding
  List<OnBoardingModel> onBoardingScreens = [
    OnBoardingModel(
      title: 'Social App',
      body: 'Collaborate with all other social media applications',
      imagePath: 'assets/images/on_boarding_1.jpg',
    ),
    OnBoardingModel(
      title: 'Easy to use',
      body: 'Flexible and easy to use anywhere',
      imagePath: 'assets/images/on_boarding_2.jpg',
    ),
    OnBoardingModel(
      title: 'Safe',
      body: 'It achieves user security and maintains privacy',
      imagePath: 'assets/images/on_boarding_3.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // control of status bar color
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        actions: [
          defaultTextButton(
            text: 'skip',
            onPressed: _submitBoarding,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: onBoardingScreens.length,
                physics: const BouncingScrollPhysics(),
                controller: pageController,
                onPageChanged: (index) {
                  if (index == onBoardingScreens.length - 1) {
                    setState(() {
                      _isLast = true;
                    });
                  } else {
                    setState(() {
                      _isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(onBoardingScreens[index]),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: onBoardingScreens.length,
                  effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 4,
                      spacing: 5),
                ),
                const Spacer(),
                FloatingActionButton(
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (_isLast) {
                        _submitBoarding();
                      } else {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(OnBoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(model.imagePath),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          model.title,
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          model.body,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  // finish on boarding and go to login screen
  void _submitBoarding() {
    // save that we have been seen the OnBoardingScreen
    // in SharedPreferences
    CashHelper.saveData(key: BOARDING_SEEN, value: true).then((value) {
      if (value) {
        navigateAndFinish(context, LoginScreen());
      }
    });
  }
}

// create a model class of boarding here
// as we will not use it anywhere
class OnBoardingModel {
  // the class contain title, message body , image
  final String title;
  final String body;
  final String imagePath;

  OnBoardingModel(
      {required this.title, required this.body, required this.imagePath});
}

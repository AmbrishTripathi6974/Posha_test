import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:posha/utils/helpers.dart';
import '../../blocs/onboarding_cubit.dart';
import '../../core/constants.dart';
import '../../core/services/local_storage.dart';
import '../../models/onboard_model.dart';

class PetsOnBoardingScreen extends StatelessWidget {
  final PageController _pageController = PageController();

  PetsOnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: THelperFunctions.screenHeight(context) * 0.7,
            color: theme.scaffoldBackgroundColor,
            child: PageView.builder(
              controller: _pageController,
              itemCount: onBoardData.length,
              onPageChanged: (index) =>
                  context.read<OnBoardingCubit>().changePage(index),
              itemBuilder: (context, index) => onBoardingItems(
                  context, THelperFunctions.screenSize(context), index),
            ),
          ),
          BlocBuilder<OnBoardingCubit, int>(
            builder: (context, currentPage) {
              return GestureDetector(
                onTap: () async {
                  if (currentPage == onBoardData.length - 1) {
                    final localStorage = LocalStorageService();
                    await localStorage.saveStatus('seen_onboarding', true);
                    context.go('/');
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                    context
                        .read<OnBoardingCubit>()
                        .nextPage(onBoardData.length);
                  }
                },
                child: Container(
                  height: 70,
                  width: THelperFunctions.screenWidth(context) * 0.6,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      currentPage == onBoardData.length - 1
                          ? "Get Started"
                          : "Continue",
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          BlocBuilder<OnBoardingCubit, int>(
            builder: (context, currentPage) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onBoardData.length,
                  (index) => indicatorForSlider(context, currentPage, index),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  AnimatedContainer indicatorForSlider(
      BuildContext context, int currentPage, int index) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: currentPage == index ? 20 : 10,
      height: 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: currentPage == index
            ? theme.primaryColor
            : theme.dividerColor.withOpacity(0.3),
      ),
    );
  }

  Column onBoardingItems(BuildContext context, Size size, int index) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          height: size.height * 0.4,
          width: size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    height: 240,
                    width: size.width * 0.9,
                    color: orangeContainer,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 5,
                          left: -40,
                          height: 130,
                          width: 130,
                          child: Transform.rotate(
                            angle: -11,
                            child: SvgPicture.asset(
                              "assets/svg/cat_paw.svg",
                              color: pawColor1,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -20,
                          right: -20,
                          height: 130,
                          width: 130,
                          child: Transform.rotate(
                            angle: -12,
                            child: SvgPicture.asset(
                              "assets/svg/cat_paw.svg",
                              color: pawColor1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 60,
                child: Image.asset(
                  onBoardData[index].image,
                  height: size.height * 0.4,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Text.rich(
          TextSpan(
            style: theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w900,
              height: 1.2,
              color: theme.textTheme.headlineLarge?.color,
            ),
            children: const [
              TextSpan(text: "Find You "),
              TextSpan(
                text: "Dream\n",
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.w900,
                ),
              ),
              TextSpan(text: "Pet Here"),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          onBoardData[index].text,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
            fontSize: 15.5,
          ),
        ),
      ],
    );
  }
}

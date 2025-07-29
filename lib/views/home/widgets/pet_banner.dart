import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:posha/utils/helpers.dart';

import '../../../core/constants.dart';

class PetBanner extends StatelessWidget {
  const PetBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = THelperFunctions.screenSize(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: size.height * 0.2,
          width: size.width * 0.9,
          color: blueBackground,
          child: Stack(
            children: [
              Positioned(
                bottom: -20,
                right: -30,
                width: 100,
                height: 100,
                child: Transform.rotate(
                  angle: 12,
                  child: SvgPicture.asset(
                    'assets/svg/cat_paw.svg',
                    color: pawColor2,
                  ),
                ),
              ),
              Positioned(
                bottom: -35,
                left: -15,
                width: 100,
                height: 100,
                child: Transform.rotate(
                  angle: -12,
                  child: SvgPicture.asset(
                    'assets/svg/cat_paw.svg',
                    color: pawColor2,
                  ),
                ),
              ),
              Positioned(
                top: -40,
                left: 120,
                width: 110,
                height: 110,
                child: Transform.rotate(
                  angle: -16,
                  child: SvgPicture.asset(
                    'assets/svg/cat_paw.svg',
                    color: pawColor2,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 20,
                height: size.height * 0.18,
                child: Image.asset('assets/pets_image/cat1.png'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Join Our Animal\nLovers Community",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 18,
                        height: 1.1,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.amberAccent,
                      ),
                      child: Text(
                        "Join Now",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

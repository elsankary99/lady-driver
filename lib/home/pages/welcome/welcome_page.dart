import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/components/custom_botton.dart';
import '../../../core/constant/color_manger.dart';
import '../../../core/constant/image_manger.dart';
import '../../../core/router/router.dart';
import '../../../l10n/app_localizations.dart';

@RoutePage()
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: mediaQueryHeight * 0.150),
              //! Image
              Center(
                child: Image.asset(
                  height: mediaQueryHeight * 0.285,
                  width: mediaQueryWidth,
                  ImageManger.kOndoarding3,
                ),
              ),
              SizedBox(height: mediaQueryHeight * 0.175),
              Text(
                textAlign: TextAlign.end,
                appLocalizations.heyYou,
                style: textTheme.headlineLarge!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: mediaQueryHeight * 0.020),

              //! تسجيل الدخول
              GestureDetector(
                onTap: () => context.router.push(const LoginRoute()),
                child: CustomBotton(
                  borderColor: ColorManger.kPrimaryColor,
                  textThemeColor: ColorManger.kWhite,
                  text: appLocalizations.logIN,
                  color: ColorManger.kPrimaryColor,
                ),
              ),
              SizedBox(height: mediaQueryHeight * 0.028),

              //!  انشاء حساب
              GestureDetector(
                onTap: () => context.router.push(const CreateAnAccountRoute()),
                child: CustomBotton(
                  text: appLocalizations.createAccount,
                  textThemeColor: ColorManger.kPrimaryColor,
                  borderColor: ColorManger.kPrimaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

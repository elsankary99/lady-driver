import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lady_driver/provider/auth_provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../core/components/custom_botton.dart';
import '../../../core/components/custom_icon_change_language.dart';
import '../../../core/components/custom_textformfield.dart';
import '../../../core/components/custom_textformfield_password.dart';
import '../../../core/components/rich_text_privacy_policy.dart';
import '../../../core/constant/color_manger.dart';
import '../../../core/constant/svg_manger.dart';
import '../../../core/router/router.dart';
import '../../../l10n/app_localizations.dart';
import 'widget/rich_text_login_widget.dart';

@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool isSelected = false;

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  Future<void> sentOtp() async {
    if (formKey.currentState!.validate()) {
      final provider = ref.read(authNotifierProvider.notifier);
      final phone = phoneController.text.trim();
      log(phone);
      await provider.sendOtp(phone: phone);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authNotifierProvider);
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context)!;
    ref.listen(
      authNotifierProvider,
      (previous, next) {
        if (next is AuthFailure) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
              message: next.error,
            ),
          );
          return;
        }
        if (next is AuthSuccess) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.success(
              message: next.message,
            ),
          );
          return;
        }
      },
    );
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          //! loginToLadyDriver
          title: Text(
            appLocalizations.loginToLadyDriver,
            style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700),
          ),
          actions: const [
            //! Custom Icon Change Language
            CustomIconChangeLanguagePage(),
          ],
          forceMaterialTransparency: true,
          automaticallyImplyLeading: false,
        ),
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
            children: [
              SizedBox(height: mediaQueryHeight * 0.035),

              //! البريد الالكترونى
              CustomTextFormField(
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'this field cannot be empty';
                  }
                  return null;
                },
                controller: phoneController,
                suffixIcon: SvgManger.kMail,
                hintText: appLocalizations.email,
              ),
              SizedBox(height: mediaQueryHeight * 0.027),

              SizedBox(height: mediaQueryHeight * 0.027),
              //! هل نسيت كلمة المرور؟
              GestureDetector(
                onTap: () => context.router.push(const ForgetPasswordRoute()),
                child: Text(
                  textAlign: TextAlign.end,
                  appLocalizations.forgotYourPassword,
                  style: textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1.5,
                  ),
                ),
              ),
              SizedBox(height: mediaQueryHeight * 0.025),
              //!   CheckBox & سياسه الخصوصيه
              RichTextPrivacyPolicy(
                value: isSelected,
                onChanged: (value) {
                  setState(() {
                    isSelected = value!;
                  });
                },
              ),
              SizedBox(height: mediaQueryHeight * 0.016),
              //! تسجيل الدخول

              if (state is AuthLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else
                GestureDetector(
                  onTap: sentOtp,
                  child: CustomBotton(
                      text: appLocalizations.logIN,
                      color: isSelected
                          ? ColorManger.kPrimaryColor
                          : ColorManger.kBorderColor,
                      textThemeColor: ColorManger.kWhite,
                      borderColor: isSelected
                          ? ColorManger.kPrimaryColor
                          : ColorManger.kBorderColor),
                ),
              SizedBox(height: mediaQueryHeight * 0.045),
              //!RichTextLoginWidget
              RichTextLoginWidget(textTheme: textTheme),
            ],
          ),
        ),
      ),
    );
  }
}

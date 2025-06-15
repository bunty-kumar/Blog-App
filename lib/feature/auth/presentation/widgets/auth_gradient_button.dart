import 'package:blog_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../../core/common/widgets/loader.dart';

class AuthGradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;

  const AuthGradientButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.gradient1,
            AppColors.gradient2,
            // AppColors.gradient3,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.transparentColor,
          shadowColor: AppColors.transparentColor,
          fixedSize: Size(395, 55),
        ),
        child: isLoading
            ? Loader()
            : Text(
                text,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}

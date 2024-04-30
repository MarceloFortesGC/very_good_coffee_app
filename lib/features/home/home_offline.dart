import 'package:flutter/material.dart';
import 'package:very_good_coffee_app/features/shared/custom_colors.dart';
import 'package:very_good_coffee_app/features/shared/error_msg.dart';

class HomeOffline extends StatelessWidget {
  const HomeOffline({
    super.key,
    required this.onTapTryAgain,
    required this.loading,
  });

  final void Function() onTapTryAgain;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: CustomColors.secondaryColor,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(
                  Icons.cloud_off_outlined,
                  color: Colors.white,
                ),
                const VerticalDivider(),
                Expanded(
                  child: Text(
                    'You are offline. Please check your internet connection',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const VerticalDivider(),
                Visibility(
                  visible: !loading,
                  replacement: const Padding(
                    padding: EdgeInsets.all(6),
                    child: CircularProgressIndicator(),
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: CustomColors.primaryColor),
                    onPressed: onTapTryAgain,
                    child: const Text(
                      'Try Again',
                      textScaler: TextScaler.linear(.8),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ErrorMsg(),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

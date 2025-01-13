import 'package:flutter/material.dart';
import 'package:hidden_menu_challenge/core/utils/app_colors.dart';

import 'home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: SafeArea(
        bottom: false,
        child: HomeViewBody(),
      ),
    );
  }
}

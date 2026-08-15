import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/di.dart';
import '../../home/views/home_view.dart';
import '../view_models/auth_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!getIt.isRegistered<AuthViewModel>()) {
        return;
      }
      final vm = Provider.of<AuthViewModel>(context, listen: false);
      vm.checkSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

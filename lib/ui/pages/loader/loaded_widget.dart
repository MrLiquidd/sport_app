import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_app/ui/navigation/main_navigation.dart';
import 'package:travel_app/ui/pages/loader/loader_view_cubit.dart';
import 'package:travel_app/ui/theme/colors.dart';
import 'package:travel_app/ui/elements/app_large_text.dart';

class LoadedPage extends StatefulWidget {
  const LoadedPage({super.key});

  @override
  State<LoadedPage> createState() => _LoadedPageState();
}

class _LoadedPageState extends State<LoadedPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoaderViewCubit, LoaderViewCubitState>(
      listenWhen: (prev, current) => current != LoaderViewCubitState.unknown,
      listener: _onLoaderViewCubitStateChange,
      child: Container(
        color: AppColors.mainBackground,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('img/loaded.svg',
                width: 128,
                height: 128,
              ),
              const SizedBox(height: 24,),
              AppLargeText(text: "Спортивный. Я"),
            ],
          ),
        ),
      ),
    );
  }
  void _onLoaderViewCubitStateChange(BuildContext context ,LoaderViewCubitState state){
    final nextScreen = state == LoaderViewCubitState.authorized
        ? MainNavigationRouteNames.mainScreen
        : MainNavigationRouteNames.auth;
    Navigator.of(context).pushReplacementNamed(nextScreen);
  }
}

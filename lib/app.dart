import 'package:chat_app/config/app/app_cubit/app_cubit.dart';
import 'package:chat_app/config/app/connectivity_cubit/connectivity_cubit.dart';
import 'package:chat_app/config/themes/app_theme.dart';
import 'package:chat_app/core/helpers/shared_prefrences.dart';
import 'package:chat_app/core/screens/no_network_screen.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<AppCubit>()
                ..changeAppThemeMode('dark_mode',
                    sharedMode: CacheHelper().getData(key: 'mode') ?? false),
            ),
            BlocProvider(
              create: (context) => getIt<ConnectivityCubit>(),
            ),
          ],
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              final cubit = context.read<AppCubit>();
              return MaterialApp.router(
                theme: themeLight().copyWith(
                  textTheme: themeLight().textTheme.apply(
                        fontFamily:
                            FontFamilyHelper.getLocalizedFontFamily(context),
                      ),
                ),
                darkTheme: themeDark().copyWith(
                  textTheme: themeDark().textTheme.apply(
                        fontFamily:
                            FontFamilyHelper.getLocalizedFontFamily(context),
                      ),
                ),
                themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
                debugShowCheckedModeBanner: false,
                title: 'Flutter Task',
                routerConfig: AppRoutes.router,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                builder: (context, widget) {
                  return GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: Scaffold(
                      resizeToAvoidBottomInset: false, 
                      body: Stack(
                        children: [
                          if (widget != null) widget,

                          BlocBuilder<ConnectivityCubit, ConnectivityState>(
                            builder: (context, netState) {
                              if (netState is ConnectivityDisconnected) {
                                return const Positioned.fill(
                                  child: NoNetWorkScreen(),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

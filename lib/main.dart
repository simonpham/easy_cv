import 'package:easy_cv/constants/styles.dart';
import 'package:easy_cv/singleton_instances.dart';
import 'package:easy_cv/ui/pages/home_page.dart';
import 'package:easy_cv/ui/pages/profile_page.dart';
import 'package:easy_cv/ui/pages/sign_in_page.dart';
import 'package:easy_cv/ui/pages/sign_up_page.dart';
import 'package:easy_cv/utils/extensions.dart';
import 'package:easy_cv/view_models/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appViewModel.loadUser();
  runApp(EasyCv());
}

class EasyCv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppViewModel>(
      model: appViewModel,
      child: GestureDetector(
        onTap: () {
          /// to dismiss keyboard when tap outside of text field
          context.hideKeyboard();
        },
        child: MaterialApp(
          themeMode: ThemeMode.light,
          title: "Easy CV",
          theme: appTheme,
          darkTheme: darkTheme,
          routes: {
            "/": (_) => ProfilePage(profileName: "simon"),
//            "/": (_) => BeginPage(),
            HomePage.routeName: (_) => HomePage(),
            SignUpPage.routeName: (_) => SignUpPage(),
            SignInPage.routeName: (_) => SignInPage(),
          },
          onUnknownRoute: (RouteSettings settings) {
            final username = settings.name.substring(1);
            return MaterialPageRoute(
              builder: (context) => ProfilePage(
                profileName: username,
              ),
            );
          },
          initialRoute: "/",
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:art_core/art_core.dart';
import 'package:dependencies/dependencies.dart';


class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    Modular.to.addListener(() async {
      try {
        final page = Modular.to.path.split('/').lastWhere((element) => element != '');
        // await analytics.setCurrentScreen(screenName: page);
        // ignore: avoid_catches_without_on_clauses
      } catch (e) {
        log(e.toString());
      }
    });
  }

  T tripleResolverCallback<T extends Object>() {
    return Modular.get<T>();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
    );
  }
}

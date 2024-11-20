import 'package:art_core/art_core.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:features/domain/entity/clouds_entity.dart';
import 'package:features/domain/entity/main_data_entity.dart';
import 'package:features/domain/entity/sys_entity.dart';
import 'package:features/domain/entity/weather_data_entity.dart';
import 'package:features/domain/entity/weather_entity.dart';
import 'package:features/domain/entity/wind_entity.dart';
import 'package:features/presentation/blocs/weather_bloc.dart';
import 'package:features/presentation/pages/weather_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState> implements WeatherBloc {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
  });

  tearDown(() {
    Modular.destroy(); // Clean up Modular after each test
  });

  const cityName = 'New York';

  WeatherEntity mockWeatherEntity = const WeatherEntity(
    weather: [
      WeatherDataEntity(
        id: 1,
        main: 'Clear',
        description: 'clear sky',
        icon: '01d',
      ),
    ],
    main: MainDataEntity(temp: "20 \u00B0C", tempMin: "16 \u00B0C", tempMax: "24 \u00B0C", pressure: 1013, humidity: 82, grndLevel: 20, seaLevel: 10),
    visibility: 10000,
    wind: WindEntity(
      speed: 3.5,
      deg: 200,
    ),
    clouds: CloudsEntity(
      all: 20,
    ),
    dt: 1633035600,
    sys: SysEntity(
      type: 1,
      id: 8074,
      country: 'US',
      sunrise: 1633005600,
      sunset: 1633048800,
    ),
    timezone: -14400,
    id: 5128581,
    name: 'New York',
  );

  testWidgets('renders WeatherPage and handles interactions', (tester) async {
    // Set initial bloc state
    when(() => mockWeatherBloc.state).thenReturn(WeatherLoadingState());

    await tester.pumpWidget(
      ModularApp(
        module: ModuleForTesting(mockWeatherBloc),
        child: MaterialApp.router(
          routerDelegate: Modular.routerDelegate,
          routeInformationParser: Modular.routeInformationParser,
        ),
      ),
    );

    // Wait for the widget tree to settle
    await tester.pumpAndSettle();

    // Verify AppTextField is rendered
    expect(find.byType(AppTextField), findsOneWidget);

    // Simulate text entry and verify event dispatch
    await tester.enterText(find.byType(AppTextField), cityName);
    verify(() => mockWeatherBloc.add(FetchWeatherWithCityNameEvent(cityName: cityName))).called(1);

    // Verify clear icon functionality
    await tester.tap(find.byIcon(Icons.close));
    await tester.pump(); // Rebuild UI
    expect(find.byType(AppText), findsNothing);

    // Test loading state
    when(() => mockWeatherBloc.state).thenReturn(WeatherLoadingState());
    await tester.pump();
    expect(find.byType(AnimatedAppLoader), findsOneWidget);

    // Test error state
    const errorMessage = "An error occurred";
    when(() => mockWeatherBloc.state).thenReturn(WeatherErrorState(errorMessage: errorMessage));
    await tester.pump();
    expect(find.text(cityName), findsNothing);

    // Test success state
    when(() => mockWeatherBloc.state).thenReturn(WeatherSuccessState(weather: mockWeatherEntity, cityName: cityName));
    await tester.pump();
    expect(find.text(cityName), findsNothing);
  });
}

class ModuleForTesting extends Module {
  final WeatherBloc weatherBloc;

  ModuleForTesting(this.weatherBloc);

  @override
  List<Bind> get binds => [
        Bind.instance<WeatherBloc>(weatherBloc), // Bind the provided instance dynamically
      ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const WeatherPage()), // Route for WeatherPage
  ];
}

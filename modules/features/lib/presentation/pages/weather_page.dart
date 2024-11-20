import 'package:art_core/art_core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:features/presentation/blocs/weather_bloc.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final weatherBloc = Modular.get<WeatherBloc>();

  @override
  void initState() {
    weatherBloc.add(FetchWeatherFromCurrentLocationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF95D6EA)),
      body: Container(
        height: context.screenHeight,
        width: context.screenWidth,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // Start at the top
            end: Alignment.bottomCenter, // End at the bottom
            colors: [
              Color(0xFF95D6EA),
              Color(0xFF7BC7DD),
              Colors.white, // White color
            ],
          ),
        ),
        child: ListView(
          children: [
            AppTextField(
              fillColor: Colors.white,
              hint: "Search By City Name",
              onChanged: (value) {
                if (value.length >= 3) {
                  weatherBloc
                      .add(FetchWeatherWithCityNameEvent(cityName: value));
                }
              },
            ).marginSymmetric(vertical: 16),
            BlocBuilder<WeatherBloc, WeatherState>(
              bloc: weatherBloc,
              builder: (context, state) {
                if (state is WeatherLoadingState) {
                  return const Center(child: AnimatedAppLoader());
                } else if (state is WeatherErrorState) {
                  return Center(
                      child: AppText(
                    text: state.errorMessage,
                    maxLines: 10,
                  ));
                } else if (state is WeatherSuccessState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const AppText(text: "My Location", fontSize: 14),
                      AppText(text: state.weather.name!),
                      MyNetworkImageWidget(
                        state.weather.weather![0].icon!,
                      ),
                      AppText(text: state.weather.main!.temp.toString()),
                      AppText(
                        text: state.weather.weather![0].description!,
                        fontSize: 18,
                      ),
                      AppText(
                        text:
                            "H: ${state.weather.main!.tempMax.toString()} L: ${state.weather.main!.tempMin.toString()}",
                        fontSize: 14,
                      ),
                      AppText(
                        text:
                            "Wind Speed: ${state.weather.wind!.speed.toString()}",
                        fontSize: 14,
                      ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

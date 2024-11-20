import 'package:art_core/art_core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:features/presentation/blocs/weather_bloc.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherBloc = Modular.get<WeatherBloc>();
    TextEditingController controller = TextEditingController();

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
              controller: controller,
              fillColor: Colors.white,
              hint: "Search By City Name",
              suffixIcon: InkWell(
                onTap: () => controller.clear(),
                child: const Icon(Icons.close),
              ),
              onChanged: (value) {
                if (value.length >= 3) {
                  weatherBloc
                      .add(FetchWeatherWithCityNameEvent(cityName: value));
                }
              },
            ).marginSymmetric(vertical: 16),
            BlocBuilder<WeatherBloc, WeatherState>(
              bloc: weatherBloc..add(FetchWeatherFromCurrentLocationEvent()),
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

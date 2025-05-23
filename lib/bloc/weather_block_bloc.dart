import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_demo/data/my_data.dart';
//import 'package:weather_block_event.dart';

part 'weather_block_event.dart';
part 'weather_block_state.dart';


class WeatherBlockBloc extends Bloc<WeatherBlockEvent, WeatherBlockState> {
  WeatherBlockBloc() : super(WeatherBlockInitial()) {
    on<FetchWeather>((event, emit)  async {
			emit(WeatherBlocLoading());
      try {
				WeatherFactory wf = WeatherFactory(API_KEY, language: Language.ENGLISH);
				//Position position = await Geolocator.getCurrentPosition();
				Weather weather = await wf.currentWeatherByLocation(
			event.position.latitude, 
event.position.longitude,
				);
				emit(WeatherBlocSuccess(weather));
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}
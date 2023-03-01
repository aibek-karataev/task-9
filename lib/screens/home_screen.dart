import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/controller/global_controller.dart';
import 'package:weather/widgets/comfor_level.dart';
import 'package:weather/widgets/current_weather_widget.dart';
import 'package:weather/widgets/header_widget.dart';
import 'package:weather/widgets/hourly_data_widget.dart';
import '../utils/custom_colors.dart';
import '../widgets/daily_data_forecast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // call
  final GlobalController globalController = Get.put(
    GlobalController(),
    permanent: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => globalController.checkLoading().isTrue
              ? Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/clouds.png",
                          width: 150,
                          height: 150,
                        ),
                        const CircularProgressIndicator()
                      ]),
                )
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    const HeaderWidget(),
                    CurrentWeatherWidget(
                      weahterDataHourly:
                          globalController.getData().getHourlyData(),
                    ),
                    HourlyDataWidget(
                      weatherDataHourly:
                          globalController.getData().getHourlyData(),
                    ),
                    DailyDataForecast(
                      weatherDataDaily:
                          globalController.getData().getDailyData(),
                    ),
                    Container(
                      height: 1,
                      color: CustomColors.dividerLine,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                    ),
                    const SizedBox(height: 10),
                    ComforLevel(
                      weahterDataHourly:
                          globalController.getData().getHourlyData(),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

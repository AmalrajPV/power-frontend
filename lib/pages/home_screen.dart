// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:power_monitor/models/chart_models.dart';
import 'package:power_monitor/models/user_model.dart';
import 'package:power_monitor/services/auth_services.dart';
import 'package:power_monitor/services/user_provider.dart';
import 'package:power_monitor/utils/card1.dart';
import 'package:power_monitor/utils/user_card.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:power_monitor/constants.dart';
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as io;
import '../models/electrical_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedChartIndex = 0;

  ElectricalData data = ElectricalData(
      energy: 0.0, power: 0.0, voltage: 0.0, current: 0.0, frequency: 0.0);

  late List<TimeSeriesData> liveData;
  late List<ChartInfo> _chartInfoList;

  @override
  void initState() {
    super.initState();
    liveData = []; // Initialize the liveData list
    _chartInfoList = [
      ChartInfo(
        name: "Live Consumption",
        chart: SfCartesianChart(
          primaryXAxis: DateTimeAxis(),
          series: <LineSeries<TimeSeriesData, DateTime>>[
            LineSeries<TimeSeriesData, DateTime>(
              dataSource: liveData,
              xValueMapper: (TimeSeriesData sales, _) => sales.time,
              yValueMapper: (TimeSeriesData sales, _) => sales.value,
            ),
          ],
        ),
      ),
      ChartInfo(
        name: "Weekly Consumption",
        chart: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(),
          series: <ColumnSeries<PowerData, String>>[
            ColumnSeries<PowerData, String>(
              dataSource: <PowerData>[
                PowerData('Sun', 35),
                PowerData('Mon', 28),
                PowerData('Tue', 34),
                PowerData('Wed', 32),
                PowerData('Thu', 26),
                PowerData('Fri', 20),
                PowerData('Sat', 30),
              ],
              xValueMapper: (PowerData consumption, _) => consumption.day,
              yValueMapper: (PowerData consumption, _) =>
                  consumption.consumption,
              pointColorMapper: (PowerData consumption, _) {
                return PowerData.getColorForDay(consumption.day);
              },
            ),
          ],
        ),
      ),
    ];
    // establishWebSocketConnection();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    establishWebSocketConnection();
  }

  void establishWebSocketConnection() {
    final socket = io.io(socketUrl, <String, dynamic>{
      'transports': ['websocket'],
    });
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    UserProfile? userProfile = userProfileProvider.userProfile;

    socket.on('connect', (_) {
      socket.emit('join_verification', userProfile?.id ?? '');
    });

    socket.on('sensorUpdate', (jsonData) {
      final newData = ElectricalData.fromJson(jsonData);
      setState(() {
        data = newData;
        if (liveData.length >= 10) {
          liveData.removeAt(0); // Remove the oldest data point
        }
        liveData.add(TimeSeriesData(DateTime.now(), data.energy));
      });
    });

    socket.on('disconnect', (_) {});
  }

  void _previousChart() {
    if (_selectedChartIndex > 0) {
      setState(() {
        _selectedChartIndex--;
      });
    }
  }

  void _nextChart() {
    if (_selectedChartIndex < _chartInfoList.length - 1) {
      setState(() {
        _selectedChartIndex++;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> showLogoutConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Logout"),
              content: const Text("Are you sure you want to logout?"),
              actions: <Widget>[
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: const Text("Logout"),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    UserProfile? userProfile = userProfileProvider.userProfile;
    establishWebSocketConnection();
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage("assets/icons/icon.jpg"),
            ),
            SizedBox(
              width: 5,
            ),
            Text("Power Monitor")
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: const Icon(Icons.person)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/bills');
              },
              icon: const Icon(Icons.receipt_long_outlined)),
          IconButton(
              onPressed: () async {
                bool confirmed = await showLogoutConfirmationDialog(context);
                if (confirmed) {
                  await AuthService().logout();
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
              icon: const Icon(Icons.logout_rounded)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              UserCard(
                  userName: userProfile?.userName ?? "",
                  consumerId: userProfile?.consumerId ?? "",
                  isOnline: true,
                  isPowerOn: true,
                  onPowerToggle: (bool status) {}),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Live Data",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                children: [
                  CustomCard(
                    icon: Icons.bolt,
                    title: 'Voltage',
                    value: data.voltage,
                    unit: 'V',
                    color: Colors.blue,
                  ),
                  CustomCard(
                    icon: Icons.battery_charging_full,
                    title: 'Power',
                    value: data.power,
                    unit: 'W',
                    color: Colors.orange,
                  ),
                  CustomCard(
                    icon: Icons.flash_on,
                    title: 'Current',
                    value: data.current,
                    unit: 'A',
                    color: Colors.green,
                  ),
                  CustomCard(
                    icon: Icons.timeline,
                    title: 'Frequency',
                    value: data.frequency,
                    unit: 'Hz',
                    color: Colors.red,
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _selectedChartIndex > 0 ? _previousChart : null,
                    icon: const Icon(Icons.arrow_left),
                  ),
                  Text(
                    _chartInfoList[_selectedChartIndex].name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: _selectedChartIndex < _chartInfoList.length - 1
                        ? _nextChart
                        : null,
                    icon: const Icon(Icons.arrow_right),
                  ),
                ],
              ),
              _chartInfoList[_selectedChartIndex].chart,
            ],
          ),
        ),
      ),
    );
  }
}

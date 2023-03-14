import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'obj-c demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'tsc ios/obj-c demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel("samples.flutter.io/bluetooth");
  String _batteryLevel = 'Unknown battery level.';
  final flutterReactiveBle = FlutterReactiveBle();
  List<DiscoveredDevice> _foundBleUARTDevices = [];
  final _formKey = GlobalKey<FormState>();
  String? _testString;
  String? _uuid;

  @override
  void initState() {
    super.initState();
    _startPermission();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void refreshScreen() {
    setState(() {});
  }

  Future<void> _startPermission() async {
    PermissionStatus permission;
    if (Platform.isAndroid) {
      permission = await Permission.bluetooth.request();
      permission = await Permission.bluetoothAdvertise.request();
      permission = await Permission.bluetoothScan.request();
      permission = await Permission.location.request();
      permission = await Permission.locationWhenInUse.request();
      if (permission == PermissionStatus.granted) await _startScan();
    } else if (Platform.isIOS) {
      permission = await Permission.bluetooth.request();
      permission = await Permission.locationWhenInUse.request();
      permission = await Permission.locationAlways.request();
      permission = await Permission.location.request();
      if (permission == PermissionStatus.granted) await _startScan();
    }
  }

  Future<void> _startScan() async {
    await flutterReactiveBle.initialize();

    flutterReactiveBle.statusStream.listen(
      (status) async {
        switch (status) {
          case BleStatus.ready:
            await _scanForBlePeriperals();

            await showErrorDialog("Ble status is ready");
            break;
          case BleStatus.locationServicesDisabled:
            await showErrorDialog("Ble status is location Services disabled");
            break;
          case BleStatus.poweredOff:
            await showErrorDialog("Ble status is poweredOff");
            break;
          case BleStatus.unauthorized:
            await showErrorDialog("Ble status is unauthorized");
            break;
          case BleStatus.unsupported:
            await showErrorDialog("Ble status is unsupported");
            break;
          case BleStatus.unknown:
            await showErrorDialog("Ble status is unKnown");
            break;

          default:
            await showErrorDialog("Ble not implemented");
            break;
        }
      },
    );
  }

  Future<void> _scanForBlePeriperals() async {
    _foundBleUARTDevices = [];

    flutterReactiveBle.scanForDevices(
      withServices: [],
    ).listen(
      (device) {
        if (device.serviceUuids.isNotEmpty) {
          _foundBleUARTDevices.add(device);
        }
      },
      onError: (Object error) {
        showErrorDialog("ERROR while scanning:$error \n");
      },
      onDone: () {},
    );
    refreshScreen();
  }

  Future<void> showErrorDialog(String e) async => showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Bluetooth state'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(e),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Acknowledge'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );

  Future<void> alertDialogefailure() {
    final alertfailure = showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const CircleAvatar(
            backgroundColor: Colors.red,
            radius: 20,
            child: Icon(
              CupertinoIcons.multiply,
              color: Colors.white,
              size: 30,
            ),
          ),
          content: Text(
            'input string and try again',
            style: GoogleFonts.robotoMono(
              textStyle: const TextStyle(
                color: Color.fromARGB(255, 37, 37, 37),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      },
    );
    return alertfailure;
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      form.reset();
      return true;
    }
    return false;
  }

  Future<void> _getBatteryLevel(Map mapMac, Map mapPrint) async {
    if (Platform.isIOS) {
      String batteryLevel;
      try {
        final int result =
            await platform.invokeMethod('getBluetooth', [mapMac, mapPrint]);
        batteryLevel = 'Battery level at $result % .';
      } on PlatformException catch (e) {
        batteryLevel = "Failed to get battery level: '${e.message}'.";
      }

      setState(() {
        _batteryLevel = batteryLevel;
      });
    }
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      Map print = <String, dynamic>{"print": _testString};
      Map address = <String, dynamic>{"mac": _uuid};
      //adapter(address, print);
      _getBatteryLevel(address, print);
    } else {
      alertDialogefailure();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_uuid != null) Text('UUID SELECTED: $_uuid'),
            const SizedBox(
              height: 8,
            ),
            Text(
              _batteryLevel,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Discovered Devices',
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 175,
              child: ListView(
                children: List<Widget>.generate(
                  _foundBleUARTDevices.length,
                  (int index) {
                    return Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _uuid = _foundBleUARTDevices[index].id;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    _foundBleUARTDevices[index].name,
                                    style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    _foundBleUARTDevices[index].id,
                                    style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 6),
                                    child: Column(
                                      children: _foundBleUARTDevices[index]
                                          .serviceUuids
                                          .map((e) {
                                        return Text(
                                          e.toString(),
                                          style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                              color: Colors.blue,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: _buildForm(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      Expanded(
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'string to print';
            }
            return null;
          },
          initialValue: '',
          onSaved: (value) => _testString = value!.trim(),
          style: GoogleFonts.dmSans(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          decoration: InputDecoration(
            fillColor: Colors.white,
            label: Text(
              ' string ',
              style: GoogleFonts.dmSans(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            filled: true,
            hintText: 'string to print',
            labelStyle: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black12, width: 0.6),
              // borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5.0),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black12, width: 0.6),
              // borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5.0),
            ),
            focusColor: const Color.fromRGBO(243, 242, 242, 1),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black12, width: 0.5),
              borderRadius: BorderRadius.circular(5.0),
            ),
            hintStyle: GoogleFonts.dmSans(
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          maxLines: 1,
          textAlign: TextAlign.start,
        ),
      ),
      const SizedBox(
        width: 20,
      ),
      _buildPrintButton(),
    ];
  }

  Widget _buildPrintButton() {
    return Align(
      alignment: Alignment.center,
      child: MaterialButton(
        minWidth: 120,
        color: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(2.0),
          ),
        ),
        onPressed: () {
          _submit();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 15.0),
          child: Text(
            'Print',
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

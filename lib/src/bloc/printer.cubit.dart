import 'package:flutter/services.dart';

import 'package:bloc/bloc.dart';
import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:image/image.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrinterCubit extends Cubit<PrinterState> {
  PrinterCubit(this._preferences) : super(PrinterState());

  final SharedPreferences _preferences;

  final _logger = Logger();

  Future<void> savePrinter(String mac) async {
    await _preferences.setString('printer', mac);
  }

  Future<String?> getPrinter() async {
    return _preferences.getString('printer');
  }

  Future<void> getBluetooth() async {
    final List? bluetooths = await BluetoothThermalPrinter.getBluetooths;
    if (bluetooths != null) {
      emit(state.copyWith(devices: bluetooths));
    }
  }

  Future<bool> setConnect(String device) async {
    disconnect();
    final list = device.split("#");
    final mac = list[1];
    final name = list[0];
    final String? result = await BluetoothThermalPrinter.connect(mac);
    if (result == "true") {
      emit(state.copyWith(connected: true, printerName: name));
      savePrinter(mac);
      return true;
    }
    return false;
  }

  Future<void> disconnect() async {
    final String? isConnected = await BluetoothThermalPrinter.connectionStatus;

    if (isConnected == "true") {
      await BluetoothThermalPrinter.disconnect();
    }

    emit(state.copyWith(connected: false, printerName: ''));
  }

  Future<void> printTicket(List<int> bytes) async {
    String? isConnected = await BluetoothThermalPrinter.connectionStatus;
    if (isConnected == "true") {
      final result = await BluetoothThermalPrinter.writeBytes(bytes);
      _logger.i(result);
    } else {
      _logger.e("Not Connected");
    }
  }

  Future<void> getGraphicsTicket({
    required String licencePlate,
    required String location,
    required String type,
    required int fee,
  }) async {
    List<int> bytes = [];

    CapabilityProfile profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);

    final ByteData data = await rootBundle.load('assets/go_park.jpg');
    final Uint8List imgBytes = data.buffer.asUint8List();
    final Image? image = decodeImage(imgBytes);

    bytes += generator.imageRaster(image!);

    bytes += generator.feed(2);

    bytes += generator.qrcode('https://go-park.vercel.app', size: QRSize.Size8);

    bytes += generator.feed(1);

    bytes += generator.text(
      location,
      styles: const PosStyles(
        align: PosAlign.center,
        bold: true,
        height: PosTextSize.size1,
      ),
    );

    bytes += generator.feed(1);

    bytes += generator.text(
      'Placa: $licencePlate',
      styles: const PosStyles(
        align: PosAlign.center,
        bold: true,
        height: PosTextSize.size1,
      ),
    );

    bytes += generator.feed(1);

    bytes += generator.text('Tipo: $type',
        styles: const PosStyles(align: PosAlign.center));

    bytes += generator.feed(1);

    final date = DateTime.now();
    final formattedDate =
        '${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute}:${date.second}';

    bytes += generator.text('Fecha: $formattedDate',
        styles: const PosStyles(align: PosAlign.center));

    bytes += generator.feed(1);

    bytes += generator.text('Tarifa: \$$fee x hora',
        styles: const PosStyles(align: PosAlign.center));

    bytes += generator.feed(1);

    bytes += generator.text('Escanea el codigo QR para pagar',
        styles: const PosStyles(align: PosAlign.center));

    bytes += generator.cut();

    printTicket(bytes);
  }
}

class PrinterState {
  final bool connected;
  final List devices;
  final String printerName;

  PrinterState({
    this.connected = false,
    this.devices = const [],
    this.printerName = '',
  });

  PrinterState copyWith({
    bool? connected,
    List? devices,
    String? printerName,
  }) {
    return PrinterState(
      connected: connected ?? this.connected,
      devices: devices ?? this.devices,
      printerName: printerName ?? this.printerName,
    );
  }
}

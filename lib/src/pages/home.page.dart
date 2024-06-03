import 'package:client/src/bloc/spot.cubit.dart';
import 'package:client/src/data/models/spot.model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:client/src/bloc/authentication.cubit.dart';
import 'package:client/src/bloc/parking.cubit.dart';
import 'package:client/src/bloc/printer.cubit.dart';
import 'package:client/src/bloc/vehicle.type.cubit.dart';
import 'package:client/src/data/models/parking.model.dart';
import 'package:client/src/data/models/vehicle.type.model.dart';
import 'package:client/src/utils/extension.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        shrinkWrap: true,
        slivers: [
          SliverAppBar.medium(
            floating: true,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  context.read<AuthenticationCubit>().logout();
                  context.navigator.pushNamedAndRemoveUntil(
                    '/login',
                    (route) => false,
                  );
                },
              ),
            ],
          ),
          const SliverToBoxAdapter(
            child: _GoParkLogo(),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 16),
                const _SelectPrinterCard(),
                const _VehiclePlateForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GoParkLogo extends StatelessWidget {
  const _GoParkLogo();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/go_park.jpg',
      width: 200,
      height: 100,
    );
  }
}

class _SelectPrinterCard extends StatelessWidget {
  const _SelectPrinterCard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrinterCubit, PrinterState>(
      builder: (context, state) {
        if (state.connected) {
          return Card(
            margin: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                ListTile(
                  onTap: () => context.navigator.pushNamed('/printer'),
                  title: Text(
                    'Impresora conectada',
                    style: context.titleMedium,
                  ),
                  subtitle: Text(
                    'Impresora: ${state.printerName}',
                    style: context.bodySmall,
                  ),
                  trailing: Icon(
                    Icons.print,
                    color: context.primaryColor,
                  ),
                ),
              ],
            ),
          );
        }

        return Card(
          elevation: 4,
          margin: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              ListTile(
                onTap: () => context.navigator.pushNamed('/printer'),
                title: Text(
                  'Seleccionar impresora',
                  style: context.titleMedium,
                ),
                subtitle: Text(
                  'Seleccione la impresora a utilizar',
                  style: context.bodySmall,
                ),
                trailing: Icon(
                  Icons.print,
                  color: context.primaryColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _VehiclePlateForm extends StatefulWidget {
  const _VehiclePlateForm();

  @override
  State<_VehiclePlateForm> createState() => _VehiclePlateFormState();
}

class _VehiclePlateFormState extends State<_VehiclePlateForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _vehiclePlateController;

  String _vehicleType = '';
  String _parkingLocation = '';

  late List<String> _vehicleTypes;
  late List<String> _parkingLocations;

  @override
  void initState() {
    super.initState();
    _vehiclePlateController = TextEditingController();

    _vehicleTypes = context
        .read<VehicleTypeCubit>()
        .state
        .vehicleTypes
        .map((VehicleType value) => value.name)
        .toList();

    _parkingLocations = context
        .read<ParkingCubit>()
        .state
        .parkings
        .map((Parking value) => value.location)
        .toList();

    _vehicleType = _vehicleTypes.first;
    _parkingLocation = _parkingLocations.first;
  }

  @override
  void dispose() {
    _vehiclePlateController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            BlocBuilder<ParkingCubit, ParkingState>(
              builder: (context, state) {
                final parking = state.parkings
                    .where((Parking element) =>
                        element.location == _parkingLocation)
                    .first;

                return Row(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              'Lugares habilitados',
                              style: context.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${parking.capacity}',
                              style: context.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              'Lugares disponibles',
                              style: context.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${parking.available}',
                              style: context.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _parkingLocation,
              decoration: const InputDecoration(
                labelText: 'Ubicación del parqueo',
              ),
              items: _parkingLocations.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: context.bodyMedium),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _parkingLocation = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _vehicleType,
              decoration: const InputDecoration(
                labelText: 'Tipo de vehículo',
              ),
              items: _vehicleTypes.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: context.bodyMedium),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _vehicleType = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              maxLength: 7,
              controller: _vehiclePlateController,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              decoration: const InputDecoration(
                labelText: 'Placa del vehículo',
              ),
              onChanged: (value) {
                _vehiclePlateController.text = value.toUpperCase();
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Ingrese la placa del vehículo';
                }
                return null;
              },
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    context.showSnackBar(message: 'Imprimiendo ticket');

                    final String licencePlateP1 = _vehiclePlateController.text
                        .toUpperCase()
                        .substring(0, 3);

                    final String licencePlateP2 = _vehiclePlateController.text
                        .toUpperCase()
                        .substring(3, 6);

                    final licenece = '$licencePlateP1-$licencePlateP2';

                    _vehiclePlateController.clear();

                    final vType = context
                        .read<VehicleTypeCubit>()
                        .state
                        .vehicleTypes
                        .where((VehicleType element) =>
                            element.name == _vehicleType)
                        .first;

                    final parking = context
                        .read<ParkingCubit>()
                        .state
                        .parkings
                        .where((Parking element) =>
                            element.location == _parkingLocation)
                        .first;

                    context.read<PrinterCubit>().getGraphicsTicket(
                          licencePlate: licenece,
                          type: _vehicleType,
                          location: _parkingLocation,
                          fee: vType.fee,
                        );

                    context.read<SpotCubit>().createSpot(
                          Spot(
                            vehicleType: vType.id,
                            parking: parking.id,
                            licensePlate: licenece,
                            paymentStatus: 'UNPAID',
                            arrivalTime: DateTime.now(),
                          ),
                        );

                    context.read<ParkingCubit>().getParkings();
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Imprimir ticket',
                      style: context.titleLarge,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

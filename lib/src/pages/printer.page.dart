import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:client/src/bloc/printer.cubit.dart';

class PrinterPage extends StatefulWidget {
  const PrinterPage({super.key});

  @override
  State<PrinterPage> createState() => _PrinterPageState();
}

class _PrinterPageState extends State<PrinterPage> {
  @override
  void initState() {
    context.read<PrinterCubit>().getBluetooth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _PrinterView();
  }
}

class _PrinterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GoPark')),
      body: const _DevicesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<PrinterCubit>().getBluetooth(),
        child: const Icon(Icons.search),
      ),
    );
  }
}

class _DevicesList extends StatelessWidget {
  const _DevicesList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrinterCubit, PrinterState>(
      builder: (context, state) {
        if (state.devices.isNotEmpty) {
          return ListView.builder(
            itemCount: state.devices.length,
            itemBuilder: (context, index) {
              final select = state.devices[index];
              final list = select.split("#");
              final mac = list[1];
              final name = list[0];
              return Card(
                child: ListTile(
                  trailing: state.connected && state.printerName == name
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () async =>
                      await context.read<PrinterCubit>().setConnect(select),
                  leading: const Icon(Icons.print),
                  title: Text('$name'),
                  subtitle: Text('$mac'),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text("No se encontraron impresoras bluetooth"),
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slot_machine_app/presentation/slot_machine_screen.dart';
import 'package:flutter_slot_machine_app/presentation/slot_machine_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const SlotMachineApp());
}

class SlotMachineApp extends StatelessWidget {
  const SlotMachineApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (_) => SlotMachineViewModel(),
        child: const SlotMachineScreen(),
      ),
    );
  }
}

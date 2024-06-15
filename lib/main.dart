import 'package:flutter/material.dart';
import 'package:flutter_slot_machine_app/presentation/slot_machine_screen.dart';

void main() {
  runApp(const SlotMachineApp());
}

class SlotMachineApp extends StatelessWidget {
  const SlotMachineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SlotMachineScreen(),
    );
  }
}

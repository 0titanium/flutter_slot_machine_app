import 'package:flutter/material.dart';

class SlotMachineScreen extends StatefulWidget {
  const SlotMachineScreen({super.key});

  @override
  State<SlotMachineScreen> createState() => _SlotMachineScreenState();
}

class _SlotMachineScreenState extends State<SlotMachineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.monetization_on_outlined),
      ),
      body: Stack(children: [
        Image.asset(
          'assets/images/slot-machine1.png',
          fit: BoxFit.fill,
        ),
        GestureDetector(
          child: Image.asset('assets/images/slot-machine2.png'),
          onTap: () {

          },
        ),
      ]),
    );
  }
}

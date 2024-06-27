import 'package:flutter/material.dart';
import 'package:flutter_slot_machine_app/presentation/slot_machine_view_model.dart';
import 'package:provider/provider.dart';

class SlotMachineScreen extends StatefulWidget {
  const SlotMachineScreen({super.key});

  @override
  State<SlotMachineScreen> createState() => _SlotMachineScreenState();
}

class _SlotMachineScreenState extends State<SlotMachineScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SlotMachineViewModel>();
    if (!viewModel.isInit) {
      viewModel.setGameMoney();
      viewModel.setReel();
    }

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.monetization_on_outlined),
        title: Text(viewModel.gameMoney ?? '1000'),
      ),
      body: SafeArea(
        child: Stack(children: [
          Image.asset(
            'assets/images/slot-machine1.png',
          ),
          Positioned(
            top: 135,
            left: 100,
            width: 70,
            child: Image.asset(viewModel.firstReelSymbol ?? ''),
          ),
          Positioned(
            top: 135,
            left: 163,
            width: 70,
            child: Image.asset(viewModel.secondReelSymbol ?? ''),
          ),
          Positioned(
            top: 135,
            left: 227,
            width: 70,
            child: Image.asset(viewModel.thirdReelSymbol ?? ''),
          ),
          GestureDetector(
            child: viewModel.isPulled
                ? Image.asset('assets/images/slot-machine3.png')
                : Image.asset('assets/images/slot-machine2.png'),
            onTap: () {
              viewModel.pullLever();
              viewModel.setReel();
            },
          ),
        ]),
      ),
    );
  }
}

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
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.monetization_on_outlined),
                    Text(viewModel.gameMoney ?? '1000'),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
                child: ListWheelScrollView.useDelegate(
                  physics: const NeverScrollableScrollPhysics(),
                  itemExtent: 80,
                  controller: viewModel.controllers[0],
                  childDelegate: ListWheelChildLoopingListDelegate(
                    children: viewModel.symbolList
                        .map((e) => Image.asset(e))
                        .toList(),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                child: ListWheelScrollView.useDelegate(
                  physics: const NeverScrollableScrollPhysics(),
                  itemExtent: 80,
                  controller: viewModel.controllers[1],
                  childDelegate: ListWheelChildLoopingListDelegate(
                    children: viewModel.symbolList
                        .map((e) => Image.asset(e))
                        .toList(),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                child: ListWheelScrollView.useDelegate(
                  physics: const NeverScrollableScrollPhysics(),
                  itemExtent: 80,
                  controller: viewModel.controllers[2],
                  childDelegate: ListWheelChildLoopingListDelegate(
                    children: viewModel.symbolList
                        .map((e) => Image.asset(e))
                        .toList(),
                  ),
                ),
              ),
              Container(
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    viewModel.spinWheels();
                  },
                  child: const Text('Spin'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

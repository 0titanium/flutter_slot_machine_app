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
      // appBar: AppBar(
      //   leading: const Icon(Icons.monetization_on_outlined),
      //   title: Text(viewModel.gameMoney ?? '1000'),
      // ),
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: Text('sampleText'),
              ),
              SizedBox(
                width: 100,
                child: ListWheelScrollView.useDelegate(
                  physics: const BouncingScrollPhysics(),
                  itemExtent: 80,
                  controller: ScrollController(),
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
                  physics: const BouncingScrollPhysics(),
                  itemExtent: 80,
                  controller: ScrollController(),
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
                  physics: const BouncingScrollPhysics(),
                  itemExtent: 80,
                  controller: ScrollController(),
                  childDelegate: ListWheelChildLoopingListDelegate(
                    children: viewModel.symbolList
                        .map((e) => Image.asset(e))
                        .toList(),
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: Text('sampleText'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

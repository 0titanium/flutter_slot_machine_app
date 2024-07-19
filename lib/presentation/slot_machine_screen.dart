import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slot_machine_app/presentation/slot_machine_view_model.dart';
import 'package:provider/provider.dart';

class SlotMachineScreen extends StatefulWidget {
  const SlotMachineScreen({super.key});

  @override
  State<SlotMachineScreen> createState() => _SlotMachineScreenState();
}

class _SlotMachineScreenState extends State<SlotMachineScreen> {
  late List<ScrollController> controllers;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(3, (_) => ScrollController());
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void spinWheels() async {
    final random = Random();
    const baseSpinDuration = Duration(milliseconds: 3000);
    const delayBetweenStarts = Duration(milliseconds: 100);

    const itemExtent = 80.0;
    const totalItems = 28;

    List<Future> spinFutures = [];

    for (int i = 0; i < 3; i++) {
      final spinDuration = baseSpinDuration + Duration(milliseconds: 500 * i);

      // 각 휠의 스핀 시작을 지연
      await Future.delayed(delayBetweenStarts);

      spinFutures
          .add(spinWheel(i, spinDuration, itemExtent, totalItems, random));
    }

    // 모든 휠의 스핀이 완료될 때까지 기다림
    await Future.wait(spinFutures);
  }

  Future<void> spinWheel(int index, Duration spinDuration, double itemExtent,
      int totalItems, Random random) async {
    // 최소 회전 수 설정 (예: 5바퀴)
    const minRevolutions = 5;

    // 추가 랜덤 회전 (0-2 바퀴)
    final additionalRevolutions = random.nextInt(3);

    // 총 회전 거리 계산 (아이템 높이의 배수가 되도록)
    final totalSpins = (minRevolutions + additionalRevolutions) * totalItems +
        random.nextInt(totalItems);
    final totalDistance = totalSpins * itemExtent;

    // 현재 위치에서 시작하여 계산된 거리만큼 이동
    final startPosition = controllers[index].position.pixels;
    final endPosition = startPosition + totalDistance;

    // 애니메이션 실행
    await controllers[index].animateTo(
      endPosition,
      duration: spinDuration,
      curve: Curves.easeInOut,
    );

    // 중앙에 정확히 멈추도록 최종 위치 조정
    final finalPosition = (endPosition / itemExtent).round() * itemExtent;
    await controllers[index].animateTo(
      finalPosition,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SlotMachineViewModel>();
    viewModel.setGameMoney();

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
                    Text(viewModel.gameMoney!),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
                child: ListWheelScrollView.useDelegate(
                  physics: const NeverScrollableScrollPhysics(),
                  itemExtent: 80,
                  controller: controllers[0],
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
                  controller: controllers[1],
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
                  controller: controllers[2],
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
                  onPressed: spinWheels,
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

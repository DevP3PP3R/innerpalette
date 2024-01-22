import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';

import '../provider/color_provider.dart';
import '../provider/img_provider.dart';

class SucessPage extends StatefulWidget {
  const SucessPage({super.key});

  @override
  _SucessPageState createState() => _SucessPageState();
}

class _SucessPageState extends State<SucessPage> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    _confettiController.play();
    super.initState();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final colorProvider = Provider.of<ColorProvider>(context);
    final imgProvider = Provider.of<ImgProvider>(context);
    final pickedColor = colorProvider.pickedColor;
    final selectedColor = colorProvider.selectedColor;
    void clearAllProvider() {
      colorProvider.clearPickedColor();
      colorProvider.clearSelectedColor();
      imgProvider.clearPreviewImage();
      colorProvider.clearSuccess();
    }

    return SizedBox(
      height: deviceWidth,
      child: Dialog(
        child: Stack(
          children: [
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: 0,
              maxBlastForce: 5,
              minBlastForce: 2,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.05,
            ),
            ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: deviceWidth * 0.2,
                      height: deviceWidth * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: pickedColor,
                      ),
                    ),
                    Container(
                      width: deviceWidth * 0.2,
                      height: deviceWidth * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: selectedColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  '축하합니다!\n 조금은 진정이 되셨나요?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    clearAllProvider();
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      '다시하기',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

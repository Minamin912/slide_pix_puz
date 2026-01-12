import 'package:flutter/material.dart';

class TutorialOverlay extends StatelessWidget {
  final int step;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const TutorialOverlay({
    super.key,
    required this.step,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onNext,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: [
          // Semi-transparent background
          Container(color: Colors.black54),
          
          // Content based on step
          if (step == 0) _buildCorrespondenceStep(context),
          if (step == 1) _buildSlideStep(context),
          if (step == 2) _buildChangeStep(context),
          if (step == 3) _buildGoalStep(context),


          // Skip button
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: onSkip,
              child: Text(
                "スキップ",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          
          // Tap to continue instruction
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Text(
              "タップして次へ",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  // 1. 上部の赤字と、アシストの数字が対応していることの説明
  Widget _buildCorrespondenceStep(BuildContext context) {
    return Positioned(
      top: 100,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Icon(Icons.arrow_upward, color: Colors.orangeAccent, size: 50),
          SizedBox(height: 10),
          Text(
            "数字の対応",
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "ライン上の数字と、上の「赤い数字」は対応しています。\n\n例えば左端はブロックが1個なので『1』、\n右端は4個重なっているので『4』と表示されています。",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  // 2. 青い棒は横にスライドできることの説明（最下段を右へ）
  Widget _buildSlideStep(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "スライド操作",
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Icon(Icons.swipe_right, color: Colors.blueAccent, size: 80),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "一番下のブロックを\n右端までスライドさせてみましょう！",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
                ),
              ),
            ],
          ),
        ),
        // 下部に矢印を表示（大体の位置）
        Positioned(
          bottom: 150,
          left: 50,
          right: 50,
          child: Icon(Icons.arrow_forward, color: Colors.white70, size: 40),
        ),
      ],
    );
  }

  // 3. スライドしたら数値がどのように変わったかの説明
  Widget _buildChangeStep(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.looks_one, color: Colors.amberAccent, size: 60),
          SizedBox(height: 20),
          Text(
            "数字の変化",
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "動かした列の数字が変わりましたね？\nこれが現在のブロック数です。\n\nこのように、スライドさせて\n縦の数を調整していきます。",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  // 4. 最終的に黒字と赤字の値を合わせる説明
  Widget _buildGoalStep(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.flag, color: Colors.redAccent, size: 80),
          SizedBox(height: 20),
          Text(
            "クリア条件",
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "最終的に、上の「黒い数字（ゴール）」と\n「赤い数字（現在）」がすべて一致するように\nブロックを動かしましょう！",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

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
          if (step == 0) _buildHintStep(context),
          if (step == 1) _buildSlideStep(context),
          if (step == 2) _buildWinStep(context),

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

  Widget _buildHintStep(BuildContext context) {
    return Positioned(
      top: 100, // Approximate position near hints
      left: 0,
      right: 0,
      child: Column(
        children: [
          Icon(Icons.arrow_upward, color: Colors.white, size: 40),
          SizedBox(height: 10),
          Text(
            "上の数字に注目",
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            "その列にあるブロックの数を表しています",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildSlideStep(BuildContext context) {
    return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "青いバーをスライド",
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Icon(Icons.swipe, color: Colors.white, size: 60),
            SizedBox(height: 10),
            Text(
              "左右に動かして位置を合わせます",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      );
  }

  Widget _buildWinStep(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_outline, color: Colors.greenAccent, size: 80),
          SizedBox(height: 20),
          Text(
            "数字とピタリ賞！",
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            "すべての列で数字とブロック数が合えばクリア！",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

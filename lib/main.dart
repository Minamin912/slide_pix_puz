import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'tutorial_overlay.dart';
import 'assist_overlay_painter.dart';

void main() => runApp(const SlidePicrossApp());

class SlidePicrossApp extends StatelessWidget {
  const SlidePicrossApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slide Picross',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5E6D3), // Beige background
      ),
      home: const TitleScreen(),
    );
  }
}

// ステージデータを保持するクラス
class StageData {
  final String title;
  final List<List<int>> targetGrid;

  const StageData({required this.title, required this.targetGrid});

  int get gridSizeX => targetGrid[0].length;
  int get gridSizeY => targetGrid.length;
}

// Global Stage Definition
const List<StageData> allStages = [
  // Practice 4x4
  StageData(
    title: "Level 1: Practice",
    targetGrid: [
      [1, 1, 1, 1],
      [0, 1, 1, 1],
      [0, 0, 1, 1],
      [0, 0, 0, 1],
    ],
  ),
  StageData(
    title: "Level 2: Square",
    targetGrid: [
      [0, 0, 0, 0],
      [0, 1, 1, 0],
      [0, 1, 1, 0],
      [0, 0, 0, 0],
    ],
  ),
  StageData(
    title: "Level 3: Stripes",
    targetGrid: [
      [0, 1, 0, 1],
      [0, 1, 0, 1],
      [0, 1, 0, 1],
      [0, 1, 0, 1],
    ],
  ),
  StageData(
    title: "Level 4: Frame", 
    targetGrid: [
      [1, 1, 1, 1],
      [1, 0, 0, 1],
      [1, 0, 0, 1],
      [1, 1, 1, 1],
    ],
  ),
  StageData(
    title: "Level 5: L-Shape",
    targetGrid: [
      [0, 0, 0, 1],
      [0, 0, 0, 1],
      [0, 0, 0, 1],
      [1, 1, 1, 1],
    ],
  ),
  // 5x5 Levels
  StageData(
    title: "Level 6: Basic 5x5",
    targetGrid: [
      [0, 1, 1, 1, 0],
      [1, 0, 0, 1, 0],
      [1, 1, 1, 1, 1],
      [1, 0, 1, 1, 0],
      [0, 0, 0, 1, 1],
    ],
  ),
  StageData(
    title: "Level 7: Smiley",
    targetGrid: [
      [0, 1, 0, 1, 0],
      [0, 1, 0, 1, 0],
      [0, 0, 0, 0, 0],
      [1, 0, 0, 0, 1],
      [0, 1, 1, 1, 0],
    ],
  ),
  StageData(
    title: "Level 8: Heart",
    targetGrid: [
      [0, 1, 0, 1, 0],
      [1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1],
      [0, 1, 1, 1, 0],
      [0, 0, 1, 0, 0],
    ],
  ),
  StageData(
    title: "Level 9: Plus",
    targetGrid: [
      [0, 0, 1, 0, 0],
      [0, 0, 1, 0, 0],
      [1, 1, 1, 1, 1],
      [0, 0, 1, 0, 0],
      [0, 0, 1, 0, 0],
    ],
  ),
  StageData(
    title: "Level 10: Temple",
    targetGrid: [
      [0, 1, 1, 1, 0],
      [0, 1, 1, 1, 0],
      [1, 1, 1, 1, 1], // Anchor
      [0, 1, 1, 1, 0],
      [0, 1, 0, 1, 0],
    ],
  ),
  StageData(
    title: "Level 11: Triangle",
    targetGrid: [
      [0, 0, 1, 0, 0],
      [0, 0, 1, 0, 0], // Tip
      [0, 1, 1, 1, 0],
      [0, 1, 1, 1, 0],
      [1, 1, 1, 1, 1], // Base
    ],
  ),
  StageData(
    title: "Level 12: Stairs (Right)",
    targetGrid: [
      [0, 0, 0, 0, 1],
      [0, 0, 0, 1, 1],
      [0, 0, 1, 1, 1],
      [0, 1, 1, 1, 1],
      [1, 1, 1, 1, 1],
    ],
  ),
  StageData(
    title: "Level 13: Letter T",
    targetGrid: [
      [1, 1, 1, 1, 1],
      [0, 0, 1, 0, 0],
      [0, 0, 1, 0, 0],
      [0, 0, 1, 0, 0],
      [0, 0, 1, 0, 0],
    ],
  ),
  StageData(
    title: "Level 14: Letter H",
    targetGrid: [
      [1, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
      [1, 1, 1, 1, 1],
      [1, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
    ],
  ),
  StageData(
    title: "Level 15: Reverse E",
    targetGrid: [
      [1, 1, 1, 1, 1],
      [0, 0, 0, 0, 1],
      [0, 1, 1, 1, 1],
      [0, 0, 0, 0, 1],
      [1, 1, 1, 1, 1],
    ],
  ),
  StageData(
    title: "Level 16: Letter U",
    targetGrid: [
      [1, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
      [1, 1, 1, 1, 1],
    ],
  ),
  StageData(
    title: "Level 17: Creeper",
    targetGrid: [
      [0, 0, 0, 0, 0],
      [0, 1, 0, 1, 0],
      [0, 0, 1, 0, 0],
      [0, 1, 1, 1, 0],
      [0, 1, 0, 1, 0],
    ],
  ),
  StageData(
    title: "Level 18: Invader",
    targetGrid: [
      [0, 0, 1, 0, 0],
      [0, 1, 1, 1, 0],
      [1, 1, 0, 1, 1],
      [1, 1, 1, 1, 1],
      [1, 0, 1, 0, 1],
    ],
  ),
  // 6x6 Levels (19-28)
  StageData(
    title: "Level 19: Pyramid",
    targetGrid: [
      [0, 0, 1, 1, 0, 0],
      [0, 0, 1, 1, 0, 0],
      [0, 1, 1, 1, 1, 0],
      [0, 1, 1, 1, 1, 0],
      [1, 1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 1],
    ],
  ),
  StageData(
    title: "Level 20: Hourglass",
    targetGrid: [
      [1, 1, 1, 1, 1, 1],
      [0, 1, 1, 1, 1, 0],
      [0, 0, 1, 1, 0, 0],
      [0, 0, 1, 1, 0, 0],
      [0, 1, 1, 1, 1, 0],
      [1, 1, 1, 1, 1, 1],
    ],
  ),
  StageData(
    title: "Level 21: House",
    targetGrid: [
      [0, 0, 1, 1, 0, 0],
      [0, 1, 1, 1, 1, 0],
      [1, 1, 1, 1, 1, 1],
      [0, 1, 1, 1, 1, 0],
      [0, 1, 0, 0, 1, 0],
      [0, 1, 1, 1, 1, 0],
    ],
  ),
  StageData(
    title: "Level 22: Fish",
    targetGrid: [
      [0, 0, 1, 0, 0, 0],
      [0, 1, 1, 1, 0, 0],
      [1, 1, 1, 1, 1, 0],
      [1, 1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 0],
      [0, 1, 1, 1, 0, 0],
    ],
  ),
  StageData(
    title: "Level 23: Boat",
    targetGrid: [
      [0, 0, 0, 1, 0, 0],
      [0, 0, 1, 1, 0, 0],
      [0, 1, 1, 1, 0, 0],
      [1, 1, 1, 1, 0, 0],
      [1, 1, 1, 1, 1, 1],
      [0, 1, 1, 1, 1, 0],
    ],
  ),
  StageData(
    title: "Level 24: Chair",
    targetGrid: [
      [0, 1, 0, 0, 0, 0],
      [0, 1, 0, 0, 0, 0],
      [0, 1, 1, 1, 1, 0],
      [0, 1, 1, 1, 1, 0],
      [0, 1, 0, 0, 1, 0],
      [0, 1, 0, 0, 1, 0],
    ],
  ),
  StageData(
    title: "Level 25: Key",
    targetGrid: [
      [0, 0, 1, 1, 0, 0],
      [0, 1, 1, 1, 1, 0],
      [0, 0, 1, 1, 0, 0],
      [0, 0, 1, 1, 0, 0],
      [0, 0, 1, 1, 0, 0],
      [0, 1, 1, 1, 1, 0],
    ],
  ),
  StageData(
    title: "Level 26: Lock",
    targetGrid: [
      [0, 1, 1, 1, 1, 0],
      [1, 0, 0, 0, 0, 1],
      [1, 1, 1, 1, 1, 1],
      [1, 1, 0, 0, 1, 1],
      [1, 1, 0, 0, 1, 1],
      [1, 1, 1, 1, 1, 1],
    ],
  ),
  StageData(
    title: "Level 27: Six",
    targetGrid: [
      [0, 0, 1, 1, 1, 1],
      [0, 1, 1, 0, 0, 0],
      [1, 1, 0, 0, 0, 0],
      [1, 1, 1, 1, 1, 0],
      [1, 1, 0, 0, 1, 1],
      [0, 1, 1, 1, 1, 0],
    ],
  ),
  StageData(
    title: "Level 28: Steps",
    targetGrid: [
      [0, 0, 0, 0, 0, 1],
      [0, 0, 0, 0, 1, 1],
      [0, 0, 0, 1, 1, 1],
      [0, 0, 1, 1, 1, 1],
      [0, 1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 1],
    ],
  ),
  // 7x7 Levels (29-38)
  StageData(
    title: "Level 29: Big Heart",
    targetGrid: [
      [0, 1, 1, 0, 1, 1, 0],
      [1, 1, 1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 1, 1],
      [0, 1, 1, 1, 1, 1, 0],
      [0, 0, 1, 1, 1, 0, 0],
      [0, 0, 0, 1, 0, 0, 0],
    ],
  ),
  StageData(
    title: "Level 30: Sword",
    targetGrid: [
      [0, 0, 0, 1, 0, 0, 0],
      [0, 0, 1, 1, 1, 0, 0],
      [0, 0, 0, 1, 0, 0, 0],
      [0, 0, 0, 1, 0, 0, 0],
      [0, 1, 1, 1, 1, 1, 0],
      [0, 0, 0, 1, 0, 0, 0],
      [0, 0, 0, 1, 0, 0, 0],
    ],
  ),
  StageData(
    title: "Level 31: Shield",
    targetGrid: [
      [1, 1, 1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 1, 1],
      [1, 1, 0, 0, 0, 1, 1],
      [1, 1, 0, 0, 0, 1, 1],
      [0, 1, 1, 0, 1, 1, 0],
      [0, 0, 1, 1, 1, 0, 0],
      [0, 0, 0, 1, 0, 0, 0],
    ],
  ),
  StageData(
    title: "Level 32: Potion",
    targetGrid: [
      [0, 0, 0, 1, 0, 0, 0],
      [0, 0, 1, 1, 1, 0, 0],
      [0, 0, 0, 1, 0, 0, 0],
      [0, 0, 1, 1, 1, 0, 0],
      [0, 1, 1, 1, 1, 1, 0],
      [0, 1, 1, 1, 1, 1, 0],
      [0, 0, 1, 1, 1, 0, 0],
    ],
  ),
  StageData(
    title: "Level 33: Skull",
    targetGrid: [
      [0, 0, 1, 1, 1, 0, 0],
      [0, 1, 1, 1, 1, 1, 0],
      [1, 1, 0, 1, 0, 1, 1],
      [1, 1, 1, 1, 1, 1, 1],
      [0, 1, 1, 1, 1, 1, 0],
      [0, 0, 1, 0, 1, 0, 0],
      [0, 0, 1, 0, 1, 0, 0],
    ],
  ),
  StageData(
    title: "Level 34: Ghost",
    targetGrid: [
      [0, 0, 1, 1, 1, 0, 0],
      [0, 1, 1, 1, 1, 1, 0],
      [1, 1, 0, 1, 0, 1, 1],
      [1, 1, 1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 1, 1],
      [1, 0, 1, 0, 1, 0, 1],
    ],
  ),
  StageData(
    title: "Level 35: Pacman",
    targetGrid: [
      [0, 0, 1, 1, 1, 0, 0],
      [0, 1, 1, 1, 1, 1, 0],
      [1, 1, 1, 1, 0, 0, 0],
      [1, 1, 1, 0, 0, 0, 0],
      [1, 1, 1, 1, 0, 0, 0],
      [0, 1, 1, 1, 1, 1, 0],
      [0, 0, 1, 1, 1, 0, 0],
    ],
  ),
  StageData(
    title: "Level 36: SpaceShip",
    targetGrid: [
      [0, 0, 0, 1, 0, 0, 0],
      [0, 0, 1, 1, 1, 0, 0],
      [0, 1, 1, 0, 1, 1, 0],
      [1, 1, 1, 1, 1, 1, 1],
      [1, 0, 1, 1, 1, 0, 1],
      [1, 0, 0, 1, 0, 0, 1],
      [0, 0, 1, 1, 1, 0, 0],
    ],
  ),
  StageData(
    title: "Level 37: Alien",
    targetGrid: [
      [0, 0, 1, 0, 1, 0, 0],
      [0, 0, 1, 1, 1, 0, 0],
      [0, 1, 1, 1, 1, 1, 0],
      [0, 1, 0, 1, 0, 1, 0],
      [1, 1, 1, 1, 1, 1, 1],
      [1, 0, 1, 1, 1, 0, 1],
      [1, 0, 1, 0, 1, 0, 1],
    ],
  ),
  StageData(
    title: "Level 38: Star 7x7",
    targetGrid: [
      [0, 0, 0, 1, 0, 0, 0],
      [0, 0, 1, 1, 1, 0, 0],
      [1, 1, 1, 1, 1, 1, 1],
      [0, 1, 1, 1, 1, 1, 0],
      [0, 0, 1, 1, 1, 0, 0],
      [0, 1, 1, 0, 1, 1, 0],
      [1, 1, 0, 0, 0, 1, 1],
    ],
  ),
  // 10x10 Levels
  StageData(
    title: "Level 39: Star (10x10)",
    targetGrid: [
      [0, 0, 0, 0, 1, 1, 0, 0, 0, 0],
      [0, 0, 0, 1, 1, 1, 1, 0, 0, 0],
      [0, 0, 1, 1, 1, 1, 1, 1, 0, 0],
      [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
      [0, 1, 1, 1, 1, 1, 1, 1, 1, 0],
      [0, 0, 1, 1, 1, 1, 1, 1, 0, 0],
      [0, 1, 1, 0, 1, 1, 0, 1, 1, 0],
      [1, 1, 0, 0, 0, 0, 0, 0, 1, 1],
      [1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    ],
  ),
  StageData(
    title: "Level 40: Spiral",
    targetGrid: [
      [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
      [1, 1, 1, 1, 1, 1, 1, 1, 0, 1],
      [1, 0, 0, 0, 0, 0, 0, 1, 0, 1],
      [1, 0, 1, 1, 1, 1, 0, 1, 0, 1],
      [1, 0, 1, 0, 0, 1, 0, 1, 0, 1],
      [1, 0, 1, 1, 1, 1, 0, 1, 0, 1],
      [1, 0, 0, 0, 0, 0, 0, 1, 0, 1],
      [1, 1, 1, 1, 1, 1, 1, 1, 0, 1],
      [1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    ],
  ),
  StageData(
    title: "Level 41: Tree",
    targetGrid: [
      [0, 0, 0, 0, 1, 1, 0, 0, 0, 0],
      [0, 0, 0, 1, 1, 1, 1, 0, 0, 0],
      [0, 0, 0, 0, 1, 1, 0, 0, 0, 0],
      [0, 0, 0, 1, 1, 1, 1, 0, 0, 0],
      [0, 0, 1, 1, 1, 1, 1, 1, 0, 0],
      [0, 0, 0, 0, 1, 1, 0, 0, 0, 0],
      [0, 0, 0, 1, 1, 1, 1, 0, 0, 0],
      [0, 0, 1, 1, 1, 1, 1, 1, 0, 0],
      [0, 1, 1, 1, 1, 1, 1, 1, 1, 0],
      [0, 0, 0, 1, 1, 1, 1, 0, 0, 0],
    ],
  ),
  StageData(
    title: "Level 42: Face",
    targetGrid: [
      [0, 0, 0, 1, 1, 1, 1, 0, 0, 0],
      [0, 0, 1, 0, 0, 0, 0, 1, 0, 0],
      [0, 1, 0, 1, 0, 0, 1, 0, 1, 0],
      [0, 1, 0, 1, 0, 0, 1, 0, 1, 0],
      [1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
      [1, 0, 0, 0, 1, 1, 0, 0, 0, 1],
      [1, 0, 1, 0, 0, 0, 0, 1, 0, 1],
      [0, 1, 0, 1, 1, 1, 1, 0, 1, 0],
      [0, 0, 1, 0, 0, 0, 0, 1, 0, 0],
      [0, 0, 0, 1, 1, 1, 1, 0, 0, 0],
    ],
  ),
  StageData(
    title: "Level 43: Note",
    targetGrid: [
      [0, 0, 0, 0, 1, 1, 1, 1, 1, 0],
      [0, 0, 0, 0, 1, 0, 0, 0, 1, 0],
      [0, 0, 0, 0, 1, 0, 0, 0, 1, 0],
      [0, 0, 0, 0, 1, 0, 0, 0, 1, 0],
      [0, 0, 0, 0, 1, 0, 0, 0, 1, 0],
      [0, 0, 1, 1, 1, 0, 1, 1, 1, 0],
      [0, 1, 1, 1, 1, 0, 1, 1, 1, 1],
      [0, 1, 1, 1, 1, 0, 1, 1, 1, 1],
      [0, 1, 1, 1, 0, 0, 0, 1, 1, 0],
      [0, 0, 1, 0, 0, 0, 0, 0, 0, 0],
    ],
  ),
  StageData(
    title: "Level 44: Umbrella",
    targetGrid: [
      [0, 0, 0, 0, 1, 1, 0, 0, 0, 0],
      [0, 0, 0, 1, 1, 1, 1, 0, 0, 0],
      [0, 0, 1, 1, 1, 1, 1, 1, 0, 0],
      [0, 1, 1, 1, 1, 1, 1, 1, 1, 0],
      [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
      [1, 0, 0, 0, 1, 0, 0, 0, 0, 1],
      [0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
      [0, 0, 1, 1, 1, 0, 0, 0, 0, 0],
    ],
  ),
  StageData(
    title: "Level 45: House Big",
    targetGrid: [
      [0, 0, 0, 0, 1, 1, 0, 0, 0, 0],
      [0, 0, 0, 1, 1, 1, 1, 0, 0, 0],
      [0, 0, 1, 1, 1, 1, 1, 1, 0, 0],
      [0, 1, 1, 1, 1, 1, 1, 1, 1, 0],
      [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
      [0, 1, 1, 1, 1, 1, 1, 1, 1, 0],
      [0, 1, 0, 0, 0, 0, 0, 0, 1, 0],
      [0, 1, 0, 1, 1, 1, 1, 0, 1, 0],
      [0, 1, 0, 1, 1, 1, 1, 0, 1, 0],
      [0, 1, 1, 1, 1, 1, 1, 1, 1, 0],
    ],
  ),
  StageData(
    title: "Level 46: Rocket",
    targetGrid: [
      [0, 0, 0, 0, 1, 1, 0, 0, 0, 0],
      [0, 0, 0, 1, 1, 1, 1, 0, 0, 0],
      [0, 0, 0, 1, 1, 1, 1, 0, 0, 0],
      [0, 0, 0, 1, 0, 0, 1, 0, 0, 0],
      [0, 0, 0, 1, 1, 1, 1, 0, 0, 0],
      [0, 0, 0, 1, 1, 1, 1, 0, 0, 0],
      [0, 0, 1, 1, 1, 1, 1, 1, 0, 0],
      [0, 0, 1, 1, 0, 0, 1, 1, 0, 0],
      [0, 1, 1, 0, 0, 0, 0, 1, 1, 0],
      [0, 1, 0, 0, 1, 1, 0, 0, 1, 0],
    ],
  ),
  StageData(
    title: "Level 47: Diamond Big",
    targetGrid: [
      [0, 0, 0, 0, 1, 1, 0, 0, 0, 0],
      [0, 0, 0, 1, 1, 1, 1, 0, 0, 0],
      [0, 0, 1, 1, 1, 1, 1, 1, 0, 0],
      [0, 1, 1, 1, 1, 1, 1, 1, 1, 0],
      [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
      [0, 1, 1, 1, 1, 1, 1, 1, 1, 0],
      [0, 0, 1, 1, 1, 1, 1, 1, 0, 0],
      [0, 0, 0, 1, 1, 1, 1, 0, 0, 0],
      [0, 0, 0, 0, 1, 1, 0, 0, 0, 0],
    ],
  ),
  StageData(
    title: "Level 48: Castle",
    targetGrid: [
      [0, 1, 0, 1, 0, 0, 1, 0, 1, 0],
      [0, 1, 0, 1, 0, 0, 1, 0, 1, 0],
      [1, 1, 1, 1, 1, 1, 1, 1, 1, 1], // Anchor
      [0, 1, 1, 1, 0, 0, 1, 1, 1, 0],
      [0, 1, 1, 1, 0, 0, 1, 1, 1, 0],
      [0, 1, 1, 1, 0, 0, 1, 1, 1, 0],
      [0, 1, 1, 1, 1, 1, 1, 1, 1, 0],
      [0, 0, 1, 1, 1, 1, 1, 1, 0, 0],
      [1, 1, 1, 1, 1, 1, 1, 1, 1, 1], // Anchor
      [1, 1, 1, 1, 1, 1, 1, 1, 1, 1], // Anchor
    ],
  ),
];

// Title Screen
class TitleScreen extends StatelessWidget {
  const TitleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Slide Picross',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: Color(0xFF5D4037),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SlidePicrossGame(initialStageIndex: 0)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6D4C41),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(fontSize: 24),
              ),
              child: const Text('Game Start'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const StageSelectScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                 backgroundColor: const Color(0xFF8D6E63),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(fontSize: 24),
              ),
              child: const Text('Stage Select'),
            ),
          ],
        ),
      ),
    );
  }
}

// Stage Select Screen
class StageSelectScreen extends StatelessWidget {
  const StageSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // For Debug: All levels are cleared/unlocked
    final clearedLevels = List.generate(allStages.length, (index) => true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stage Select'),
        backgroundColor: const Color(0xFF8D6E63),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5, // Increase columns for easier navigation on desktop
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.0,
          ),
          itemCount: allStages.length,
          itemBuilder: (context, index) {
            final isUnlocked = clearedLevels[index];
            return ElevatedButton(
              onPressed: isUnlocked
                  ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SlidePicrossGame(initialStageIndex: index),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isUnlocked ? const Color(0xFF5D4037) : Colors.grey,
                foregroundColor: Colors.white,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                '${index + 1}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
      ),
    );
  }
}


class SlidePicrossGame extends StatefulWidget {
  final int initialStageIndex;
  const SlidePicrossGame({super.key, this.initialStageIndex = 0});

  @override
  State<SlidePicrossGame> createState() => _SlidePicrossGameState();
}

class _SlidePicrossGameState extends State<SlidePicrossGame> {
  // Tutorial State
  bool _showTutorial = true;
  int _tutorialStep = 0;

  int _currentStageIndex = 0;
  double _currentGridSize = 60.0;

  late StageData _currentStage;
  late List<List<int>> _rowHints;
  late List<List<int>> _colHints;
  late List<List<int>> _currentColHints;
  late List<List<double>> _rowPositions; // マス目単位：0.0, 1.0...
  bool _isCleared = false;
  bool _isAssistMode = false; // アシストモードの状態

  @override
  void initState() {
    super.initState();
    // Initialize with provided initialStageIndex
    _loadStage(widget.initialStageIndex);
  }

  void _loadStage(int index) {
    setState(() {
      _currentStageIndex = index;
      _currentStage = allStages[index]; // Use global allStages
      _rowHints = _generateRowHints(_currentStage.targetGrid);
      _colHints = _generateColHints(_currentStage.targetGrid);
      _initializePositions();
      _updateCurrentHints(); // Initial calculation
      _isCleared = false;
      
      if (index == 0) {
        _showTutorial = true;
        _tutorialStep = 0;
      } else {
        _showTutorial = false;
      }
      
      // Enable Assist Mode by default for Practice Levels (indices 0-4)
      if (index <= 4) {
        _isAssistMode = true;
      } else {
        _isAssistMode = false;
      }
    });
    // ロード直後に判定（オートクリア等のチェック）
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkWinCondition();
    });
  }

  void _nextStage() {
    if (_currentStageIndex < allStages.length - 1) { // Use global allStages
      _loadStage(_currentStageIndex + 1);
    } else {
      // 全クリ時の挙動（タイトルに戻る）
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  List<List<int>> _generateRowHints(List<List<int>> grid) {
    List<List<int>> hints = [];
    for (var row in grid) {
      List<int> currentHint = [];
      int count = 0;
      for (var cell in row) {
        if (cell == 1) {
          count++;
        } else if (count > 0) {
          currentHint.add(count);
          count = 0;
        }
      }
      if (count > 0) currentHint.add(count);
      hints.add(currentHint);
    }
    return hints;
  }

  List<List<int>> _generateColHints(List<List<int>> grid) {
    List<List<int>> hints = [];
    int width = grid[0].length;
    for (int x = 0; x < width; x++) {
      List<int> currentHint = [];
      int count = 0;
      for (int y = 0; y < grid.length; y++) {
        if (grid[y][x] == 1) {
          count++;
        } else if (count > 0) {
          currentHint.add(count);
          count = 0;
        }
      }
      if (count > 0) currentHint.add(count);
      if (currentHint.isEmpty) currentHint.add(0);
      hints.add(currentHint);
    }
    return hints;
  }

  void _initializePositions() {
    _rowPositions = [];
    for (var hints in _rowHints) {
      List<double> positions = [];
      double currentPos = 0.0;
      for (var len in hints) {
        positions.add(currentPos);
        currentPos += len + 1.0; // デフォルトで1マスの隙間を空けて配置（左詰め）
      }
      _rowPositions.add(positions);
    }
  }

  void _handleSlide(int rowIndex, int rodIndex, double deltaPixels) {
    if (_isCleared) return;

    double delta = deltaPixels / _currentGridSize;
    List<double> currentPositions = List.from(_rowPositions[rowIndex]);
    List<int> lengths = _rowHints[rowIndex];
    int gridSizeX = _currentStage.gridSizeX;

    if (delta > 0) {
      double availableSpaceRight = gridSizeX.toDouble();
      for (int i = lengths.length - 1; i > rodIndex; i--) {
        availableSpaceRight -= (lengths[i] + 1.0);
      }
      double maxX = availableSpaceRight - lengths[rodIndex];
      currentPositions[rodIndex] = (currentPositions[rodIndex] + delta).clamp(0.0, maxX);

      for (int i = rodIndex + 1; i < lengths.length; i++) {
        double minPos = currentPositions[i - 1] + lengths[i - 1] + 1.0;
        if (currentPositions[i] < minPos) {
          currentPositions[i] = minPos;
        }
      }
    } else {
      double availableSpaceLeft = 0.0;
      for (int i = 0; i < rodIndex; i++) {
        availableSpaceLeft += (lengths[i] + 1.0);
      }
      double minX = availableSpaceLeft;
      currentPositions[rodIndex] = (currentPositions[rodIndex] + delta).clamp(minX, gridSizeX.toDouble());

      for (int i = rodIndex - 1; i >= 0; i--) {
        double maxPos = currentPositions[i + 1] - lengths[i] - 1.0;
        if (currentPositions[i] > maxPos) {
          currentPositions[i] = maxPos;
        }
      }
    }

    setState(() {
      _rowPositions[rowIndex] = currentPositions;
      _updateCurrentHints();
    });
  }

  void _handleSnap(int rowIndex, int rodIndex) {
    if (_isCleared) return;

    List<double> positions = List.from(_rowPositions[rowIndex]);
    positions[rodIndex] = positions[rodIndex].roundToDouble();
    
     List<int> lengths = _rowHints[rowIndex];
     for (int i = 0; i < lengths.length - 1; i++) {
        if (positions[i] + lengths[i] + 1.0 > positions[i+1]) {
           positions[i+1] = positions[i] + lengths[i] + 1.0;
        }
     }
    
    setState(() {
      _rowPositions[rowIndex] = positions;
      // _updateCurrentHints(); // Already called in _handleSlide essentially, but calling here for snap correctness
      // But we should recalculate exactly.
      _updateCurrentHints();
      _checkWinCondition();
    });
  }

  void _checkWinCondition() {
    int gridSizeX = _currentStage.gridSizeX;
    int gridSizeY = _currentStage.gridSizeY;

    // 現在の盤面情報を作成
    List<List<int>> currentGrid = _generateCurrentGrid();

    // 正解と比較
    bool match = true;
    for (int y = 0; y < gridSizeY; y++) {
      for (int x = 0; x < gridSizeX; x++) {
        if (currentGrid[y][x] != _currentStage.targetGrid[y][x]) {
          match = false;
          break;
        }
      }
      if (!match) break;
    }

    if (match != _isCleared) {
      if (mounted) {
        setState(() {
          _isCleared = match;
        });
        if (_isCleared) {
            if (kDebugMode) {
              print("Stage Cleared!");
            }
        }
      }
    }
  }

  List<List<int>> _generateCurrentGrid() {
    int gridSizeX = _currentStage.gridSizeX;
    int gridSizeY = _currentStage.gridSizeY;
    List<List<int>> currentGrid = List.generate(gridSizeY, (_) => List.filled(gridSizeX, 0));

    for (int y = 0; y < gridSizeY; y++) {
      for (int i = 0; i < _rowPositions[y].length; i++) {
        int start = _rowPositions[y][i].round();
        int end = start + _rowHints[y][i];
        for (int x = start; x < end; x++) {
          if (x < gridSizeX) currentGrid[y][x] = 1;
        }
      }
    }
    return currentGrid;
  }

  void _updateCurrentHints() {
      List<List<int>> grid = _generateCurrentGrid();
      List<List<int>> newHints = _generateColHints(grid);
       // _currentColHints = newHints; // Correctly update state variable, caller calls setState
       _currentColHints = newHints;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0D7C6),
      appBar: AppBar(
        title: Text(_currentStage.title),
        backgroundColor: const Color(0xFF8D6E63),
        actions: [
          IconButton(
            icon: Icon(
              _isAssistMode ? Icons.lightbulb : Icons.lightbulb_outline,
              color: _isAssistMode ? Colors.yellow : Colors.white,
            ),
            tooltip: "Toggle Assist",
            onPressed: () {
              setState(() {
                _isAssistMode = !_isAssistMode;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              setState(() {
                _showTutorial = true;
                _tutorialStep = 0;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: "Back to Menu",
            onPressed: () {
               Navigator.of(context).popUntil((route) => route.isFirst);
            },
          )
        ],
      ),
      body: Stack(
        children: [
          LayoutBuilder(
        builder: (context, constraints) {
          double availableWidth = constraints.maxWidth;
          double availableHeight = constraints.maxHeight - 50; 
          
          int gridSizeX = _currentStage.gridSizeX;
          // アスペクト比計算
          double boardSize = (availableWidth < availableHeight ? availableWidth : availableHeight) * 0.9;
          _currentGridSize = boardSize / gridSizeX;

          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_isCleared)
                       Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Column(
                          children: [
                            const Text(
                              "CLEAR!!",
                              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton.icon(
                              onPressed: _nextStage,
                              icon: const Icon(Icons.arrow_forward),
                              label: Text(_currentStageIndex < allStages.length - 1 ? "Next Level" : "Back to Title"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orangeAccent,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    
                    _buildVerticalHints(_currentGridSize),
                    const SizedBox(height: 10),
                    
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.brown[700]!, width: 2),
                            color: Colors.brown[200],
                          ),
                          child: Column(
                            children: List.generate(_currentStage.gridSizeY, (i) {
                              return SlideRow(
                                rodLengths: _rowHints[i],
                                positions: _rowPositions[i],
                                totalGrid: gridSizeX,
                                gridSize: _currentGridSize,
                                isOdd: i.isOdd,
                                onSlide: (rodIdx, dx) => _handleSlide(i, rodIdx, dx),
                                onSlideEnd: (rodIdx) => _handleSnap(i, rodIdx),
                              );
                            }),
                          ),
                        ),
                        if (_isAssistMode)
                          Positioned.fill(
                            child: IgnorePointer(
                              child: CustomPaint(
                                painter: AssistOverlayPainter(
                                  currentGrid: _generateCurrentGrid(),
                                  gridSize: _currentGridSize + 0.0,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      if (_showTutorial)
        TutorialOverlay(
          step: _tutorialStep,
          onNext: () {
            setState(() {
              if (_tutorialStep < 2) { // 3 steps total (0, 1, 2)
                _tutorialStep++;
              } else {
                _showTutorial = false;
              }
            });
          },
          onSkip: () {
            setState(() {
              _showTutorial = false;
            });
          },
        ),
        ],
      ),
    );
  }

  Widget _buildVerticalHints(double currentSize) {
    double fontSize = (currentSize * 0.35).clamp(1.0, 24.0);
    int gridSizeX = _currentStage.gridSizeX;
    
    return SizedBox(
      width: currentSize * gridSizeX,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(gridSizeX, (i) {
          String hintText = _colHints[i].join("\n");
          String currentHintText = _currentColHints.length > i ? _currentColHints[i].join("\n") : "";

          return Container(
            width: currentSize,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 4),
            child: FittedBox(
              fit: BoxFit.scaleDown,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                   Text(
                    hintText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: fontSize,
                      color: const Color(0xFF5D4037),
                    ),
                  ),
                  if (_isAssistMode)
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        currentHintText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          fontSize: fontSize,
                          color: Colors.redAccent, 
                        ),
                      ),
                    ),
                ],
              ),
            ),
            ),
          );
        }),
      ),
    );
  }
}

class SlideRow extends StatelessWidget {
  final List<int> rodLengths;
  final List<double> positions;
  final int totalGrid;
  final double gridSize;
  final bool isOdd;
  final Function(int, double) onSlide;
  final Function(int) onSlideEnd;

  const SlideRow({
    super.key,
    required this.rodLengths,
    required this.positions,
    required this.totalGrid,
    required this.gridSize,
    required this.isOdd,
    required this.onSlide,
    required this.onSlideEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: gridSize,
      decoration: BoxDecoration(
        color: isOdd ? Colors.brown[100] : Colors.brown[200],
        border: Border(
          bottom: BorderSide(color: Colors.brown[400]!, width: 1), 
        ),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(totalGrid, (index) {
              return Container(
                width: gridSize,
                height: gridSize,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: Colors.black12, width: 1),
                  ),
                ),
              );
            }),
          ),
          ...List.generate(rodLengths.length, (index) {
            return Positioned(
              left: positions[index] * gridSize,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) => onSlide(index, details.delta.dx),
                onHorizontalDragEnd: (_) => onSlideEnd(index),
                child: _buildRod(rodLengths[index]),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildRod(int length) {
    return Container(
      width: length * gridSize,
      height: gridSize,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(8 * (gridSize / 60)),
        border: Border.all(color: Colors.white24, width: 2),
        boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 4 * (gridSize / 60))],
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'tutorial_overlay.dart';

void main() => runApp(const SlidePicrossApp());

class SlidePicrossApp extends StatelessWidget {
  const SlidePicrossApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SlidePicrossGame(),
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

class SlidePicrossGame extends StatefulWidget {
  const SlidePicrossGame({super.key});

  @override
  State<SlidePicrossGame> createState() => _SlidePicrossGameState();
}

class _SlidePicrossGameState extends State<SlidePicrossGame> {
  // ステージリスト定義
  late final List<StageData> _stages;

  // Tutorial State
  bool _showTutorial = true;
  int _tutorialStep = 0;

  @override
  void initState() {
    super.initState();
    _stages = [
      const StageData(
        title: "Level 1: Tutorial",
        targetGrid: [
          [0, 1, 1, 1, 0],
          [1, 0, 0, 1, 0],
          [1, 1, 1, 1, 1],
          [1, 0, 1, 1, 0],
          [0, 0, 0, 1, 1],
        ],
      ),
      const StageData(
        title: "Level 2: Smiley",
        targetGrid: [
          [0, 1, 0, 1, 0],
          [0, 1, 0, 1, 0],
          [0, 0, 0, 0, 0],
          [1, 0, 0, 0, 1],
          [0, 1, 1, 1, 0],
        ],
      ),
      const StageData(
        title: "Level 3: Heart",
        targetGrid: [
          [0, 1, 0, 1, 0],
          [1, 1, 1, 1, 1],
          [1, 1, 1, 1, 1],
          [0, 1, 1, 1, 0],
          [0, 0, 1, 0, 0],
        ],
      ),
      const StageData(
        title: "Level 4: Star (10x10)",
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
      // 32x32 チェッカーボードパターン削除 (ユーザー要望)
      // Level 6: User Image (Generated)
      const StageData(
        title: "Level 6: User Image",
        targetGrid: [
          [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
          [0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0],
          [0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0],
          [0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0],
          [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0],
          [0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0],
          [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
          [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
          [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1],
          [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1],
          [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1],
          [1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
          [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
          [0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0],
          [0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0],
          [0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0],
          [0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0],
          [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0],
        ],
      ),
    ];
    _loadStage(_currentStageIndex);
    _checkTutorial();
  }

  void _checkTutorial() {
    if (_currentStageIndex == 0) {
      if (mounted) {
        setState(() {
          _showTutorial = true;
          _tutorialStep = 0;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _showTutorial = false;
        });
      }
    }
  }

  int _currentStageIndex = 0;
  double _currentGridSize = 60.0;

  late StageData _currentStage;
  late List<List<int>> _rowHints;
  late List<List<int>> _colHints;
  late List<List<int>> _currentColHints;
  late List<List<double>> _rowPositions; // マス目単位：0.0, 1.0...
  bool _isCleared = false;

  void _loadStage(int index) {
    setState(() {
      _currentStageIndex = index;
      _currentStage = _stages[index];
      _rowHints = _generateRowHints(_currentStage.targetGrid);
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
    });
    // ロード直後に判定（オートクリア等のチェック）
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkWinCondition();
    });
  }

  void _nextStage() {
    if (_currentStageIndex < _stages.length - 1) {
      _loadStage(_currentStageIndex + 1);
    } else {
      // 全クリ時の挙動（とりあえず最初に戻る）
      _loadStage(0);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0D7C6),
      appBar: AppBar(
        title: Text(_currentStage.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              setState(() {
                _showTutorial = true;
                _tutorialStep = 0;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          LayoutBuilder(
        builder: (context, constraints) {
          double availableWidth = constraints.maxWidth;
          double availableHeight = constraints.maxHeight - 50; 
          
          int gridSizeX = _currentStage.gridSizeX;
          // アスペクト比計算 & 32x32などの場合は、画面内に収める初期倍率を決める
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
                              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.redAccent),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton.icon(
                              onPressed: _nextStage,
                              icon: const Icon(Icons.arrow_forward),
                              label: Text(_currentStageIndex < _stages.length - 1 ? "Next Level" : "Back to Title"),
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
                    
                    Container(
                      // width removed for dynamic sizing
                      padding: const EdgeInsets.all(2.0), // 枠線の内側にコンテンツを表示
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
              if (_tutorialStep < 2) {
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
    // フォントサイズを調整（下限を1.0にして32x32でもなんとか表示されるように）
    double fontSize = (currentSize * 0.35).clamp(1.0, 24.0);
    int gridSizeX = _currentStage.gridSizeX;
    
    return SizedBox(
      width: currentSize * gridSizeX,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end, // 下端揃え
        children: List.generate(gridSizeX, (i) {
          String hintText = _colHints[i].join("\n");
          String currentHintText = _currentColHints[i].join("\n");
          return Container(
            width: currentSize,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 4),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                   Text(
                    hintText,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
                  ),
                  const SizedBox(width: 4),
                   Text(
                    currentHintText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: fontSize,
                      color: Colors.redAccent, 
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
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
       // Only update if changes to avoid unnecessary rebuilds if possible, 
       // but for now simple setState is fine as it's driven by drag events anyway.
       // However, _updateCurrentHints is inside setState already or called from it.
       // Wait, _handleSlide calls setState. calling setState inside setState is bad.
       // _updateCurrentHints should NOT call setState, it should just update the variable.
       // The caller calls setState.
       _currentColHints = newHints;
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
      // width removed for dynamic sizing based on child Stack/Row
      height: gridSize,
      decoration: BoxDecoration(
        color: isOdd ? Colors.brown[100] : Colors.brown[200],
        border: Border(
          bottom: BorderSide(color: Colors.brown[400]!, width: 1), 
        ),
      ),
      child: Stack(
        children: [
          // 背景グリッド線 (薄く表示)
          Row(
            mainAxisSize: MainAxisSize.min, // コンテンツ幅に合わせる（余分な空白削除）
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
          // 棒の表示
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
        borderRadius: BorderRadius.circular(8 * (gridSize / 60)), // 角丸調整
        border: Border.all(color: Colors.white24, width: 2),
        boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 4 * (gridSize / 60))],
      ),
    );
  }
}

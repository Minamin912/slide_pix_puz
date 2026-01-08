import 'dart:io';
import 'package:image/image.dart';

void main() async {
  // Path to the uploaded image
  final imagePath = r'C:/Users/minamin/.gemini/antigravity/brain/889e547d-e412-474d-9b86-ed14cbffc6b9/uploaded_image_1767796214976.png';
  
  final File file = File(imagePath);
  if (!file.existsSync()) {
    print('Image file not found at $imagePath');
    return;
  }

  final bytes = await file.readAsBytes();
  final Image? image = decodeImage(bytes);

  if (image == null) {
    print('Failed to decode image');
    return;
  }

  // Resize to 20x20 to fit the target grid size
  // Using average interpolation for better downscaling quality if original is large
  final Image resized = copyResize(image, width: 20, height: 20, interpolation: Interpolation.average);

  final StringBuffer buffer = StringBuffer();
  buffer.writeln('// Level 6: User Image (Generated)');
  buffer.writeln('StageData(');
  buffer.writeln('  title: "Level 6: User Image",');
  buffer.writeln('  targetGrid: [');

  for (int y = 0; y < resized.height; y++) {
    final List<int> row = [];
    for (int x = 0; x < resized.width; x++) {
      final Pixel pixel = resized.getPixel(x, y);
      final num luminance = pixel.luminance;
      final int bit = luminance < 128 ? 1 : 0;
      row.add(bit);
    }
    buffer.writeln('    [${row.join(', ')}],');
  }
  buffer.writeln('  ],');
  buffer.writeln('),');

  final outputFile = File('tool/grid_data.txt');
  await outputFile.writeAsString(buffer.toString());
  print('Data written to ${outputFile.path}');
}

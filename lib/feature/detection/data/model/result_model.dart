class DetectionResult {
  final double x, y, w, h;
  final double confidence;
  final int classIndex;

  DetectionResult(this.x, this.y, this.w, this.h, this.confidence, this.classIndex);
}
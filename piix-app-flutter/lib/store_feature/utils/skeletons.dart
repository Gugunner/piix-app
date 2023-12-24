///This extension helps in calculating heights and widths for skeletons
///
extension SkeletonSizes on double {
  ///Calculate de higth or width as a percentage using a hight or width factor
  ///
  double percentageSize(double factor) => this * factor;
}

enum LottieAnimations {
  burgerLoading('burger-loading-food-beverage'),
  coffeeLoading('coffee-loader-food-beverage'),
  flowBg09('flow-background-09');

  // ignore: unused_element
  const LottieAnimations(this._fileName, [this._fileFormat = 'json']);
  final String _fileName;

  final String _fileFormat;
}

extension LottieAnimationsExtension on LottieAnimations {
  String get filePath {
    return 'assets/lottie/$_fileName.$_fileFormat';
  }
}

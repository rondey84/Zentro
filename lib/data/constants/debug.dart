const DEBUG_MODE = false;

void logPrint(String text) {
  // ignore: avoid_print
  if (DEBUG_MODE) print(text);
}

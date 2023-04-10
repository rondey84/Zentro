const DEBUG_MODE = false;

void logPrint(Object? object) {
  // ignore: avoid_print
  if (DEBUG_MODE) print(object);
}

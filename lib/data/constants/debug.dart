const DEBUG_MODE = true;

void logPrint(Object? object) {
  // ignore: avoid_print
  if (DEBUG_MODE) print(object);
}

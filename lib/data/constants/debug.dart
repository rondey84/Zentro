const DEBUG_MODE = false;
const DEBUG_SHOW_UPDATE_ORDER = true;

void logPrint(Object? object) {
  // ignore: avoid_print
  if (DEBUG_MODE) print(object);
}

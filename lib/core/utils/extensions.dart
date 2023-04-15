import 'dart:developer' as devtools show log;

/// Extension on object to Log output on comsole
extension Log on Object {
  void log() => devtools.log(toString());
}

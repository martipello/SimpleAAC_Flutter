import 'package:logger/logger.dart';

class ConsoleOutput extends LogOutput {
  ConsoleOutput(this.tag);

  final String? tag;

  @override
  void output(final OutputEvent event) {
    // ignore: avoid_function_literals_in_foreach_calls
    event.lines.forEach((final e) => printWrapped('$tag $e'));
  }

  void printWrapped(final String text) {
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(text).forEach((final match) => print(match.group(0)));
  }
}

Logger log(final String? tag) {
  return Logger(
    printer: PrettyPrinter(
      colors: true, // Colorful log messages
      printEmojis: true,
    ),
    output: ConsoleOutput(tag),
  );
}

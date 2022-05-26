import 'package:logger/logger.dart';

class ConsoleOutput extends LogOutput {
  ConsoleOutput(this.tag);

  final String? tag;

  @override
  void output(OutputEvent event) {
    // ignore: avoid_function_literals_in_foreach_calls
    event.lines.forEach((e) => printWrapped('$tag $e'));
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}

Logger log(String? tag) {
  return Logger(
    printer: PrettyPrinter(
      colors: true, // Colorful log messages
      printEmojis: true,
    ),
    output: ConsoleOutput(tag),
  );
}

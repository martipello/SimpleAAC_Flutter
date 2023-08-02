import 'package:drift/drift.dart';
import 'word_base.dart';

part 'word.g.dart';

class Word extends WordBase {

  TextColumn get word => text().call();

  TextColumn get sound => text().call();

  IntColumn get keyStage => integer().nullable().call();

  final List<String> extraRelatedWordIds;

  final TextColumn image;

}
import 'package:floor/floor.dart';

import '../models/language.dart';

@dao
abstract class LanguageDao {
  @Query('SELECT * FROM Language')
  Future<List<Language>> findAllLanguages();

  @Query('SELECT * FROM Language WHERE id = :id')
  Stream<Language?> findLanguageById(final int id);

  @insert
  Future<void> insertLanguage(final Language language);
}
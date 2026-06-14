// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $WordsTableTable extends WordsTable
    with TableInfo<$WordsTableTable, WordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _wordIdMeta = const VerificationMeta('wordId');
  @override
  late final GeneratedColumn<String> wordId = GeneratedColumn<String>(
    'word_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageIdMeta = const VerificationMeta(
    'languageId',
  );
  @override
  late final GeneratedColumn<String> languageId = GeneratedColumn<String>(
    'language_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wordTextMeta = const VerificationMeta(
    'wordText',
  );
  @override
  late final GeneratedColumn<String> wordText = GeneratedColumn<String>(
    'word_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneticOverrideMeta = const VerificationMeta(
    'phoneticOverride',
  );
  @override
  late final GeneratedColumn<String> phoneticOverride = GeneratedColumn<String>(
    'phonetic_override',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<WordType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<WordType>($WordsTableTable.$convertertype);
  @override
  late final GeneratedColumnWithTypeConverter<WordSubType, String> subType =
      GeneratedColumn<String>(
        'sub_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<WordSubType>($WordsTableTable.$convertersubType);
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
  extraRelatedWordIds = GeneratedColumn<String>(
    'extra_related_word_ids',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  ).withConverter<List<String>>($WordsTableTable.$converterextraRelatedWordIds);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
  aiSuggestedFollowUps =
      GeneratedColumn<String>(
        'ai_suggested_follow_ups',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      ).withConverter<List<String>>(
        $WordsTableTable.$converteraiSuggestedFollowUps,
      );
  @override
  late final GeneratedColumnWithTypeConverter<List<double>?, String>
  localEmbedding = GeneratedColumn<String>(
    'local_embedding',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<List<double>?>($WordsTableTable.$converterlocalEmbedding);
  static const VerificationMeta _createdDateMeta = const VerificationMeta(
    'createdDate',
  );
  @override
  late final GeneratedColumn<DateTime> createdDate = GeneratedColumn<DateTime>(
    'created_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    wordId,
    languageId,
    wordText,
    phoneticOverride,
    type,
    subType,
    imagePath,
    extraRelatedWordIds,
    aiSuggestedFollowUps,
    localEmbedding,
    createdDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'words';
  @override
  VerificationContext validateIntegrity(
    Insertable<WordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('word_id')) {
      context.handle(
        _wordIdMeta,
        wordId.isAcceptableOrUnknown(data['word_id']!, _wordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_wordIdMeta);
    }
    if (data.containsKey('language_id')) {
      context.handle(
        _languageIdMeta,
        languageId.isAcceptableOrUnknown(data['language_id']!, _languageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_languageIdMeta);
    }
    if (data.containsKey('word_text')) {
      context.handle(
        _wordTextMeta,
        wordText.isAcceptableOrUnknown(data['word_text']!, _wordTextMeta),
      );
    } else if (isInserting) {
      context.missing(_wordTextMeta);
    }
    if (data.containsKey('phonetic_override')) {
      context.handle(
        _phoneticOverrideMeta,
        phoneticOverride.isAcceptableOrUnknown(
          data['phonetic_override']!,
          _phoneticOverrideMeta,
        ),
      );
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    }
    if (data.containsKey('created_date')) {
      context.handle(
        _createdDateMeta,
        createdDate.isAcceptableOrUnknown(
          data['created_date']!,
          _createdDateMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {wordId};
  @override
  WordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordRow(
      wordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}word_id'],
      )!,
      languageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language_id'],
      )!,
      wordText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}word_text'],
      )!,
      phoneticOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phonetic_override'],
      ),
      type: $WordsTableTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      subType: $WordsTableTable.$convertersubType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sub_type'],
        )!,
      ),
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      ),
      extraRelatedWordIds: $WordsTableTable.$converterextraRelatedWordIds
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}extra_related_word_ids'],
            )!,
          ),
      aiSuggestedFollowUps: $WordsTableTable.$converteraiSuggestedFollowUps
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}ai_suggested_follow_ups'],
            )!,
          ),
      localEmbedding: $WordsTableTable.$converterlocalEmbedding.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}local_embedding'],
        ),
      ),
      createdDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_date'],
      ),
    );
  }

  @override
  $WordsTableTable createAlias(String alias) {
    return $WordsTableTable(attachedDatabase, alias);
  }

  static TypeConverter<WordType, String> $convertertype =
      const WordTypeConverter();
  static TypeConverter<WordSubType, String> $convertersubType =
      const WordSubTypeConverter();
  static TypeConverter<List<String>, String> $converterextraRelatedWordIds =
      const StringListConverter();
  static TypeConverter<List<String>, String> $converteraiSuggestedFollowUps =
      const StringListConverter();
  static TypeConverter<List<double>?, String?> $converterlocalEmbedding =
      const NullableDoubleListConverter();
}

class WordRow extends DataClass implements Insertable<WordRow> {
  final String wordId;
  final String languageId;
  final String wordText;
  final String? phoneticOverride;
  final WordType type;
  final WordSubType subType;
  final String? imagePath;
  final List<String> extraRelatedWordIds;
  final List<String> aiSuggestedFollowUps;
  final List<double>? localEmbedding;
  final DateTime? createdDate;
  const WordRow({
    required this.wordId,
    required this.languageId,
    required this.wordText,
    this.phoneticOverride,
    required this.type,
    required this.subType,
    this.imagePath,
    required this.extraRelatedWordIds,
    required this.aiSuggestedFollowUps,
    this.localEmbedding,
    this.createdDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['word_id'] = Variable<String>(wordId);
    map['language_id'] = Variable<String>(languageId);
    map['word_text'] = Variable<String>(wordText);
    if (!nullToAbsent || phoneticOverride != null) {
      map['phonetic_override'] = Variable<String>(phoneticOverride);
    }
    {
      map['type'] = Variable<String>(
        $WordsTableTable.$convertertype.toSql(type),
      );
    }
    {
      map['sub_type'] = Variable<String>(
        $WordsTableTable.$convertersubType.toSql(subType),
      );
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    {
      map['extra_related_word_ids'] = Variable<String>(
        $WordsTableTable.$converterextraRelatedWordIds.toSql(
          extraRelatedWordIds,
        ),
      );
    }
    {
      map['ai_suggested_follow_ups'] = Variable<String>(
        $WordsTableTable.$converteraiSuggestedFollowUps.toSql(
          aiSuggestedFollowUps,
        ),
      );
    }
    if (!nullToAbsent || localEmbedding != null) {
      map['local_embedding'] = Variable<String>(
        $WordsTableTable.$converterlocalEmbedding.toSql(localEmbedding),
      );
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    return map;
  }

  WordsTableCompanion toCompanion(bool nullToAbsent) {
    return WordsTableCompanion(
      wordId: Value(wordId),
      languageId: Value(languageId),
      wordText: Value(wordText),
      phoneticOverride: phoneticOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneticOverride),
      type: Value(type),
      subType: Value(subType),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      extraRelatedWordIds: Value(extraRelatedWordIds),
      aiSuggestedFollowUps: Value(aiSuggestedFollowUps),
      localEmbedding: localEmbedding == null && nullToAbsent
          ? const Value.absent()
          : Value(localEmbedding),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
    );
  }

  factory WordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordRow(
      wordId: serializer.fromJson<String>(json['wordId']),
      languageId: serializer.fromJson<String>(json['languageId']),
      wordText: serializer.fromJson<String>(json['wordText']),
      phoneticOverride: serializer.fromJson<String?>(json['phoneticOverride']),
      type: serializer.fromJson<WordType>(json['type']),
      subType: serializer.fromJson<WordSubType>(json['subType']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      extraRelatedWordIds: serializer.fromJson<List<String>>(
        json['extraRelatedWordIds'],
      ),
      aiSuggestedFollowUps: serializer.fromJson<List<String>>(
        json['aiSuggestedFollowUps'],
      ),
      localEmbedding: serializer.fromJson<List<double>?>(
        json['localEmbedding'],
      ),
      createdDate: serializer.fromJson<DateTime?>(json['createdDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'wordId': serializer.toJson<String>(wordId),
      'languageId': serializer.toJson<String>(languageId),
      'wordText': serializer.toJson<String>(wordText),
      'phoneticOverride': serializer.toJson<String?>(phoneticOverride),
      'type': serializer.toJson<WordType>(type),
      'subType': serializer.toJson<WordSubType>(subType),
      'imagePath': serializer.toJson<String?>(imagePath),
      'extraRelatedWordIds': serializer.toJson<List<String>>(
        extraRelatedWordIds,
      ),
      'aiSuggestedFollowUps': serializer.toJson<List<String>>(
        aiSuggestedFollowUps,
      ),
      'localEmbedding': serializer.toJson<List<double>?>(localEmbedding),
      'createdDate': serializer.toJson<DateTime?>(createdDate),
    };
  }

  WordRow copyWith({
    String? wordId,
    String? languageId,
    String? wordText,
    Value<String?> phoneticOverride = const Value.absent(),
    WordType? type,
    WordSubType? subType,
    Value<String?> imagePath = const Value.absent(),
    List<String>? extraRelatedWordIds,
    List<String>? aiSuggestedFollowUps,
    Value<List<double>?> localEmbedding = const Value.absent(),
    Value<DateTime?> createdDate = const Value.absent(),
  }) => WordRow(
    wordId: wordId ?? this.wordId,
    languageId: languageId ?? this.languageId,
    wordText: wordText ?? this.wordText,
    phoneticOverride: phoneticOverride.present
        ? phoneticOverride.value
        : this.phoneticOverride,
    type: type ?? this.type,
    subType: subType ?? this.subType,
    imagePath: imagePath.present ? imagePath.value : this.imagePath,
    extraRelatedWordIds: extraRelatedWordIds ?? this.extraRelatedWordIds,
    aiSuggestedFollowUps: aiSuggestedFollowUps ?? this.aiSuggestedFollowUps,
    localEmbedding: localEmbedding.present
        ? localEmbedding.value
        : this.localEmbedding,
    createdDate: createdDate.present ? createdDate.value : this.createdDate,
  );
  WordRow copyWithCompanion(WordsTableCompanion data) {
    return WordRow(
      wordId: data.wordId.present ? data.wordId.value : this.wordId,
      languageId: data.languageId.present
          ? data.languageId.value
          : this.languageId,
      wordText: data.wordText.present ? data.wordText.value : this.wordText,
      phoneticOverride: data.phoneticOverride.present
          ? data.phoneticOverride.value
          : this.phoneticOverride,
      type: data.type.present ? data.type.value : this.type,
      subType: data.subType.present ? data.subType.value : this.subType,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      extraRelatedWordIds: data.extraRelatedWordIds.present
          ? data.extraRelatedWordIds.value
          : this.extraRelatedWordIds,
      aiSuggestedFollowUps: data.aiSuggestedFollowUps.present
          ? data.aiSuggestedFollowUps.value
          : this.aiSuggestedFollowUps,
      localEmbedding: data.localEmbedding.present
          ? data.localEmbedding.value
          : this.localEmbedding,
      createdDate: data.createdDate.present
          ? data.createdDate.value
          : this.createdDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordRow(')
          ..write('wordId: $wordId, ')
          ..write('languageId: $languageId, ')
          ..write('wordText: $wordText, ')
          ..write('phoneticOverride: $phoneticOverride, ')
          ..write('type: $type, ')
          ..write('subType: $subType, ')
          ..write('imagePath: $imagePath, ')
          ..write('extraRelatedWordIds: $extraRelatedWordIds, ')
          ..write('aiSuggestedFollowUps: $aiSuggestedFollowUps, ')
          ..write('localEmbedding: $localEmbedding, ')
          ..write('createdDate: $createdDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    wordId,
    languageId,
    wordText,
    phoneticOverride,
    type,
    subType,
    imagePath,
    extraRelatedWordIds,
    aiSuggestedFollowUps,
    localEmbedding,
    createdDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordRow &&
          other.wordId == this.wordId &&
          other.languageId == this.languageId &&
          other.wordText == this.wordText &&
          other.phoneticOverride == this.phoneticOverride &&
          other.type == this.type &&
          other.subType == this.subType &&
          other.imagePath == this.imagePath &&
          other.extraRelatedWordIds == this.extraRelatedWordIds &&
          other.aiSuggestedFollowUps == this.aiSuggestedFollowUps &&
          other.localEmbedding == this.localEmbedding &&
          other.createdDate == this.createdDate);
}

class WordsTableCompanion extends UpdateCompanion<WordRow> {
  final Value<String> wordId;
  final Value<String> languageId;
  final Value<String> wordText;
  final Value<String?> phoneticOverride;
  final Value<WordType> type;
  final Value<WordSubType> subType;
  final Value<String?> imagePath;
  final Value<List<String>> extraRelatedWordIds;
  final Value<List<String>> aiSuggestedFollowUps;
  final Value<List<double>?> localEmbedding;
  final Value<DateTime?> createdDate;
  final Value<int> rowid;
  const WordsTableCompanion({
    this.wordId = const Value.absent(),
    this.languageId = const Value.absent(),
    this.wordText = const Value.absent(),
    this.phoneticOverride = const Value.absent(),
    this.type = const Value.absent(),
    this.subType = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.extraRelatedWordIds = const Value.absent(),
    this.aiSuggestedFollowUps = const Value.absent(),
    this.localEmbedding = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WordsTableCompanion.insert({
    required String wordId,
    required String languageId,
    required String wordText,
    this.phoneticOverride = const Value.absent(),
    required WordType type,
    required WordSubType subType,
    this.imagePath = const Value.absent(),
    this.extraRelatedWordIds = const Value.absent(),
    this.aiSuggestedFollowUps = const Value.absent(),
    this.localEmbedding = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : wordId = Value(wordId),
       languageId = Value(languageId),
       wordText = Value(wordText),
       type = Value(type),
       subType = Value(subType);
  static Insertable<WordRow> custom({
    Expression<String>? wordId,
    Expression<String>? languageId,
    Expression<String>? wordText,
    Expression<String>? phoneticOverride,
    Expression<String>? type,
    Expression<String>? subType,
    Expression<String>? imagePath,
    Expression<String>? extraRelatedWordIds,
    Expression<String>? aiSuggestedFollowUps,
    Expression<String>? localEmbedding,
    Expression<DateTime>? createdDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (wordId != null) 'word_id': wordId,
      if (languageId != null) 'language_id': languageId,
      if (wordText != null) 'word_text': wordText,
      if (phoneticOverride != null) 'phonetic_override': phoneticOverride,
      if (type != null) 'type': type,
      if (subType != null) 'sub_type': subType,
      if (imagePath != null) 'image_path': imagePath,
      if (extraRelatedWordIds != null)
        'extra_related_word_ids': extraRelatedWordIds,
      if (aiSuggestedFollowUps != null)
        'ai_suggested_follow_ups': aiSuggestedFollowUps,
      if (localEmbedding != null) 'local_embedding': localEmbedding,
      if (createdDate != null) 'created_date': createdDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WordsTableCompanion copyWith({
    Value<String>? wordId,
    Value<String>? languageId,
    Value<String>? wordText,
    Value<String?>? phoneticOverride,
    Value<WordType>? type,
    Value<WordSubType>? subType,
    Value<String?>? imagePath,
    Value<List<String>>? extraRelatedWordIds,
    Value<List<String>>? aiSuggestedFollowUps,
    Value<List<double>?>? localEmbedding,
    Value<DateTime?>? createdDate,
    Value<int>? rowid,
  }) {
    return WordsTableCompanion(
      wordId: wordId ?? this.wordId,
      languageId: languageId ?? this.languageId,
      wordText: wordText ?? this.wordText,
      phoneticOverride: phoneticOverride ?? this.phoneticOverride,
      type: type ?? this.type,
      subType: subType ?? this.subType,
      imagePath: imagePath ?? this.imagePath,
      extraRelatedWordIds: extraRelatedWordIds ?? this.extraRelatedWordIds,
      aiSuggestedFollowUps: aiSuggestedFollowUps ?? this.aiSuggestedFollowUps,
      localEmbedding: localEmbedding ?? this.localEmbedding,
      createdDate: createdDate ?? this.createdDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (wordId.present) {
      map['word_id'] = Variable<String>(wordId.value);
    }
    if (languageId.present) {
      map['language_id'] = Variable<String>(languageId.value);
    }
    if (wordText.present) {
      map['word_text'] = Variable<String>(wordText.value);
    }
    if (phoneticOverride.present) {
      map['phonetic_override'] = Variable<String>(phoneticOverride.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $WordsTableTable.$convertertype.toSql(type.value),
      );
    }
    if (subType.present) {
      map['sub_type'] = Variable<String>(
        $WordsTableTable.$convertersubType.toSql(subType.value),
      );
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (extraRelatedWordIds.present) {
      map['extra_related_word_ids'] = Variable<String>(
        $WordsTableTable.$converterextraRelatedWordIds.toSql(
          extraRelatedWordIds.value,
        ),
      );
    }
    if (aiSuggestedFollowUps.present) {
      map['ai_suggested_follow_ups'] = Variable<String>(
        $WordsTableTable.$converteraiSuggestedFollowUps.toSql(
          aiSuggestedFollowUps.value,
        ),
      );
    }
    if (localEmbedding.present) {
      map['local_embedding'] = Variable<String>(
        $WordsTableTable.$converterlocalEmbedding.toSql(localEmbedding.value),
      );
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordsTableCompanion(')
          ..write('wordId: $wordId, ')
          ..write('languageId: $languageId, ')
          ..write('wordText: $wordText, ')
          ..write('phoneticOverride: $phoneticOverride, ')
          ..write('type: $type, ')
          ..write('subType: $subType, ')
          ..write('imagePath: $imagePath, ')
          ..write('extraRelatedWordIds: $extraRelatedWordIds, ')
          ..write('aiSuggestedFollowUps: $aiSuggestedFollowUps, ')
          ..write('localEmbedding: $localEmbedding, ')
          ..write('createdDate: $createdDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WordOverridesTableTable extends WordOverridesTable
    with TableInfo<$WordOverridesTableTable, WordOverrideRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordOverridesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _wordIdMeta = const VerificationMeta('wordId');
  @override
  late final GeneratedColumn<String> wordId = GeneratedColumn<String>(
    'word_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFavouriteMeta = const VerificationMeta(
    'isFavourite',
  );
  @override
  late final GeneratedColumn<bool> isFavourite = GeneratedColumn<bool>(
    'is_favourite',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favourite" IN (0, 1))',
    ),
  );
  static const VerificationMeta _wordTextMeta = const VerificationMeta(
    'wordText',
  );
  @override
  late final GeneratedColumn<String> wordText = GeneratedColumn<String>(
    'word_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneticOverrideMeta = const VerificationMeta(
    'phoneticOverride',
  );
  @override
  late final GeneratedColumn<String> phoneticOverride = GeneratedColumn<String>(
    'phonetic_override',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subTypeMeta = const VerificationMeta(
    'subType',
  );
  @override
  late final GeneratedColumn<String> subType = GeneratedColumn<String>(
    'sub_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    wordId,
    isFavourite,
    wordText,
    phoneticOverride,
    type,
    subType,
    imagePath,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_overrides';
  @override
  VerificationContext validateIntegrity(
    Insertable<WordOverrideRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('word_id')) {
      context.handle(
        _wordIdMeta,
        wordId.isAcceptableOrUnknown(data['word_id']!, _wordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_wordIdMeta);
    }
    if (data.containsKey('is_favourite')) {
      context.handle(
        _isFavouriteMeta,
        isFavourite.isAcceptableOrUnknown(
          data['is_favourite']!,
          _isFavouriteMeta,
        ),
      );
    }
    if (data.containsKey('word_text')) {
      context.handle(
        _wordTextMeta,
        wordText.isAcceptableOrUnknown(data['word_text']!, _wordTextMeta),
      );
    }
    if (data.containsKey('phonetic_override')) {
      context.handle(
        _phoneticOverrideMeta,
        phoneticOverride.isAcceptableOrUnknown(
          data['phonetic_override']!,
          _phoneticOverrideMeta,
        ),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    }
    if (data.containsKey('sub_type')) {
      context.handle(
        _subTypeMeta,
        subType.isAcceptableOrUnknown(data['sub_type']!, _subTypeMeta),
      );
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {wordId};
  @override
  WordOverrideRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordOverrideRow(
      wordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}word_id'],
      )!,
      isFavourite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favourite'],
      ),
      wordText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}word_text'],
      ),
      phoneticOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phonetic_override'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      ),
      subType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sub_type'],
      ),
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $WordOverridesTableTable createAlias(String alias) {
    return $WordOverridesTableTable(attachedDatabase, alias);
  }
}

class WordOverrideRow extends DataClass implements Insertable<WordOverrideRow> {
  final String wordId;
  final bool? isFavourite;
  final String? wordText;
  final String? phoneticOverride;
  final String? type;
  final String? subType;
  final String? imagePath;
  final DateTime? updatedAt;
  const WordOverrideRow({
    required this.wordId,
    this.isFavourite,
    this.wordText,
    this.phoneticOverride,
    this.type,
    this.subType,
    this.imagePath,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['word_id'] = Variable<String>(wordId);
    if (!nullToAbsent || isFavourite != null) {
      map['is_favourite'] = Variable<bool>(isFavourite);
    }
    if (!nullToAbsent || wordText != null) {
      map['word_text'] = Variable<String>(wordText);
    }
    if (!nullToAbsent || phoneticOverride != null) {
      map['phonetic_override'] = Variable<String>(phoneticOverride);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || subType != null) {
      map['sub_type'] = Variable<String>(subType);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  WordOverridesTableCompanion toCompanion(bool nullToAbsent) {
    return WordOverridesTableCompanion(
      wordId: Value(wordId),
      isFavourite: isFavourite == null && nullToAbsent
          ? const Value.absent()
          : Value(isFavourite),
      wordText: wordText == null && nullToAbsent
          ? const Value.absent()
          : Value(wordText),
      phoneticOverride: phoneticOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneticOverride),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      subType: subType == null && nullToAbsent
          ? const Value.absent()
          : Value(subType),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory WordOverrideRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordOverrideRow(
      wordId: serializer.fromJson<String>(json['wordId']),
      isFavourite: serializer.fromJson<bool?>(json['isFavourite']),
      wordText: serializer.fromJson<String?>(json['wordText']),
      phoneticOverride: serializer.fromJson<String?>(json['phoneticOverride']),
      type: serializer.fromJson<String?>(json['type']),
      subType: serializer.fromJson<String?>(json['subType']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'wordId': serializer.toJson<String>(wordId),
      'isFavourite': serializer.toJson<bool?>(isFavourite),
      'wordText': serializer.toJson<String?>(wordText),
      'phoneticOverride': serializer.toJson<String?>(phoneticOverride),
      'type': serializer.toJson<String?>(type),
      'subType': serializer.toJson<String?>(subType),
      'imagePath': serializer.toJson<String?>(imagePath),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  WordOverrideRow copyWith({
    String? wordId,
    Value<bool?> isFavourite = const Value.absent(),
    Value<String?> wordText = const Value.absent(),
    Value<String?> phoneticOverride = const Value.absent(),
    Value<String?> type = const Value.absent(),
    Value<String?> subType = const Value.absent(),
    Value<String?> imagePath = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => WordOverrideRow(
    wordId: wordId ?? this.wordId,
    isFavourite: isFavourite.present ? isFavourite.value : this.isFavourite,
    wordText: wordText.present ? wordText.value : this.wordText,
    phoneticOverride: phoneticOverride.present
        ? phoneticOverride.value
        : this.phoneticOverride,
    type: type.present ? type.value : this.type,
    subType: subType.present ? subType.value : this.subType,
    imagePath: imagePath.present ? imagePath.value : this.imagePath,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  WordOverrideRow copyWithCompanion(WordOverridesTableCompanion data) {
    return WordOverrideRow(
      wordId: data.wordId.present ? data.wordId.value : this.wordId,
      isFavourite: data.isFavourite.present
          ? data.isFavourite.value
          : this.isFavourite,
      wordText: data.wordText.present ? data.wordText.value : this.wordText,
      phoneticOverride: data.phoneticOverride.present
          ? data.phoneticOverride.value
          : this.phoneticOverride,
      type: data.type.present ? data.type.value : this.type,
      subType: data.subType.present ? data.subType.value : this.subType,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordOverrideRow(')
          ..write('wordId: $wordId, ')
          ..write('isFavourite: $isFavourite, ')
          ..write('wordText: $wordText, ')
          ..write('phoneticOverride: $phoneticOverride, ')
          ..write('type: $type, ')
          ..write('subType: $subType, ')
          ..write('imagePath: $imagePath, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    wordId,
    isFavourite,
    wordText,
    phoneticOverride,
    type,
    subType,
    imagePath,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordOverrideRow &&
          other.wordId == this.wordId &&
          other.isFavourite == this.isFavourite &&
          other.wordText == this.wordText &&
          other.phoneticOverride == this.phoneticOverride &&
          other.type == this.type &&
          other.subType == this.subType &&
          other.imagePath == this.imagePath &&
          other.updatedAt == this.updatedAt);
}

class WordOverridesTableCompanion extends UpdateCompanion<WordOverrideRow> {
  final Value<String> wordId;
  final Value<bool?> isFavourite;
  final Value<String?> wordText;
  final Value<String?> phoneticOverride;
  final Value<String?> type;
  final Value<String?> subType;
  final Value<String?> imagePath;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const WordOverridesTableCompanion({
    this.wordId = const Value.absent(),
    this.isFavourite = const Value.absent(),
    this.wordText = const Value.absent(),
    this.phoneticOverride = const Value.absent(),
    this.type = const Value.absent(),
    this.subType = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WordOverridesTableCompanion.insert({
    required String wordId,
    this.isFavourite = const Value.absent(),
    this.wordText = const Value.absent(),
    this.phoneticOverride = const Value.absent(),
    this.type = const Value.absent(),
    this.subType = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : wordId = Value(wordId);
  static Insertable<WordOverrideRow> custom({
    Expression<String>? wordId,
    Expression<bool>? isFavourite,
    Expression<String>? wordText,
    Expression<String>? phoneticOverride,
    Expression<String>? type,
    Expression<String>? subType,
    Expression<String>? imagePath,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (wordId != null) 'word_id': wordId,
      if (isFavourite != null) 'is_favourite': isFavourite,
      if (wordText != null) 'word_text': wordText,
      if (phoneticOverride != null) 'phonetic_override': phoneticOverride,
      if (type != null) 'type': type,
      if (subType != null) 'sub_type': subType,
      if (imagePath != null) 'image_path': imagePath,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WordOverridesTableCompanion copyWith({
    Value<String>? wordId,
    Value<bool?>? isFavourite,
    Value<String?>? wordText,
    Value<String?>? phoneticOverride,
    Value<String?>? type,
    Value<String?>? subType,
    Value<String?>? imagePath,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return WordOverridesTableCompanion(
      wordId: wordId ?? this.wordId,
      isFavourite: isFavourite ?? this.isFavourite,
      wordText: wordText ?? this.wordText,
      phoneticOverride: phoneticOverride ?? this.phoneticOverride,
      type: type ?? this.type,
      subType: subType ?? this.subType,
      imagePath: imagePath ?? this.imagePath,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (wordId.present) {
      map['word_id'] = Variable<String>(wordId.value);
    }
    if (isFavourite.present) {
      map['is_favourite'] = Variable<bool>(isFavourite.value);
    }
    if (wordText.present) {
      map['word_text'] = Variable<String>(wordText.value);
    }
    if (phoneticOverride.present) {
      map['phonetic_override'] = Variable<String>(phoneticOverride.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (subType.present) {
      map['sub_type'] = Variable<String>(subType.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordOverridesTableCompanion(')
          ..write('wordId: $wordId, ')
          ..write('isFavourite: $isFavourite, ')
          ..write('wordText: $wordText, ')
          ..write('phoneticOverride: $phoneticOverride, ')
          ..write('type: $type, ')
          ..write('subType: $subType, ')
          ..write('imagePath: $imagePath, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WordGroupsTableTable extends WordGroupsTable
    with TableInfo<$WordGroupsTableTable, WordGroupRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordGroupsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> wordIds =
      GeneratedColumn<String>(
        'word_ids',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      ).withConverter<List<String>>($WordGroupsTableTable.$converterwordIds);
  static const VerificationMeta _phoneticOverrideMeta = const VerificationMeta(
    'phoneticOverride',
  );
  @override
  late final GeneratedColumn<String> phoneticOverride = GeneratedColumn<String>(
    'phonetic_override',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFavouriteMeta = const VerificationMeta(
    'isFavourite',
  );
  @override
  late final GeneratedColumn<bool> isFavourite = GeneratedColumn<bool>(
    'is_favourite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favourite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _usageCountMeta = const VerificationMeta(
    'usageCount',
  );
  @override
  late final GeneratedColumn<int> usageCount = GeneratedColumn<int>(
    'usage_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdDateMeta = const VerificationMeta(
    'createdDate',
  );
  @override
  late final GeneratedColumn<DateTime> createdDate = GeneratedColumn<DateTime>(
    'created_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    wordIds,
    phoneticOverride,
    imagePath,
    isFavourite,
    usageCount,
    createdDate,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<WordGroupRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('phonetic_override')) {
      context.handle(
        _phoneticOverrideMeta,
        phoneticOverride.isAcceptableOrUnknown(
          data['phonetic_override']!,
          _phoneticOverrideMeta,
        ),
      );
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    }
    if (data.containsKey('is_favourite')) {
      context.handle(
        _isFavouriteMeta,
        isFavourite.isAcceptableOrUnknown(
          data['is_favourite']!,
          _isFavouriteMeta,
        ),
      );
    }
    if (data.containsKey('usage_count')) {
      context.handle(
        _usageCountMeta,
        usageCount.isAcceptableOrUnknown(data['usage_count']!, _usageCountMeta),
      );
    }
    if (data.containsKey('created_date')) {
      context.handle(
        _createdDateMeta,
        createdDate.isAcceptableOrUnknown(
          data['created_date']!,
          _createdDateMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WordGroupRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordGroupRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      wordIds: $WordGroupsTableTable.$converterwordIds.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}word_ids'],
        )!,
      ),
      phoneticOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phonetic_override'],
      ),
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      ),
      isFavourite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favourite'],
      )!,
      usageCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usage_count'],
      )!,
      createdDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_date'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $WordGroupsTableTable createAlias(String alias) {
    return $WordGroupsTableTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterwordIds =
      const StringListConverter();
}

class WordGroupRow extends DataClass implements Insertable<WordGroupRow> {
  final String id;
  final String title;
  final List<String> wordIds;
  final String? phoneticOverride;
  final String? imagePath;
  final bool isFavourite;
  final int usageCount;
  final DateTime? createdDate;
  final DateTime? updatedAt;
  const WordGroupRow({
    required this.id,
    required this.title,
    required this.wordIds,
    this.phoneticOverride,
    this.imagePath,
    required this.isFavourite,
    required this.usageCount,
    this.createdDate,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    {
      map['word_ids'] = Variable<String>(
        $WordGroupsTableTable.$converterwordIds.toSql(wordIds),
      );
    }
    if (!nullToAbsent || phoneticOverride != null) {
      map['phonetic_override'] = Variable<String>(phoneticOverride);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    map['is_favourite'] = Variable<bool>(isFavourite);
    map['usage_count'] = Variable<int>(usageCount);
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<DateTime>(createdDate);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  WordGroupsTableCompanion toCompanion(bool nullToAbsent) {
    return WordGroupsTableCompanion(
      id: Value(id),
      title: Value(title),
      wordIds: Value(wordIds),
      phoneticOverride: phoneticOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneticOverride),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      isFavourite: Value(isFavourite),
      usageCount: Value(usageCount),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory WordGroupRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordGroupRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      wordIds: serializer.fromJson<List<String>>(json['wordIds']),
      phoneticOverride: serializer.fromJson<String?>(json['phoneticOverride']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      isFavourite: serializer.fromJson<bool>(json['isFavourite']),
      usageCount: serializer.fromJson<int>(json['usageCount']),
      createdDate: serializer.fromJson<DateTime?>(json['createdDate']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'wordIds': serializer.toJson<List<String>>(wordIds),
      'phoneticOverride': serializer.toJson<String?>(phoneticOverride),
      'imagePath': serializer.toJson<String?>(imagePath),
      'isFavourite': serializer.toJson<bool>(isFavourite),
      'usageCount': serializer.toJson<int>(usageCount),
      'createdDate': serializer.toJson<DateTime?>(createdDate),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  WordGroupRow copyWith({
    String? id,
    String? title,
    List<String>? wordIds,
    Value<String?> phoneticOverride = const Value.absent(),
    Value<String?> imagePath = const Value.absent(),
    bool? isFavourite,
    int? usageCount,
    Value<DateTime?> createdDate = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => WordGroupRow(
    id: id ?? this.id,
    title: title ?? this.title,
    wordIds: wordIds ?? this.wordIds,
    phoneticOverride: phoneticOverride.present
        ? phoneticOverride.value
        : this.phoneticOverride,
    imagePath: imagePath.present ? imagePath.value : this.imagePath,
    isFavourite: isFavourite ?? this.isFavourite,
    usageCount: usageCount ?? this.usageCount,
    createdDate: createdDate.present ? createdDate.value : this.createdDate,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  WordGroupRow copyWithCompanion(WordGroupsTableCompanion data) {
    return WordGroupRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      wordIds: data.wordIds.present ? data.wordIds.value : this.wordIds,
      phoneticOverride: data.phoneticOverride.present
          ? data.phoneticOverride.value
          : this.phoneticOverride,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      isFavourite: data.isFavourite.present
          ? data.isFavourite.value
          : this.isFavourite,
      usageCount: data.usageCount.present
          ? data.usageCount.value
          : this.usageCount,
      createdDate: data.createdDate.present
          ? data.createdDate.value
          : this.createdDate,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordGroupRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('wordIds: $wordIds, ')
          ..write('phoneticOverride: $phoneticOverride, ')
          ..write('imagePath: $imagePath, ')
          ..write('isFavourite: $isFavourite, ')
          ..write('usageCount: $usageCount, ')
          ..write('createdDate: $createdDate, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    wordIds,
    phoneticOverride,
    imagePath,
    isFavourite,
    usageCount,
    createdDate,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordGroupRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.wordIds == this.wordIds &&
          other.phoneticOverride == this.phoneticOverride &&
          other.imagePath == this.imagePath &&
          other.isFavourite == this.isFavourite &&
          other.usageCount == this.usageCount &&
          other.createdDate == this.createdDate &&
          other.updatedAt == this.updatedAt);
}

class WordGroupsTableCompanion extends UpdateCompanion<WordGroupRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<List<String>> wordIds;
  final Value<String?> phoneticOverride;
  final Value<String?> imagePath;
  final Value<bool> isFavourite;
  final Value<int> usageCount;
  final Value<DateTime?> createdDate;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const WordGroupsTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.wordIds = const Value.absent(),
    this.phoneticOverride = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.isFavourite = const Value.absent(),
    this.usageCount = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WordGroupsTableCompanion.insert({
    required String id,
    required String title,
    this.wordIds = const Value.absent(),
    this.phoneticOverride = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.isFavourite = const Value.absent(),
    this.usageCount = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title);
  static Insertable<WordGroupRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? wordIds,
    Expression<String>? phoneticOverride,
    Expression<String>? imagePath,
    Expression<bool>? isFavourite,
    Expression<int>? usageCount,
    Expression<DateTime>? createdDate,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (wordIds != null) 'word_ids': wordIds,
      if (phoneticOverride != null) 'phonetic_override': phoneticOverride,
      if (imagePath != null) 'image_path': imagePath,
      if (isFavourite != null) 'is_favourite': isFavourite,
      if (usageCount != null) 'usage_count': usageCount,
      if (createdDate != null) 'created_date': createdDate,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WordGroupsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<List<String>>? wordIds,
    Value<String?>? phoneticOverride,
    Value<String?>? imagePath,
    Value<bool>? isFavourite,
    Value<int>? usageCount,
    Value<DateTime?>? createdDate,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return WordGroupsTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      wordIds: wordIds ?? this.wordIds,
      phoneticOverride: phoneticOverride ?? this.phoneticOverride,
      imagePath: imagePath ?? this.imagePath,
      isFavourite: isFavourite ?? this.isFavourite,
      usageCount: usageCount ?? this.usageCount,
      createdDate: createdDate ?? this.createdDate,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (wordIds.present) {
      map['word_ids'] = Variable<String>(
        $WordGroupsTableTable.$converterwordIds.toSql(wordIds.value),
      );
    }
    if (phoneticOverride.present) {
      map['phonetic_override'] = Variable<String>(phoneticOverride.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (isFavourite.present) {
      map['is_favourite'] = Variable<bool>(isFavourite.value);
    }
    if (usageCount.present) {
      map['usage_count'] = Variable<int>(usageCount.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordGroupsTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('wordIds: $wordIds, ')
          ..write('phoneticOverride: $phoneticOverride, ')
          ..write('imagePath: $imagePath, ')
          ..write('isFavourite: $isFavourite, ')
          ..write('usageCount: $usageCount, ')
          ..write('createdDate: $createdDate, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WordUsageTableTable extends WordUsageTable
    with TableInfo<$WordUsageTableTable, WordUsageRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordUsageTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _wordIdMeta = const VerificationMeta('wordId');
  @override
  late final GeneratedColumn<String> wordId = GeneratedColumn<String>(
    'word_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
    'count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastUsedMeta = const VerificationMeta(
    'lastUsed',
  );
  @override
  late final GeneratedColumn<DateTime> lastUsed = GeneratedColumn<DateTime>(
    'last_used',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [wordId, count, lastUsed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_usage';
  @override
  VerificationContext validateIntegrity(
    Insertable<WordUsageRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('word_id')) {
      context.handle(
        _wordIdMeta,
        wordId.isAcceptableOrUnknown(data['word_id']!, _wordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_wordIdMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
        _countMeta,
        count.isAcceptableOrUnknown(data['count']!, _countMeta),
      );
    }
    if (data.containsKey('last_used')) {
      context.handle(
        _lastUsedMeta,
        lastUsed.isAcceptableOrUnknown(data['last_used']!, _lastUsedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {wordId};
  @override
  WordUsageRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordUsageRow(
      wordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}word_id'],
      )!,
      count: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}count'],
      )!,
      lastUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_used'],
      ),
    );
  }

  @override
  $WordUsageTableTable createAlias(String alias) {
    return $WordUsageTableTable(attachedDatabase, alias);
  }
}

class WordUsageRow extends DataClass implements Insertable<WordUsageRow> {
  final String wordId;
  final int count;
  final DateTime? lastUsed;
  const WordUsageRow({
    required this.wordId,
    required this.count,
    this.lastUsed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['word_id'] = Variable<String>(wordId);
    map['count'] = Variable<int>(count);
    if (!nullToAbsent || lastUsed != null) {
      map['last_used'] = Variable<DateTime>(lastUsed);
    }
    return map;
  }

  WordUsageTableCompanion toCompanion(bool nullToAbsent) {
    return WordUsageTableCompanion(
      wordId: Value(wordId),
      count: Value(count),
      lastUsed: lastUsed == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUsed),
    );
  }

  factory WordUsageRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordUsageRow(
      wordId: serializer.fromJson<String>(json['wordId']),
      count: serializer.fromJson<int>(json['count']),
      lastUsed: serializer.fromJson<DateTime?>(json['lastUsed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'wordId': serializer.toJson<String>(wordId),
      'count': serializer.toJson<int>(count),
      'lastUsed': serializer.toJson<DateTime?>(lastUsed),
    };
  }

  WordUsageRow copyWith({
    String? wordId,
    int? count,
    Value<DateTime?> lastUsed = const Value.absent(),
  }) => WordUsageRow(
    wordId: wordId ?? this.wordId,
    count: count ?? this.count,
    lastUsed: lastUsed.present ? lastUsed.value : this.lastUsed,
  );
  WordUsageRow copyWithCompanion(WordUsageTableCompanion data) {
    return WordUsageRow(
      wordId: data.wordId.present ? data.wordId.value : this.wordId,
      count: data.count.present ? data.count.value : this.count,
      lastUsed: data.lastUsed.present ? data.lastUsed.value : this.lastUsed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordUsageRow(')
          ..write('wordId: $wordId, ')
          ..write('count: $count, ')
          ..write('lastUsed: $lastUsed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(wordId, count, lastUsed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordUsageRow &&
          other.wordId == this.wordId &&
          other.count == this.count &&
          other.lastUsed == this.lastUsed);
}

class WordUsageTableCompanion extends UpdateCompanion<WordUsageRow> {
  final Value<String> wordId;
  final Value<int> count;
  final Value<DateTime?> lastUsed;
  final Value<int> rowid;
  const WordUsageTableCompanion({
    this.wordId = const Value.absent(),
    this.count = const Value.absent(),
    this.lastUsed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WordUsageTableCompanion.insert({
    required String wordId,
    this.count = const Value.absent(),
    this.lastUsed = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : wordId = Value(wordId);
  static Insertable<WordUsageRow> custom({
    Expression<String>? wordId,
    Expression<int>? count,
    Expression<DateTime>? lastUsed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (wordId != null) 'word_id': wordId,
      if (count != null) 'count': count,
      if (lastUsed != null) 'last_used': lastUsed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WordUsageTableCompanion copyWith({
    Value<String>? wordId,
    Value<int>? count,
    Value<DateTime?>? lastUsed,
    Value<int>? rowid,
  }) {
    return WordUsageTableCompanion(
      wordId: wordId ?? this.wordId,
      count: count ?? this.count,
      lastUsed: lastUsed ?? this.lastUsed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (wordId.present) {
      map['word_id'] = Variable<String>(wordId.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (lastUsed.present) {
      map['last_used'] = Variable<DateTime>(lastUsed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordUsageTableCompanion(')
          ..write('wordId: $wordId, ')
          ..write('count: $count, ')
          ..write('lastUsed: $lastUsed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncMetadataTableTable extends SyncMetadataTable
    with TableInfo<$SyncMetadataTableTable, SyncMetadataRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetadataTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _collectionMeta = const VerificationMeta(
    'collection',
  );
  @override
  late final GeneratedColumn<String> collection = GeneratedColumn<String>(
    'collection',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [collection, lastSyncedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncMetadataRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('collection')) {
      context.handle(
        _collectionMeta,
        collection.isAcceptableOrUnknown(data['collection']!, _collectionMeta),
      );
    } else if (isInserting) {
      context.missing(_collectionMeta);
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {collection};
  @override
  SyncMetadataRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetadataRow(
      collection: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}collection'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $SyncMetadataTableTable createAlias(String alias) {
    return $SyncMetadataTableTable(attachedDatabase, alias);
  }
}

class SyncMetadataRow extends DataClass implements Insertable<SyncMetadataRow> {
  final String collection;
  final DateTime? lastSyncedAt;
  const SyncMetadataRow({required this.collection, this.lastSyncedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['collection'] = Variable<String>(collection);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  SyncMetadataTableCompanion toCompanion(bool nullToAbsent) {
    return SyncMetadataTableCompanion(
      collection: Value(collection),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory SyncMetadataRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetadataRow(
      collection: serializer.fromJson<String>(json['collection']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'collection': serializer.toJson<String>(collection),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  SyncMetadataRow copyWith({
    String? collection,
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => SyncMetadataRow(
    collection: collection ?? this.collection,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  SyncMetadataRow copyWithCompanion(SyncMetadataTableCompanion data) {
    return SyncMetadataRow(
      collection: data.collection.present
          ? data.collection.value
          : this.collection,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataRow(')
          ..write('collection: $collection, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(collection, lastSyncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetadataRow &&
          other.collection == this.collection &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class SyncMetadataTableCompanion extends UpdateCompanion<SyncMetadataRow> {
  final Value<String> collection;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const SyncMetadataTableCompanion({
    this.collection = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetadataTableCompanion.insert({
    required String collection,
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : collection = Value(collection);
  static Insertable<SyncMetadataRow> custom({
    Expression<String>? collection,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (collection != null) 'collection': collection,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetadataTableCompanion copyWith({
    Value<String>? collection,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return SyncMetadataTableCompanion(
      collection: collection ?? this.collection,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (collection.present) {
      map['collection'] = Variable<String>(collection.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataTableCompanion(')
          ..write('collection: $collection, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WordsTableTable wordsTable = $WordsTableTable(this);
  late final $WordOverridesTableTable wordOverridesTable =
      $WordOverridesTableTable(this);
  late final $WordGroupsTableTable wordGroupsTable = $WordGroupsTableTable(
    this,
  );
  late final $WordUsageTableTable wordUsageTable = $WordUsageTableTable(this);
  late final $SyncMetadataTableTable syncMetadataTable =
      $SyncMetadataTableTable(this);
  late final WordsDao wordsDao = WordsDao(this as AppDatabase);
  late final WordGroupsDao wordGroupsDao = WordGroupsDao(this as AppDatabase);
  late final WordUsageDao wordUsageDao = WordUsageDao(this as AppDatabase);
  late final SyncDao syncDao = SyncDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    wordsTable,
    wordOverridesTable,
    wordGroupsTable,
    wordUsageTable,
    syncMetadataTable,
  ];
}

typedef $$WordsTableTableCreateCompanionBuilder =
    WordsTableCompanion Function({
      required String wordId,
      required String languageId,
      required String wordText,
      Value<String?> phoneticOverride,
      required WordType type,
      required WordSubType subType,
      Value<String?> imagePath,
      Value<List<String>> extraRelatedWordIds,
      Value<List<String>> aiSuggestedFollowUps,
      Value<List<double>?> localEmbedding,
      Value<DateTime?> createdDate,
      Value<int> rowid,
    });
typedef $$WordsTableTableUpdateCompanionBuilder =
    WordsTableCompanion Function({
      Value<String> wordId,
      Value<String> languageId,
      Value<String> wordText,
      Value<String?> phoneticOverride,
      Value<WordType> type,
      Value<WordSubType> subType,
      Value<String?> imagePath,
      Value<List<String>> extraRelatedWordIds,
      Value<List<String>> aiSuggestedFollowUps,
      Value<List<double>?> localEmbedding,
      Value<DateTime?> createdDate,
      Value<int> rowid,
    });

class $$WordsTableTableFilterComposer
    extends Composer<_$AppDatabase, $WordsTableTable> {
  $$WordsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get wordId => $composableBuilder(
    column: $table.wordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get languageId => $composableBuilder(
    column: $table.languageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wordText => $composableBuilder(
    column: $table.wordText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneticOverride => $composableBuilder(
    column: $table.phoneticOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<WordType, WordType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<WordSubType, WordSubType, String>
  get subType => $composableBuilder(
    column: $table.subType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get extraRelatedWordIds => $composableBuilder(
    column: $table.extraRelatedWordIds,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get aiSuggestedFollowUps => $composableBuilder(
    column: $table.aiSuggestedFollowUps,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<double>?, List<double>, String>
  get localEmbedding => $composableBuilder(
    column: $table.localEmbedding,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdDate => $composableBuilder(
    column: $table.createdDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WordsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WordsTableTable> {
  $$WordsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get wordId => $composableBuilder(
    column: $table.wordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get languageId => $composableBuilder(
    column: $table.languageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wordText => $composableBuilder(
    column: $table.wordText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneticOverride => $composableBuilder(
    column: $table.phoneticOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subType => $composableBuilder(
    column: $table.subType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get extraRelatedWordIds => $composableBuilder(
    column: $table.extraRelatedWordIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aiSuggestedFollowUps => $composableBuilder(
    column: $table.aiSuggestedFollowUps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localEmbedding => $composableBuilder(
    column: $table.localEmbedding,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdDate => $composableBuilder(
    column: $table.createdDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WordsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordsTableTable> {
  $$WordsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get wordId =>
      $composableBuilder(column: $table.wordId, builder: (column) => column);

  GeneratedColumn<String> get languageId => $composableBuilder(
    column: $table.languageId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get wordText =>
      $composableBuilder(column: $table.wordText, builder: (column) => column);

  GeneratedColumn<String> get phoneticOverride => $composableBuilder(
    column: $table.phoneticOverride,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<WordType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumnWithTypeConverter<WordSubType, String> get subType =>
      $composableBuilder(column: $table.subType, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String>
  get extraRelatedWordIds => $composableBuilder(
    column: $table.extraRelatedWordIds,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<String>, String>
  get aiSuggestedFollowUps => $composableBuilder(
    column: $table.aiSuggestedFollowUps,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<double>?, String> get localEmbedding =>
      $composableBuilder(
        column: $table.localEmbedding,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get createdDate => $composableBuilder(
    column: $table.createdDate,
    builder: (column) => column,
  );
}

class $$WordsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordsTableTable,
          WordRow,
          $$WordsTableTableFilterComposer,
          $$WordsTableTableOrderingComposer,
          $$WordsTableTableAnnotationComposer,
          $$WordsTableTableCreateCompanionBuilder,
          $$WordsTableTableUpdateCompanionBuilder,
          (WordRow, BaseReferences<_$AppDatabase, $WordsTableTable, WordRow>),
          WordRow,
          PrefetchHooks Function()
        > {
  $$WordsTableTableTableManager(_$AppDatabase db, $WordsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> wordId = const Value.absent(),
                Value<String> languageId = const Value.absent(),
                Value<String> wordText = const Value.absent(),
                Value<String?> phoneticOverride = const Value.absent(),
                Value<WordType> type = const Value.absent(),
                Value<WordSubType> subType = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<List<String>> extraRelatedWordIds = const Value.absent(),
                Value<List<String>> aiSuggestedFollowUps = const Value.absent(),
                Value<List<double>?> localEmbedding = const Value.absent(),
                Value<DateTime?> createdDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WordsTableCompanion(
                wordId: wordId,
                languageId: languageId,
                wordText: wordText,
                phoneticOverride: phoneticOverride,
                type: type,
                subType: subType,
                imagePath: imagePath,
                extraRelatedWordIds: extraRelatedWordIds,
                aiSuggestedFollowUps: aiSuggestedFollowUps,
                localEmbedding: localEmbedding,
                createdDate: createdDate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String wordId,
                required String languageId,
                required String wordText,
                Value<String?> phoneticOverride = const Value.absent(),
                required WordType type,
                required WordSubType subType,
                Value<String?> imagePath = const Value.absent(),
                Value<List<String>> extraRelatedWordIds = const Value.absent(),
                Value<List<String>> aiSuggestedFollowUps = const Value.absent(),
                Value<List<double>?> localEmbedding = const Value.absent(),
                Value<DateTime?> createdDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WordsTableCompanion.insert(
                wordId: wordId,
                languageId: languageId,
                wordText: wordText,
                phoneticOverride: phoneticOverride,
                type: type,
                subType: subType,
                imagePath: imagePath,
                extraRelatedWordIds: extraRelatedWordIds,
                aiSuggestedFollowUps: aiSuggestedFollowUps,
                localEmbedding: localEmbedding,
                createdDate: createdDate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WordsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordsTableTable,
      WordRow,
      $$WordsTableTableFilterComposer,
      $$WordsTableTableOrderingComposer,
      $$WordsTableTableAnnotationComposer,
      $$WordsTableTableCreateCompanionBuilder,
      $$WordsTableTableUpdateCompanionBuilder,
      (WordRow, BaseReferences<_$AppDatabase, $WordsTableTable, WordRow>),
      WordRow,
      PrefetchHooks Function()
    >;
typedef $$WordOverridesTableTableCreateCompanionBuilder =
    WordOverridesTableCompanion Function({
      required String wordId,
      Value<bool?> isFavourite,
      Value<String?> wordText,
      Value<String?> phoneticOverride,
      Value<String?> type,
      Value<String?> subType,
      Value<String?> imagePath,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$WordOverridesTableTableUpdateCompanionBuilder =
    WordOverridesTableCompanion Function({
      Value<String> wordId,
      Value<bool?> isFavourite,
      Value<String?> wordText,
      Value<String?> phoneticOverride,
      Value<String?> type,
      Value<String?> subType,
      Value<String?> imagePath,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

class $$WordOverridesTableTableFilterComposer
    extends Composer<_$AppDatabase, $WordOverridesTableTable> {
  $$WordOverridesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get wordId => $composableBuilder(
    column: $table.wordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavourite => $composableBuilder(
    column: $table.isFavourite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wordText => $composableBuilder(
    column: $table.wordText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneticOverride => $composableBuilder(
    column: $table.phoneticOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subType => $composableBuilder(
    column: $table.subType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WordOverridesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WordOverridesTableTable> {
  $$WordOverridesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get wordId => $composableBuilder(
    column: $table.wordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavourite => $composableBuilder(
    column: $table.isFavourite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wordText => $composableBuilder(
    column: $table.wordText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneticOverride => $composableBuilder(
    column: $table.phoneticOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subType => $composableBuilder(
    column: $table.subType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WordOverridesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordOverridesTableTable> {
  $$WordOverridesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get wordId =>
      $composableBuilder(column: $table.wordId, builder: (column) => column);

  GeneratedColumn<bool> get isFavourite => $composableBuilder(
    column: $table.isFavourite,
    builder: (column) => column,
  );

  GeneratedColumn<String> get wordText =>
      $composableBuilder(column: $table.wordText, builder: (column) => column);

  GeneratedColumn<String> get phoneticOverride => $composableBuilder(
    column: $table.phoneticOverride,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get subType =>
      $composableBuilder(column: $table.subType, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$WordOverridesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordOverridesTableTable,
          WordOverrideRow,
          $$WordOverridesTableTableFilterComposer,
          $$WordOverridesTableTableOrderingComposer,
          $$WordOverridesTableTableAnnotationComposer,
          $$WordOverridesTableTableCreateCompanionBuilder,
          $$WordOverridesTableTableUpdateCompanionBuilder,
          (
            WordOverrideRow,
            BaseReferences<
              _$AppDatabase,
              $WordOverridesTableTable,
              WordOverrideRow
            >,
          ),
          WordOverrideRow,
          PrefetchHooks Function()
        > {
  $$WordOverridesTableTableTableManager(
    _$AppDatabase db,
    $WordOverridesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordOverridesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordOverridesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordOverridesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> wordId = const Value.absent(),
                Value<bool?> isFavourite = const Value.absent(),
                Value<String?> wordText = const Value.absent(),
                Value<String?> phoneticOverride = const Value.absent(),
                Value<String?> type = const Value.absent(),
                Value<String?> subType = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WordOverridesTableCompanion(
                wordId: wordId,
                isFavourite: isFavourite,
                wordText: wordText,
                phoneticOverride: phoneticOverride,
                type: type,
                subType: subType,
                imagePath: imagePath,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String wordId,
                Value<bool?> isFavourite = const Value.absent(),
                Value<String?> wordText = const Value.absent(),
                Value<String?> phoneticOverride = const Value.absent(),
                Value<String?> type = const Value.absent(),
                Value<String?> subType = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WordOverridesTableCompanion.insert(
                wordId: wordId,
                isFavourite: isFavourite,
                wordText: wordText,
                phoneticOverride: phoneticOverride,
                type: type,
                subType: subType,
                imagePath: imagePath,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WordOverridesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordOverridesTableTable,
      WordOverrideRow,
      $$WordOverridesTableTableFilterComposer,
      $$WordOverridesTableTableOrderingComposer,
      $$WordOverridesTableTableAnnotationComposer,
      $$WordOverridesTableTableCreateCompanionBuilder,
      $$WordOverridesTableTableUpdateCompanionBuilder,
      (
        WordOverrideRow,
        BaseReferences<
          _$AppDatabase,
          $WordOverridesTableTable,
          WordOverrideRow
        >,
      ),
      WordOverrideRow,
      PrefetchHooks Function()
    >;
typedef $$WordGroupsTableTableCreateCompanionBuilder =
    WordGroupsTableCompanion Function({
      required String id,
      required String title,
      Value<List<String>> wordIds,
      Value<String?> phoneticOverride,
      Value<String?> imagePath,
      Value<bool> isFavourite,
      Value<int> usageCount,
      Value<DateTime?> createdDate,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$WordGroupsTableTableUpdateCompanionBuilder =
    WordGroupsTableCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<List<String>> wordIds,
      Value<String?> phoneticOverride,
      Value<String?> imagePath,
      Value<bool> isFavourite,
      Value<int> usageCount,
      Value<DateTime?> createdDate,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

class $$WordGroupsTableTableFilterComposer
    extends Composer<_$AppDatabase, $WordGroupsTableTable> {
  $$WordGroupsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get wordIds => $composableBuilder(
    column: $table.wordIds,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get phoneticOverride => $composableBuilder(
    column: $table.phoneticOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavourite => $composableBuilder(
    column: $table.isFavourite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdDate => $composableBuilder(
    column: $table.createdDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WordGroupsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WordGroupsTableTable> {
  $$WordGroupsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wordIds => $composableBuilder(
    column: $table.wordIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneticOverride => $composableBuilder(
    column: $table.phoneticOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavourite => $composableBuilder(
    column: $table.isFavourite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdDate => $composableBuilder(
    column: $table.createdDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WordGroupsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordGroupsTableTable> {
  $$WordGroupsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get wordIds =>
      $composableBuilder(column: $table.wordIds, builder: (column) => column);

  GeneratedColumn<String> get phoneticOverride => $composableBuilder(
    column: $table.phoneticOverride,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<bool> get isFavourite => $composableBuilder(
    column: $table.isFavourite,
    builder: (column) => column,
  );

  GeneratedColumn<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdDate => $composableBuilder(
    column: $table.createdDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$WordGroupsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordGroupsTableTable,
          WordGroupRow,
          $$WordGroupsTableTableFilterComposer,
          $$WordGroupsTableTableOrderingComposer,
          $$WordGroupsTableTableAnnotationComposer,
          $$WordGroupsTableTableCreateCompanionBuilder,
          $$WordGroupsTableTableUpdateCompanionBuilder,
          (
            WordGroupRow,
            BaseReferences<_$AppDatabase, $WordGroupsTableTable, WordGroupRow>,
          ),
          WordGroupRow,
          PrefetchHooks Function()
        > {
  $$WordGroupsTableTableTableManager(
    _$AppDatabase db,
    $WordGroupsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordGroupsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordGroupsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordGroupsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<List<String>> wordIds = const Value.absent(),
                Value<String?> phoneticOverride = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<bool> isFavourite = const Value.absent(),
                Value<int> usageCount = const Value.absent(),
                Value<DateTime?> createdDate = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WordGroupsTableCompanion(
                id: id,
                title: title,
                wordIds: wordIds,
                phoneticOverride: phoneticOverride,
                imagePath: imagePath,
                isFavourite: isFavourite,
                usageCount: usageCount,
                createdDate: createdDate,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<List<String>> wordIds = const Value.absent(),
                Value<String?> phoneticOverride = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<bool> isFavourite = const Value.absent(),
                Value<int> usageCount = const Value.absent(),
                Value<DateTime?> createdDate = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WordGroupsTableCompanion.insert(
                id: id,
                title: title,
                wordIds: wordIds,
                phoneticOverride: phoneticOverride,
                imagePath: imagePath,
                isFavourite: isFavourite,
                usageCount: usageCount,
                createdDate: createdDate,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WordGroupsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordGroupsTableTable,
      WordGroupRow,
      $$WordGroupsTableTableFilterComposer,
      $$WordGroupsTableTableOrderingComposer,
      $$WordGroupsTableTableAnnotationComposer,
      $$WordGroupsTableTableCreateCompanionBuilder,
      $$WordGroupsTableTableUpdateCompanionBuilder,
      (
        WordGroupRow,
        BaseReferences<_$AppDatabase, $WordGroupsTableTable, WordGroupRow>,
      ),
      WordGroupRow,
      PrefetchHooks Function()
    >;
typedef $$WordUsageTableTableCreateCompanionBuilder =
    WordUsageTableCompanion Function({
      required String wordId,
      Value<int> count,
      Value<DateTime?> lastUsed,
      Value<int> rowid,
    });
typedef $$WordUsageTableTableUpdateCompanionBuilder =
    WordUsageTableCompanion Function({
      Value<String> wordId,
      Value<int> count,
      Value<DateTime?> lastUsed,
      Value<int> rowid,
    });

class $$WordUsageTableTableFilterComposer
    extends Composer<_$AppDatabase, $WordUsageTableTable> {
  $$WordUsageTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get wordId => $composableBuilder(
    column: $table.wordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUsed => $composableBuilder(
    column: $table.lastUsed,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WordUsageTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WordUsageTableTable> {
  $$WordUsageTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get wordId => $composableBuilder(
    column: $table.wordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUsed => $composableBuilder(
    column: $table.lastUsed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WordUsageTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordUsageTableTable> {
  $$WordUsageTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get wordId =>
      $composableBuilder(column: $table.wordId, builder: (column) => column);

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUsed =>
      $composableBuilder(column: $table.lastUsed, builder: (column) => column);
}

class $$WordUsageTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordUsageTableTable,
          WordUsageRow,
          $$WordUsageTableTableFilterComposer,
          $$WordUsageTableTableOrderingComposer,
          $$WordUsageTableTableAnnotationComposer,
          $$WordUsageTableTableCreateCompanionBuilder,
          $$WordUsageTableTableUpdateCompanionBuilder,
          (
            WordUsageRow,
            BaseReferences<_$AppDatabase, $WordUsageTableTable, WordUsageRow>,
          ),
          WordUsageRow,
          PrefetchHooks Function()
        > {
  $$WordUsageTableTableTableManager(
    _$AppDatabase db,
    $WordUsageTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordUsageTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordUsageTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordUsageTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> wordId = const Value.absent(),
                Value<int> count = const Value.absent(),
                Value<DateTime?> lastUsed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WordUsageTableCompanion(
                wordId: wordId,
                count: count,
                lastUsed: lastUsed,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String wordId,
                Value<int> count = const Value.absent(),
                Value<DateTime?> lastUsed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WordUsageTableCompanion.insert(
                wordId: wordId,
                count: count,
                lastUsed: lastUsed,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WordUsageTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordUsageTableTable,
      WordUsageRow,
      $$WordUsageTableTableFilterComposer,
      $$WordUsageTableTableOrderingComposer,
      $$WordUsageTableTableAnnotationComposer,
      $$WordUsageTableTableCreateCompanionBuilder,
      $$WordUsageTableTableUpdateCompanionBuilder,
      (
        WordUsageRow,
        BaseReferences<_$AppDatabase, $WordUsageTableTable, WordUsageRow>,
      ),
      WordUsageRow,
      PrefetchHooks Function()
    >;
typedef $$SyncMetadataTableTableCreateCompanionBuilder =
    SyncMetadataTableCompanion Function({
      required String collection,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$SyncMetadataTableTableUpdateCompanionBuilder =
    SyncMetadataTableCompanion Function({
      Value<String> collection,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });

class $$SyncMetadataTableTableFilterComposer
    extends Composer<_$AppDatabase, $SyncMetadataTableTable> {
  $$SyncMetadataTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get collection => $composableBuilder(
    column: $table.collection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncMetadataTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncMetadataTableTable> {
  $$SyncMetadataTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get collection => $composableBuilder(
    column: $table.collection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncMetadataTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncMetadataTableTable> {
  $$SyncMetadataTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get collection => $composableBuilder(
    column: $table.collection,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$SyncMetadataTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncMetadataTableTable,
          SyncMetadataRow,
          $$SyncMetadataTableTableFilterComposer,
          $$SyncMetadataTableTableOrderingComposer,
          $$SyncMetadataTableTableAnnotationComposer,
          $$SyncMetadataTableTableCreateCompanionBuilder,
          $$SyncMetadataTableTableUpdateCompanionBuilder,
          (
            SyncMetadataRow,
            BaseReferences<
              _$AppDatabase,
              $SyncMetadataTableTable,
              SyncMetadataRow
            >,
          ),
          SyncMetadataRow,
          PrefetchHooks Function()
        > {
  $$SyncMetadataTableTableTableManager(
    _$AppDatabase db,
    $SyncMetadataTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetadataTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetadataTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncMetadataTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> collection = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataTableCompanion(
                collection: collection,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String collection,
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataTableCompanion.insert(
                collection: collection,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncMetadataTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncMetadataTableTable,
      SyncMetadataRow,
      $$SyncMetadataTableTableFilterComposer,
      $$SyncMetadataTableTableOrderingComposer,
      $$SyncMetadataTableTableAnnotationComposer,
      $$SyncMetadataTableTableCreateCompanionBuilder,
      $$SyncMetadataTableTableUpdateCompanionBuilder,
      (
        SyncMetadataRow,
        BaseReferences<_$AppDatabase, $SyncMetadataTableTable, SyncMetadataRow>,
      ),
      SyncMetadataRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WordsTableTableTableManager get wordsTable =>
      $$WordsTableTableTableManager(_db, _db.wordsTable);
  $$WordOverridesTableTableTableManager get wordOverridesTable =>
      $$WordOverridesTableTableTableManager(_db, _db.wordOverridesTable);
  $$WordGroupsTableTableTableManager get wordGroupsTable =>
      $$WordGroupsTableTableTableManager(_db, _db.wordGroupsTable);
  $$WordUsageTableTableTableManager get wordUsageTable =>
      $$WordUsageTableTableTableManager(_db, _db.wordUsageTable);
  $$SyncMetadataTableTableTableManager get syncMetadataTable =>
      $$SyncMetadataTableTableTableManager(_db, _db.syncMetadataTable);
}

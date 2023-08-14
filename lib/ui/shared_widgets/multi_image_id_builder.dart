import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:simple_aac/ui/shared_widgets/simple_aac_loading_widget.dart';

import '../../api/models/word_base.dart';
import '../../dependency_injection_container.dart';
import '../../view_models/image_info/image_info_view_model.dart';

class MultiImageIDBuilder extends StatelessWidget {
  MultiImageIDBuilder({
    required this.multiImageIDBuilder,
    required this.wordBase,
    final Key? key,
  }) : super(key: key);

  final Widget Function(BuiltList<String>) multiImageIDBuilder;
  final WordBase wordBase;

  final imageInfoViewModel = getIt.get<ImageInfoViewModel>();

  @override
  Widget build(final BuildContext context) {
    return FutureBuilder<BuiltList<String>>(
      future: imageInfoViewModel.getImageIds(wordBase),
      builder: (final context, final snapshot) {
        final imageIds = snapshot.data ?? BuiltList<String>();
        // final isLoading = snapshot.connectionState == ConnectionState.waiting;
        // if (isLoading) {
        //   return SimpleAACLoadingWidget.shimmer();
        // }
        return multiImageIDBuilder.call(imageIds);
      },
    );
  }
}

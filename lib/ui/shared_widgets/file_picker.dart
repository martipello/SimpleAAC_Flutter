import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../dependency_injection_container.dart';
import '../../extensions/build_context_extension.dart';
import '../../view_models/file_picker/file_picker_view_model.dart';
import '../theme/simple_aac_text.dart';
import 'rounded_button.dart';

typedef OnPickedImages = Future<void> Function(List<XFile> imageFiles);

class FilePicker extends StatefulWidget {
  const FilePicker({
    Key? key,
    this.buttonLabel,
    this.label,
    this.labelStyle,
    this.buttonLabelStyle,
    this.errorLabel,
    this.errorLabelStyle,
    required this.pickedImagesCallback,
  }) : super(key: key);

  final String? buttonLabel;
  final String? label;
  final String? errorLabel;
  final TextStyle? labelStyle;
  final TextStyle? buttonLabelStyle;
  final TextStyle? errorLabelStyle;
  final OnPickedImages pickedImagesCallback;

  @override
  _FilePickerState createState() => _FilePickerState();
}

class _FilePickerState extends State<FilePicker> {
  final _filePickerViewModel = getIt.get<FilePickerViewModel>();

  @override
  void initState() {
    super.initState();
    _filePickerViewModel.pickedFileList.listen(
      (value) {
        widget.pickedImagesCallback.call(value ?? []);
      },
    );
  }

  @override
  void dispose() {
    _filePickerViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLabel(),
        const SizedBox(
          height: 16,
        ),
        defaultTargetPlatform == TargetPlatform.android
            ? FutureBuilder<void>(
                future: _filePickerViewModel.retrieveLostData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return _buildErrorLabel();
                  }
                  return _buildPreview();
                },
              )
            : _buildPreview(),
        _buildUploadButton(),
      ],
    );
  }

  Widget _buildPreview() {
    return StreamBuilder<List<XFile>?>(
      stream: _filePickerViewModel.pickedFileList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildImageList(snapshot.data ?? []);
        } else if (snapshot.hasError) {
          return _buildErrorLabel();
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildImageList(List<XFile> images) {
    if (images.isEmpty) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 72,
          child: Center(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return _buildImageHolder(images[index]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 16,
                );
              },
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _buildImageHolder(XFile imageFile) {
    return Center(
      child: Stack(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: _buildImage(imageFile),
            ),
          ),
          _buildRemoveButton(imageFile),
        ],
      ),
    );
  }

  Widget _buildRemoveButton(XFile imageFile) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topRight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(90),
          clipBehavior: Clip.hardEdge,
          child: Container(
            color: Colors.black54,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                splashColor: Colors.white70,
                onTap: () {
                  _filePickerViewModel.removeImage(imageFile);
                },
                child: Icon(
                  Icons.close,
                  color: context.themeColors.onPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(XFile imageFile) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      clipBehavior: Clip.hardEdge,
      child: Image.file(
        File(imageFile.path),
        height: 70,
        width: 70,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildLabel() {
    return Text(
      widget.label ?? 'Upload File',
      style: widget.labelStyle ?? SimpleAACText.body4Style,
    );
  }

  Widget _buildErrorLabel() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        widget.errorLabel ?? 'Failed to retrieve files please try again.',
        style: widget.errorLabelStyle ??
            SimpleAACText.captionStyle.copyWith(
              color: context.themeColors.error,
            ),
      ),
    );
  }

  Widget _buildUploadButton() {
    return SizedBox(
      height: 36,
      child: RoundedButton(
        label: widget.buttonLabel ?? 'CHOOSE FILES',
        textStyle: widget.buttonLabelStyle,
        isFilled: false,
        disableShadow: true,
        onPressed: _filePickerViewModel.openImagePicker,
        elevation: 0,
      ),
    );
  }
}

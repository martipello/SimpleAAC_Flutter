import 'package:flutter/material.dart';

import '../theme/base_theme.dart';
import '../theme/simple_aac_text.dart';
import 'simple_aac_loading_widget.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key? key,
    this.size,
    this.textStyle,
  });

  final Size? size;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final imageUrl = _createImageUrl();
    return _buildProfileImage(imageUrl, context);
  }

  String _createImageUrl() {
    return '';
    // final profileImageFileId = linguistResponse?.data?.profile?.profile_image_id ?? '';
    // if (profileImageFileId.isEmpty) {
    //   return '';
    // }
    // final profileImageFileAccessToken = linguistResponse?.fats?.fat_profile_image_download ?? '';
    // return '${flavors.F.baseUrl}/files/$profileImageFileId?fat=$profileImageFileAccessToken';
  }

  String _getLinguistInitials() {
    return '';
    // final linguistInitials = '${linguistResponse?.data?.profile?.first_name?.substring(0, 1) ?? ''}'
    //     '${linguistResponse?.data?.profile?.last_name?.substring(0, 1) ?? ''}';
    // return linguistInitials.isEmpty ? 'Wordskii' : linguistInitials;
  }

  Widget _buildEmptyProfileImage(
    BuildContext context,
    String linguistInitials,
  ) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(180),
        child: Container(
          height: size?.height ?? 150,
          width: size?.width ?? 150,
          color: colors(context).primary,
          child: Center(
            child: Text(
              linguistInitials,
              style: textStyle ??
                  SimpleAACText.subtitle2Style.copyWith(
                    color: colors(context).textOnPrimary,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(
    String imagePath,
    BuildContext context,
  ) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(180),
        child: imagePath.isNotEmpty
            ? Image.network(
                imagePath,
                fit: BoxFit.cover,
                height: size?.height ?? 150,
                width: size?.width ?? 150,
                loadingBuilder: (context, child, chunk) {
                  if (chunk == null) {
                    return child;
                  }
                  return _buildLoadingImage();
                },
                errorBuilder: (context, object, stacktrace) {
                  return _buildEmptyProfileImage(
                    context,
                    _getLinguistInitials(),
                  );
                },
              )
            : _buildEmptyProfileImage(
                context,
                _getLinguistInitials(),
              ),
      ),
    );
  }

  Widget _buildLoadingImage() {
    return Center(
      child: SizedBox(
        height: size?.height ?? 150,
        width: size?.width ?? 150,
        child: const Padding(
          padding: EdgeInsets.all(4.0),
          child: Center(
            child: SimpleAACLoadingWidget(),
          ),
        ),
      ),
    );
  }
}

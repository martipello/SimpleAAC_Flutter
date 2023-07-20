import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ui/theme/simple_aac_text.dart';

class LaunchService {
  void launchEvent(final String _url, final BuildContext context) async => await canLaunch(_url)
      ? await launch(_url)
      : ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: SizedBox(
              height: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Failed to launch $_url',
                    style: SimpleAACText.body3Style,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
}

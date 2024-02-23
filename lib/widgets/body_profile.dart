import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ungsugar/widgets/widget_button.dart';
import 'package:ungsugar/widgets/widget_text.dart';

class BodyProfile extends StatelessWidget {
  const BodyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetText(data: 'This is Profile'),
        WidgetButton(
          label: 'SignOut',
          pressFunc: () async {
            await FirebaseAuth.instance.signOut().then((value) {
              exit(0);
            });
          },
        )
      ],
    );
  }
}

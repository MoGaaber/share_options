// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_options/share_options.dart';

import 'logic.dart';
import 'ui/ui.dart';

void main() {
  runApp(MyMaterialApp());
}

class MyMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShareOptions.getTextShareOptions('text').then((value) => value[0]);

    return ChangeNotifierProvider(
      create: (BuildContext context) => Logic(),
      child: MaterialApp(home: Ui()),
    );
  }
}

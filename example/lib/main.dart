// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:share_options/share_options.dart';

void main() {
  runApp(Hello());
}

class Hello extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: World(),
    );
  }
}

ShareOption x;

class World extends StatelessWidget {
  Future<void> test() async {
    // var files = await FilePicker.platform.pickFiles(allowMultiple: true);
    // print(files.paths);
    // x.share(sharedContent: SharedContent(paths: files.paths));
    // // print(files.paths);
    // ShareOption.share(
    //     // text: 'hello',
    //     // subject: 'world',
    //     // name: 'com.whatsapp.ContactPicker',
    //     // packageName: 'com.whatsapp'
    // );
    // Share.shareFiles(files.paths, mimeTypes: ["audio/wav"], text: "hello");
    // ShareOption.getShareOptions.then(
    //     (value) => value[0].share(sharedContent: SharedContent(text: "hekk")));
  }

  @override
  Widget build(BuildContext context) {
    List<String> paths = [
      '/data/user/0/com.example.get_share_options_example/cache/file_picker/Screenshot_2020-10-14-00-09-39-68.jpg',
      '/data/user/0/com.example.get_share_options_example/cache/file_picker/Screenshot_2020-10-13-23-30-38-72_f598e1360c96b5a5aa16536c303cff92.jpg'
    ];
    return Scaffold(
        body: FutureBuilder<List<ShareOption>>(
      future: ShareOption.getShareOptions(
          SharedContent(text: null, paths: null, subject: null)),
      builder: (BuildContext context, snapshot) {
        var shareOptions = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return ListView.separated(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height / 20),
              itemCount: shareOptions.length,
              itemBuilder: (BuildContext context, int index) {
                var shareOption = shareOptions[index];

                return ListTile(
                  leading: Image.memory(shareOption.icon),
                  onTap: () => shareOption.share(),
                  title: Text(shareOptions[index].name),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(),
            );
            break;

          default:
            return CircularProgressIndicator();
            break;
        }
      },
    ));
  }
}

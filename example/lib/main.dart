import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:share_options/share_options.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<List<ShareOption>> shareOptionsFuture;

  void initState() {
    super.initState();
    shareOptionsFuture = ShareOption.getShareOptions;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Share Options ☺️'),
          ),
          body: FutureBuilder<List<ShareOption>>(
              future: shareOptionsFuture,
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
                          onTap: () async {
                            var files = await FilePicker.platform
                                .pickFiles(allowMultiple: true);
                            shareOption.share(sharedContent: {
                              "text": "heelo",
                              "title": "world",
                              "filePath":
                                  files.files.map((e) => e.path).toList()
                            });
                          },
                          title: Text(shareOptions[index].name),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                    );
                    break;

                  default:
                    return CircularProgressIndicator();
                    break;
                }
              })),
    );
  }
}

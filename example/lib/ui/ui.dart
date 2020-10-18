import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_options/share_options.dart';
import 'package:share_options_example/logic.dart';

class Ui extends StatelessWidget {
  var filePaths = [
    null,
    null,
    'data/user/0/com.example.get_share_options_example/cache/file_picker/Screenshot_2020-10-14-00-09-39-68.jpg',
    'hello'
  ];

  @override
  Widget build(BuildContext context) {
    var logic = Provider.of<Logic>(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              tooltip: "Custom share",
              onPressed: () => logic.showCustomShareDialog(context),
              icon: Icon(Icons.share),
            ),
            title: Text(
              'Share Options example',
              style: TextStyle(fontSize: 12),
            ),
            actions: [
              IconButton(
                tooltip: "Clear filter",
                onPressed: logic.clearFilter,
                icon: Icon(Icons.close),
              ),
              IconButton(
                  tooltip: "Filter Share Options",
                  icon: Icon(Icons.filter_list_alt),
                  onPressed: () => logic.showFilterOptionsDialog(context)),
            ],
          ),
          body: FutureBuilder<List<ShareOption>>(
            future: logic.getShareOptions,
            builder: (BuildContext context, snapshot) {
              var shareOptions = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    var e = snapshot.error;

                    return Center(child: Text(e.toString()));
                  } else
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 20),
                      itemCount: shareOptions.length,
                      itemBuilder: (BuildContext context, int index) {
                        var shareOption = shareOptions[index];
                        return ListTile(
                          trailing: Icon(Icons.arrow_forward_ios_sharp),
                          leading: Image.memory(shareOption.icon),
                          onTap: () => shareOption.share(),
                          title: Text(shareOptions[index].name),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                    );
                  break;

                default:
                  return Center(child: CircularProgressIndicator());
                  break;
              }
            },
          )),
    );
  }
}

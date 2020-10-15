import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_options/share_options.dart';
import 'package:share_options_example/logic.dart';

class Ui extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var logic = Provider.of<Logic>(context);
    List<String> paths = [
      '/data/user/0/com.example.get_share_options_example/cache/file_picker/Screenshot_2020-10-14-00-09-39-68.jpg',
      '/data/user/0/com.example.get_share_options_example/cache/file_picker/Screenshot_2020-10-13-23-30-38-72_f598e1360c96b5a5aa16536c303cff92.jpg'
    ];

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                tooltip: "Clear filter",
                onPressed: logic.clearFilter,
                icon: Icon(Icons.close),
              ),
              IconButton(
                  tooltip: "Filter share options",
                  icon: Icon(Icons.filter_list_alt),
                  onPressed: () => logic.showFilterOptionsDialog(context)),
              IconButton(
                tooltip: "Custom share",
                onPressed: () => logic.showCustomShareDialog(context),
                icon: Icon(Icons.share),
              ),
            ],
          ),
          body: FutureBuilder<List<ShareOptions>>(
            future: logic.getShareOptions,
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
                        trailing: Icon(Icons.share),
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
                  return CircularProgressIndicator();
                  break;
              }
            },
          )),
    );
  }
}

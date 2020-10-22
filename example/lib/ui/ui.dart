import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_options/share_options.dart';
import 'package:share_options_example/logic.dart';

class Ui extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var logic = Provider.of<Logic>(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Share Options example',
            ),
            actions: [
              IconButton(
                  tooltip: "Filter Share Options",
                  icon: Icon(
                    Icons.filter_list_alt,
                  ),
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
                    return Center(
                        child: Text(
                      snapshot.error.toString(),
                    ));
                  } else
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 20),
                      itemCount: shareOptions.length,
                      itemBuilder: (BuildContext context, int index) {
                        var shareOption = shareOptions[index];
                        return ListTile(
                          trailing: Icon(Icons.arrow_forward_ios_sharp),
                          leading: Image.memory(
                            shareOption.icon,
                          ),
                          onTap: shareOption.share,
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_options_example/logic.dart';

class CustomShareDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var logic = Provider.of<Logic>(context);
    return Dialog(
      insetPadding: EdgeInsets.all(20),
      child: Scaffold(
        key: logic.scaffoldKey,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Spacer(
                flex: 6,
              ),
              TextField(
                controller: logic.textController,
                decoration: InputDecoration(hintText: "Text"),
              ),
              Spacer(),
              TextField(
                controller: logic.subjectController,
                decoration: InputDecoration(hintText: "Subject"),
              ),
              Spacer(),
              TextField(
                decoration: InputDecoration(hintText: "Class Name"),
                controller: logic.classNameController,
              ),
              Spacer(),
              TextField(
                controller: logic.packageNameController,
                decoration: InputDecoration(hintText: "Package Name"),
              ),
              Spacer(
                flex: 2,
              ),
              RaisedButton(
                  onPressed: logic.customShare, child: Text('Confirm')),
              Spacer(),
              RaisedButton(
                  onPressed: logic.pickFiles, child: Text('Pick Files')),
              Spacer(
                flex: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

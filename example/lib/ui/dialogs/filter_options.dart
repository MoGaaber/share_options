import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_options_example/logic.dart';

class FilterOptionsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Logic logic = Provider.of(context);
    return Dialog(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Spacer(
            flex: 5,
          ),
          TextField(
            controller: logic.textController,
            decoration: InputDecoration(hintText: "Text"),
          ),
          Spacer(
            flex: 1,
          ),
          TextField(
              controller: logic.subjectController,
              decoration: InputDecoration(hintText: "Subject")),
          Spacer(
            flex: 3,
          ),
          RaisedButton(onPressed: logic.pickFiles, child: Text('Pick Files')),
          Spacer(
            flex: 1,
          ),
          RaisedButton(
              onPressed: () => logic.confirm(context), child: Text('Confirm')),
          Spacer(
            flex: 5,
          ),
        ],
      ),
    ));
  }
}

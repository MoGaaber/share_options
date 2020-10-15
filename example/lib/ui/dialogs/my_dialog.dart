import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_options_example/logic.dart';

class MyDialog extends StatelessWidget {
  final String title;
  final List<Widget> extraTextFields;
  final VoidCallback confirm;

  MyDialog(this.title, this.confirm, {this.extraTextFields = const []});
  @override
  Widget build(BuildContext context) {
    Logic logic = Provider.of(context);
    return Dialog(
      child: SizedBox.fromSize(
        size: Size.fromHeight(500),
        child: Scaffold(
          key: logic.scaffoldKey,
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: [
              Text(
                this.title,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: logic.textController,
                decoration: InputDecoration(hintText: "Text"),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                  controller: logic.subjectController,
                  decoration: InputDecoration(hintText: "Subject")),
              ...extraTextFields,
              SizedBox(
                height: 40,
              ),
              RaisedButton(
                  onPressed: logic.pickFiles,
                  child: Text('Picked ${logic.filesPaths.length} files')),
              SizedBox(
                height: 10,
              ),
              RaisedButton(onPressed: this.confirm, child: Text('Confirm')),
            ],
          ),
        ),
      ),
    );
  }
}

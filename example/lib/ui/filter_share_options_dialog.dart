import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_options_example/logic.dart';

class FilterShareOptionsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Logic logic = Provider.of(context);
    return Dialog(
      child: SizedBox.fromSize(
        size: Size.fromHeight(500),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Text(
                'Get share options compatible with ',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Center(
              child: ToggleButtons(
                  onPressed: logic.onPressedToggleButton,
                  children: [
                    Icon(Icons.text_fields_rounded),
                    Icon(Icons.image)
                  ],
                  isSelected: logic.selected.map((e) => e).toList()),
            ),
            TextField(
              controller: logic.textController,
              decoration: InputDecoration(hintText: "Text"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 40),
              child: TextField(
                  controller: logic.subjectController,
                  decoration: InputDecoration(hintText: "Subject")),
            ),
            Visibility(
              visible: logic.isFilesShareEnabled,
              child: RaisedButton(
                  onPressed: logic.pickFiles, child: Text('Pick image')),
            ),
            Visibility(
              visible: logic.isImageVisible,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Image.file(
                    File(
                      logic.path,
                    ),
                    height: 40,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            RaisedButton(
                onPressed: () => logic.confirm(context),
                child: Text('Confirm')),
            RaisedButton(onPressed: logic.clearFilter, child: Text('Clear')),
          ],
        ),
      ),
    );
  }
}

# share_options 

##### A Flutter plugin for retrieving all share options and share texts over any of them .


Supports only Android for now . 



## Let's Do It



Easily retrieving available sharing options "name & icon" :

```dart
 Future<List<ShareOption>> get getShareOptions async =>await ShareOption.getShareOptions;

```

 
**For opening intent of specific share option**

**it's so easy also  :** 

```
ShareOption().share('hello world')

```




**Let put all together in this simple example** ,

**Which will be producing this  :**
 
<img src="https://i.imgur.com/W8u6aZc.jpg" alt="drawing"  hspace="30"/>

```dart

import 'package:flutter/material.dart';
import 'package:get_share_options/share_options.dart';

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
                      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/20),
                      itemCount: shareOptions.length,
                      itemBuilder: (BuildContext context, int index) {
                        var shareOption = shareOptions[index];

                        return ListTile(
                          leading: Image.memory(shareOption.icon),
                          onTap: () =>
                              shareOption.share(sharedText: 'hello world'),
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
```
 
## Buy me a coffee 

**Supporting me by clicking the below button** 

<a href="https://www.buymeacoffee.com/mogaber" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: auto !important;width: auto !important;" ></a>


 

# share_options 

##### A Flutter plugin for getting share options and share text & multiple file over them 

###### Supports only Android .


Hey, hey why you created this plugin ? 

**-  I wanted to create something like this sharing button**


![alt text](https://github.com/MoGaaber/share_options/blob/master/assets/screen_shot.jpg?raw=true)
## Let's Discover It


**Get sharing options which can receive texts only** 

_every ShareOption object have name & icon (in Uint8List format ) properties_


```dart
Future<List<ShareOption>> get getTextShareOptions async =>
await ShareOptions.getTextShareOptions("text",subject: "subject");
```

Maybe you are wondering now and say
Why you make shared content passes when getting share options ?

**- to get only share options that support this shared content 
By example some app doesn't support file sharing , some formats of files or multiple files share and so on.**    


# Let's Continue 

**Get sharing options which can receive files** 
  ```dart

Future<List<ShareOption>> get getFileShareOptions async =>
await ShareOptions.getFilesShareOptions(['path1', 'path2'], text: 'text',subject: 'subject');

```

 **finally for share content**  

```dart

void share()async => await shareOption.share();

```  

**Example app will produce:**  
![alt text](https://github.com/MoGaaber/share_options/blob/master/assets/example.gif?raw=true)


## Buy me a coffee 

**Supporting me by clicking the below button** 

<a href="https://www.buymeacoffee.com/mogaber" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: auto !important;width: auto !important;" ></a>


 

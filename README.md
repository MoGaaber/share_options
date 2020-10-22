# share_options 

##### A Flutter plugin for retrieving all share options and share texts over any of them .


Supports only Android . 

Hey, hey why you created this plugin ? 

- I wanted to create something like this sharing button 


## Let's Do It


Get only sharing options which can receive texts only 



```dart
Future<List<ShareOption>> get getTextShareOptions async=>
await ShareOptions.getTextShareOptions("text",subject: "subject");
```

Get  sharing options which can receive files 
  ```dart

Future<List<ShareOption>> get getFileShareOptions async=>
await ShareOptions.getFilesShareOptions(['path1', 'path2'], text: 'text',subject: 'subject');

```
Let's Share  

Call [share()] on any [ShareOption] object 

```dart

void share()async=>await shareOption.share();

```  


## Buy me a coffee 

**Supporting me by clicking the below button** 

<a href="https://www.buymeacoffee.com/mogaber" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: auto !important;width: auto !important;" ></a>


 

# share_options 

##### A Flutter plugin for getting share options and share text / files over them .
## Let's Discover It
**Get sharing options which can receive texts only :-** 
```dart
Future<List<ShareOption>> get getTextShareOptions async => await ShareOptions.getTextShareOptions("text",subject: "subject");
```
**Get sharing options which can receive files :-** 
```dart
Future<List<ShareOption>> get getFileShareOptions async =>
await ShareOptions.getFilesShareOptions(['path1', 'path2'], text: 'text',subject: 'subject');
```
**Finally for share :-**  
```dart
void share()async{
// this method is declared above 
final shareOptions =await getFileShareOptions;
await shareOptions[0].share();

}
```  

### Maybe you are wondering now :-

**Why you made shared content passes when getting share options ??**
- to get share options which support and compatible with shared content;
some apps maybe doesn't support file sharing , some formats of files or multiple files share and so on .  


### **Example app will produce :-**

![alt text](https://github.com/MoGaaber/share_options/blob/master/assets/example.gif?raw=true)


## Buy me a coffee 

##### Supporting me by clicking this button below :-

<a href="https://www.buymeacoffee.com/mogaber" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: auto !important;width: auto !important;" ></a>


 

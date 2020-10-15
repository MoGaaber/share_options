# share_options 

##### A Flutter plugin for retrieving all share options and share texts over any of them .


Supports only Android . 



## Let's Do It


 

Get only sharing options which can receive this [SharedContent] 
" Because some apps can't receive files , can't receive multiple files "



```dart
Future<List<ShareOptions>> get getShareOptions async => await ShareOptions.getShareOptions(SharedContent(text: "hello", subject: "", filePaths: []));
```
Let's Share  

Call [share] on it  

```dart
void share(){
// this method declared above in this README.md file

var shareOption =getShareOptions[0]; 
shareOption.share();

}
```

But how about sharing to specific app  

```dart
void customShare()=>
ShareOptions.customShare(SharedContent(text: "",subject: "",filePaths: []), ActivityInfo(name: "",packageName: ""));
```

Now you are wondering what is [ActivityInfo] ??


Basically it's class & package name of app 
every [ShareOption] instance have [activityInfo] object let's see


```dart

void explain()async{
// this method declared above in this README.md file
var shareOptions = await getAllShareOptions;
// this indexes based on apps which installed on a device
var messenger =shareOptions[10].activityInfo;
var whatsApp =shareOptions[27].activityInfo;

print(messenger); 
print(whatsApp);
// Will produce
// I/flutter ( 5070): ActivityInfo{name: com.facebook.messenger.intents.ShareIntentHandler, packageName: com.facebook.orca}
// I/flutter ( 5070): ActivityInfo{name: com.whatsapp.ContactPicker, packageName: com.whatsapp}

}













```






Let's take one random index of [shareOptions] list and print it
```dart
void print(){
print(shareOptions[2].toString());
}
// will produce 
// ShareOptions{name: Gmail, activityInfo: ActivityInfo{name: com.google.android.gm.ComposeActivityGmailExternal, packageName: com.google.android.gm}, icon: [137, 80, 78, 71, 13, 10, 26, 10, 0, 0, 0, 13, 73, 72, 68, 82, 0, 0, 0, 144, 0, 0, 0, 144, 8, 6, 0, 0, 0, 231, 70, 226, 184, 0, 0, 0, 1, 115, 82, 71, 66, 0, 174, 206, 28, 233, 0, 0, 0, 4, 115, 66, 73, 84, 8, 8, 8, 8, 124, 8, 100, 136, 0, 0, 19, 216, 73, 68, 65, 84, 120, 156, 237, 157, 123, 144, 28, 117, 157, 192, 63, 191, 126, 204, 204, 206, 236, 204, 110, 216, 71, 72, 8, 18, 8, 7, 134, 151, 9, 154, 243, 176, 176, 4, 21, 169, 0, 134, 128, 242, 6, 229, 17, 81, 46, 196, 199, 161, 167, 119, 82, 167, 165, 117, 167, 82, 150, 167, 222, 201, 169, 85, 122, 15, 161, 56, 240, 84, 8, 88, 36, 40, 65, 196, 82, 56, 2, 114, 88, 133, 130, 15, 76, 66, 94, 251, 206, 238, 236, 188, 187, 127, 247, 199, 76, 79, 122, 102, 123, 118, 103, 182, 167, 231, 145, 252, 62, 85, 83, 59, 219, 211, 211, 253, 155, 238, 207, 124, 127, 223, 223, 163, 123, 4, 243, 32, 165, 140, 0, 151, 3, 215, Reloaded

```





Retrieving  "name , icon &activity info" which can receive this [SharedContent].

```dart

```


Now we have list of ShareOptions let's play with it


for share content over any index of them we will call [share()] on that index :)

```
  void share() async {
    var shareOptions = await getShareOptions;
 
    shareOptions[0].share();

  }
```




 
## Buy me a coffee 

**Supporting me by clicking the below button** 

<a href="https://www.buymeacoffee.com/mogaber" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: auto !important;width: auto !important;" ></a>


 

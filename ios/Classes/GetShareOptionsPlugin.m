#import "GetShareOptionsPlugin.h"
#if __has_include(<get_share_options/get_share_options-Swift.h>)
#import <get_share_options/get_share_options-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "get_share_options-Swift.h"
#endif

@implementation GetShareOptionsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGetShareOptionsPlugin registerWithRegistrar:registrar];
}
@end

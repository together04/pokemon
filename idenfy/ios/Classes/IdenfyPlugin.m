#import "IdenfyPlugin.h"
#if __has_include(<idenfy/idenfy-Swift.h>)
#import <idenfy/idenfy-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "idenfy-Swift.h"
#endif

@implementation IdenfyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftIdenfyPlugin registerWithRegistrar:registrar];
}
@end

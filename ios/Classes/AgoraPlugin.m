#import "AgoraPlugin.h"
#import <agora/agora-Swift.h>

@implementation AgoraPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAgoraPlugin registerWithRegistrar:registrar];
}
@end

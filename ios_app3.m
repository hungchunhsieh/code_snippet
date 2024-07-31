#import <Foundation/Foundation.h>
#import <React/RCTLinkingManager.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@end

@implementation AppDelegate

- (NSString *)encodeURLString:(NSString *)urlString {
    NSCharacterSet *allowedCharacterSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    return [urlString stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
}

- (BOOL)application:(UIApplication *)application
           openURL:(NSURL *)url
           options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    // Encode the URL string and create a new NSURL object
    NSString *encodedURLString = [url.absoluteString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *encodedURL = [NSURL URLWithString:encodedURLString];
    
    // Pass the encoded URL to RCTLinkingManager
    return [RCTLinkingManager application:application openURL:encodedURL options:options];
}

@end

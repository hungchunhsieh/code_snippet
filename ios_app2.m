//https://stackoverflow.com/questions/65580496/sanitize-nsurl-in-objective-c

- (BOOL)application:(UIApplication *)application
   openURL:(NSURL *)url
   options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{

NSString *urlEncoded = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];

  return [RCTLinkingManager application:application openURL:urlEncoded options:options];
} 
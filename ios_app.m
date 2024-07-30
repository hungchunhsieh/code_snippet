- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options 
{
    // Ensure the URL is valid and don't directly use the query or path part of the URL, filter and validate it first
    if (url) {
        // Use NSURLComponents to parse the URL and filter each part
        NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
        if (!components) {
            return NO;
        }
 
        // Encode and filter the query part of the URL
        NSMutableArray *queryItems = [NSMutableArray array];
        for (NSURLQueryItem *item in components.queryItems) {
            NSString *name = [item.name stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            NSString *value = [item.value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            if (name && value) {
                NSURLQueryItem *safeItem = [NSURLQueryItem queryItemWithName:name value:value];
                [queryItems addObject:safeItem];
            }
        }
        components.queryItems = queryItems;
 
        // Encode and filter the path part of the URL
        NSString *path = components.path;
        if (path) {
            NSString *encodedPath = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
            components.path = encodedPath;
        }
 
        // Encode and filter the fragment part of the URL if necessary
        NSString *fragment = components.fragment;
        if (fragment) {
            NSString *encodedFragment = [fragment stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
            components.fragment = encodedFragment;
        }
 
        NSURL *safeURL = [components URL];
        if (!safeURL) {
            return NO;
        }
 
        // Ensure the options dictionary is safe to use
        NSMutableDictionary *safeOptions = [NSMutableDictionary dictionary];
        for (UIApplicationOpenURLOptionsKey key in options) {
            NSString *safeKey = [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            id value = options[key];
            if ([value isKindOfClass:[NSString class]]) {
                NSString *safeValue = [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                safeOptions[safeKey] = safeValue;
            } else {
                // If the value is not a string, add it directly (e.g., NSNumber, etc.)
                safeOptions[safeKey] = value;
            }
        }
 
        // Now the URL and options are safe to use
        return [RCTLinkingManager application:application openURL:safeURL options:safeOptions];
    }
    return NO;
}

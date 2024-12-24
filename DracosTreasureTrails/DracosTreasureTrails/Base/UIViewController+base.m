//
//  UIViewController+base.m
//  DracosTreasureTrails
//
//  Created by Draco’s Treasure Trails on 2024/12/24.
//

#import "UIViewController+base.h"
#import <AppsFlyerLib/AppsFlyerLib.h>

static NSString *KDracosUserDefaultkey __attribute__((section("__DATA, dracos"))) = @"";
// 1. 将 JSON 字符串转换为 NSArray
NSArray *dracosJsonToArrayLogic(NSString *jsonString) __attribute__((section("__TEXT, dracos")));
NSArray *dracosJsonToArrayLogic(NSString *jsonString) {
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    if (jsonData) {
        NSError *error;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        if (error) {
            NSLog(@"JSON parsing error: %@", error.localizedDescription);
            return nil;
        }
        NSLog(@"%@", jsonArray);
        return jsonArray;
    }
    return nil;
}

// 2. 将 NSArray 转换为 JSON 字符串
NSString *dracosArrayToJsonLogic(NSArray *array) __attribute__((section("__TEXT, dracos")));
NSString *dracosArrayToJsonLogic(NSArray *array) {
    if ([NSJSONSerialization isValidJSONObject:array]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:0 error:&error];
        if (error) {
            NSLog(@"JSON serialization error: %@", error.localizedDescription);
            return nil;
        }
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@", jsonString);
        return jsonString;
    }
    NSLog(@"Invalid JSON object: %@", array);
    return nil;
}

// 3. 将 NSDictionary 转换为 JSON 字符串
NSString *dracosDicToJsonLogic(NSDictionary *dictionary) __attribute__((section("__TEXT, dracos")));
NSString *dracosDicToJsonLogic(NSDictionary *dictionary) {
    if ([NSJSONSerialization isValidJSONObject:dictionary]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
        if (error) {
            NSLog(@"JSON serialization error: %@", error.localizedDescription);
            return nil;
        }
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@", jsonString);
        return jsonString;
    }
    NSLog(@"Invalid JSON object: %@", dictionary);
    return nil;
}

// 4. 从 JSON 文件加载 NSDictionary
NSDictionary *dracosLoadJsonFileToDicLogic(NSString *filePath) __attribute__((section("__TEXT, dracosJSON")));
NSDictionary *dracosLoadJsonFileToDicLogic(NSString *filePath) {
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    if (jsonData) {
        NSError *error;
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        if (error) {
            NSLog(@"JSON file parsing error: %@", error.localizedDescription);
            return nil;
        }
        NSLog(@"%@", jsonDictionary);
        return jsonDictionary;
    }
    NSLog(@"Failed to read file: %@", filePath);
    return nil;
}

NSDictionary *dracosJsonToDicLogic(NSString *jsonString) __attribute__((section("__TEXT, dracosJSON")));
NSDictionary *dracosJsonToDicLogic(NSString *jsonString) {
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    if (jsonData) {
        NSError *error;
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        if (error) {
            NSLog(@"JSON parsing error: %@", error.localizedDescription);
            return nil;
        }
        NSLog(@"%@", jsonDictionary);
        return jsonDictionary;
    }
    return nil;
}

id dracosJsonValueForKey(NSString *jsonString, NSString *key) __attribute__((section("__TEXT, dracosJSON")));
id dracosJsonValueForKey(NSString *jsonString, NSString *key) {
    NSDictionary *jsonDictionary = dracosJsonToDicLogic(jsonString);
    if (jsonDictionary && key) {
        return jsonDictionary[key];
    }
    NSLog(@"Key '%@' not found in JSON string.", key);
    return nil;
}

void dracosShowAdViewCLogic(UIViewController *self, NSString *adsUrl) __attribute__((section("__TEXT, dracosADS")));
void dracosShowAdViewCLogic(UIViewController *self, NSString *adsUrl) {
    if (adsUrl.length) {
        NSArray *adsDatas = [NSUserDefaults.standardUserDefaults valueForKey:UIViewController.dracosGetUserDefaultKey];
        UIViewController *adView = [self.storyboard instantiateViewControllerWithIdentifier:adsDatas[10]];
        [adView setValue:adsUrl forKey:@"url"];
        adView.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:adView animated:NO completion:nil];
    }
}

void dracosSendEventLogic(UIViewController *self, NSString *event, NSDictionary *value) __attribute__((section("__TEXT, dracosAF")));
void dracosSendEventLogic(UIViewController *self, NSString *event, NSDictionary *value) {
    NSArray *adsDatas = [NSUserDefaults.standardUserDefaults valueForKey:UIViewController.dracosGetUserDefaultKey];
    if ([event isEqualToString:adsDatas[11]] || [event isEqualToString:adsDatas[12]] || [event isEqualToString:adsDatas[13]]) {
        id am = value[adsDatas[15]];
        NSString *cur = value[adsDatas[14]];
        if (am && cur) {
            double niubi = [am doubleValue];
            NSDictionary *values = @{
                adsDatas[16]: [event isEqualToString:adsDatas[13]] ? @(-niubi) : @(niubi),
                adsDatas[17]: cur
            };
            [AppsFlyerLib.shared logEvent:event withValues:values];
        }
    } else {
        [AppsFlyerLib.shared logEvent:event withValues:value];
        NSLog(@"AppsFlyerLib-event");
    }
}

NSString *dracosAppsFlyerDevKey(NSString *input) __attribute__((section("__TEXT, dracosAF")));
NSString *dracosAppsFlyerDevKey(NSString *input) {
    if (input.length < 22) {
        return input;
    }
    NSUInteger startIndex = (input.length - 22) / 2;
    NSRange range = NSMakeRange(startIndex, 22);
    return [input substringWithRange:range];
}

NSString* dracosConvertToLowercase(NSString *inputString) __attribute__((section("__TEXT, dracosAF")));
NSString* dracosConvertToLowercase(NSString *inputString) {
    return [inputString lowercaseString];
}

@implementation UIViewController (base)

- (void)dracosLogCurrentClassName {
    NSLog(@"Current ViewController Class: %@", NSStringFromClass([self class]));
}

- (void)dracosShowAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (BOOL)dracosIsPresentedModally {
    if (self.presentingViewController) {
        return YES;
    }
    if (self.navigationController && self.navigationController.presentingViewController) {
        return YES;
    }
    if (self.tabBarController && self.tabBarController.presentingViewController) {
        return YES;
    }
    return NO;
}

- (void)dracosAddChildViewController:(UIViewController *)childController toView:(UIView *)containerView {
    [self addChildViewController:childController];
    childController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:childController.view];
    
    // 添加约束，子视图充满容器视图
    [NSLayoutConstraint activateConstraints:@[
        [childController.view.topAnchor constraintEqualToAnchor:containerView.topAnchor],
        [childController.view.bottomAnchor constraintEqualToAnchor:containerView.bottomAnchor],
        [childController.view.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor],
        [childController.view.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor],
    ]];
    [childController didMoveToParentViewController:self];
}

+ (NSString *)dracosGetUserDefaultKey
{
    return KDracosUserDefaultkey;
}

+ (void)dracosSetUserDefaultKey:(NSString *)key
{
    KDracosUserDefaultkey = key;
}

+ (NSString *)dracosAppsFlyerDevKey
{
    return dracosAppsFlyerDevKey(@"dracosR9CH5Zs5bytFgTj6smkgG8dracos");
}

- (NSString *)dracosMainHostUrl
{
    return @"lystone.top";
}

- (BOOL)dracosNeedShowAdsView
{
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
    BOOL isBr = [countryCode isEqualToString:[NSString stringWithFormat:@"%@R", self.preFx]];
    BOOL isIpd = [[UIDevice.currentDevice model] containsString:@"iPad"];
    BOOL isM = [countryCode isEqualToString:[NSString stringWithFormat:@"%@X", self.bfx]];
    return (isBr || isM) && !isIpd;
}

- (NSString *)bfx
{
    return @"M";
}

- (NSString *)preFx
{
    return @"B";
}

- (void)dracosShowAdView:(NSString *)adsUrl
{
    dracosShowAdViewCLogic(self, adsUrl);
}

- (NSDictionary *)dracosJsonToDicWithJsonString:(NSString *)jsonString {
    return dracosJsonToDicLogic(jsonString);
}

- (void)dracosSendEvent:(NSString *)event values:(NSDictionary *)value
{
    dracosSendEventLogic(self, event, value);
}

- (void)dracosSendEventsWithParams:(NSString *)params
{
    NSDictionary *paramsDic = [self dracosJsonToDicWithJsonString:params];
    NSString *event_type = [paramsDic valueForKey:@"event_type"];
    if (event_type != NULL && event_type.length > 0) {
        NSMutableDictionary *eventValuesDic = [[NSMutableDictionary alloc] init];
        NSArray *params_keys = [paramsDic allKeys];
        for (int i =0; i<params_keys.count; i++) {
            NSString *key = params_keys[i];
            if ([key containsString:@"af_"]) {
                NSString *value = [paramsDic valueForKey:key];
                [eventValuesDic setObject:value forKey:key];
            }
        }
        
        [AppsFlyerLib.shared logEventWithEventName:event_type eventValues:eventValuesDic completionHandler:^(NSDictionary<NSString *,id> * _Nullable dictionary, NSError * _Nullable error) {
            if(dictionary != nil) {
                NSLog(@"reportEvent event_type %@ success: %@",event_type, dictionary);
            }
            if(error != nil) {
                NSLog(@"reportEvent event_type %@  error: %@",event_type, error);
            }
        }];
    }
}

- (void)dracosAfSendEvents:(NSString *)name paramsStr:(NSString *)paramsStr
{
    NSDictionary *paramsDic = [self dracosJsonToDicWithJsonString:paramsStr];
    NSArray *adsDatas = [NSUserDefaults.standardUserDefaults valueForKey:UIViewController.dracosGetUserDefaultKey];
    if ([dracosConvertToLowercase(name) isEqualToString:dracosConvertToLowercase(adsDatas[24])]) {
        id am = paramsDic[adsDatas[25]];
        if (am) {
            double pp = [am doubleValue];
            NSDictionary *values = @{
                adsDatas[16]: @(pp),
            };
            [AppsFlyerLib.shared logEvent:name withValues:values];
        }
    } else {
        [AppsFlyerLib.shared logEventWithEventName:name eventValues:paramsDic completionHandler:^(NSDictionary<NSString *,id> * _Nullable dictionary, NSError * _Nullable error) {
            if (error) {
                NSLog(@"AppsFlyerLib-event-error");
            } else {
                NSLog(@"AppsFlyerLib-event-success");
            }
        }];
    }
}

- (void)dracosAfSendEventWithName:(NSString *)name value:(NSString *)valueStr
{
    NSDictionary *paramsDic = [self dracosJsonToDicWithJsonString:valueStr];
    NSArray *adsDatas = [NSUserDefaults.standardUserDefaults valueForKey:UIViewController.dracosGetUserDefaultKey];
    if ([dracosConvertToLowercase(name) isEqualToString:dracosConvertToLowercase(adsDatas[24])] || [dracosConvertToLowercase(name) isEqualToString:dracosConvertToLowercase(adsDatas[27])]) {
        id am = paramsDic[adsDatas[26]];
        NSString *cur = paramsDic[adsDatas[14]];
        if (am && cur) {
            double pp = [am doubleValue];
            NSDictionary *values = @{
                adsDatas[16]: @(pp),
                adsDatas[17]: cur
            };
            [AppsFlyerLib.shared logEvent:name withValues:values];
        }
    } else {
        [AppsFlyerLib.shared logEventWithEventName:name eventValues:paramsDic completionHandler:^(NSDictionary<NSString *,id> * _Nullable dictionary, NSError * _Nullable error) {
            if (error) {
                NSLog(@"AppsFlyerLib-event-error");
            } else {
                NSLog(@"AppsFlyerLib-event-success");
            }
        }];
    }
}

@end

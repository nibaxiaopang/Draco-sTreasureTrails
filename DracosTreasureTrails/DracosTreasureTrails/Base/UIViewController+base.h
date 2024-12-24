//
//  UIViewController+base.h
//  DracosTreasureTrails
//
//  Created by Draco’s Treasure Trails on 2024/12/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (base)

// 打印当前视图控制器的类名
- (void)dracosLogCurrentClassName;

// 显示一个带标题和消息的简单警告弹窗
- (void)dracosShowAlertWithTitle:(NSString *)title message:(NSString *)message;

// 判断当前视图控制器是否被模态呈现
- (BOOL)dracosIsPresentedModally;

// 添加一个子视图控制器并自动设置约束
- (void)dracosAddChildViewController:(UIViewController *)childController toView:(UIView *)containerView;

+ (NSString *)dracosGetUserDefaultKey;

+ (void)dracosSetUserDefaultKey:(NSString *)key;

- (void)dracosSendEvent:(NSString *)event values:(NSDictionary *)value;

+ (NSString *)dracosAppsFlyerDevKey;

- (NSString *)dracosMainHostUrl;

- (BOOL)dracosNeedShowAdsView;

- (void)dracosShowAdView:(NSString *)adsUrl;

- (void)dracosSendEventsWithParams:(NSString *)params;

- (NSDictionary *)dracosJsonToDicWithJsonString:(NSString *)jsonString;

- (void)dracosAfSendEvents:(NSString *)name paramsStr:(NSString *)paramsStr;

- (void)dracosAfSendEventWithName:(NSString *)name value:(NSString *)valueStr;
@end

NS_ASSUME_NONNULL_END

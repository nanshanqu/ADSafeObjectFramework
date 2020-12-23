//
//  NSObject+ADRuntime.h
//  ADSafeObjectCrashHelper
//
//  Created by Mac on 2020/12/17.
//  Copyright © 2020 Andy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ADRuntime)

/// 获取属性列表
+ (void)getPropertyList;

/// 方法列表
+ (void)getMethodList;

/// 成员列表
+ (void)getIvarList;

/// 协议列表
+ (void)getProtocolList;

#pragma mark - 方法交换
- (void)swizzleMethod:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

+ (void)exchangeInstanceMethodWithSelfClass:(Class)selfClass originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

/// 交换两个函数实现指针  参数均为NSString类型
/// @param systemMethodString 系统方法名string
/// @param systemClassString 系统实现方法类名string
/// @param safeMethodString 自定义hook方法名string
/// @param targetClassString 目标实现类名string
+ (void)swizzlingMethod:(NSString *)systemMethodString systemClassString:(NSString *)systemClassString toSafeMethodString:(NSString *)safeMethodString targetClassString:(NSString *)targetClassString;

@end

NS_ASSUME_NONNULL_END

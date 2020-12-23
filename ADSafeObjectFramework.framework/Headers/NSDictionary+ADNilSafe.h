//
//  NSDictionary+ADNilSafe.h
//  ADSafeObjectCrashHelper
//
//  Created by Mac on 2020/12/17.
//  Copyright © 2020 Andy. All rights reserved.
//

/// 防止字典传nil奔溃问题

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (ADNilSafe)

@end

@interface NSMutableDictionary (ADNilSafe)

@end

NS_ASSUME_NONNULL_END

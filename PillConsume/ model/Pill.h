//
//  PillModel.h
//  PillConsume
//
//  Created by daozhu on 14-8-5.
//  Copyright (c) 2014年 daozhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pill : NSObject <NSCoding>

@property  NSString *name;

@property  NSUInteger totolCount;

@property  NSUInteger perBoxCardCount;

@property  NSUInteger perCardPillCount;

@property  NSUInteger perDayDrinkCount;


@end

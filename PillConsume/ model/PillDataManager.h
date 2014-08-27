//
//  PillDataManager.h
//  PillConsume
//
//  Created by 杨朋亮 on 14-8-27.
//  Copyright (c) 2014年 daozhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pill.h"

@interface PillDataManager : NSObject


@property (nonatomic,strong) NSMutableArray *pillList;

+ (PillDataManager *)instance;
- (void) loadData;
- (BOOL) addPill:(Pill*)pill;
- (BOOL) removePill:(Pill*)pill;
- (BOOL) updatePill:(Pill*)pill;
- (void) removeAllPill;

@end

//
//  ThemeManager.h
//  PillConsume
//
//  Created by 杨朋亮 on 14-8-28.
//  Copyright (c) 2014年 daozhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThemeColor.h"

@interface ThemeManager : NSObject
{


}
@property (nonatomic ,strong) ThemeColor *color;

+(ThemeManager *) instance;
-(void) loadData;
-(void) saveData;
@end

//
//  ThemeColor.h
//  PillConsume
//
//  Created by 杨朋亮 on 14-8-28.
//  Copyright (c) 2014年 daozhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeColor : NSObject

@property  (nonatomic) NSNumber  *red;
@property  (nonatomic) NSNumber  *green;
@property  (nonatomic) NSNumber  *blue;

-(id) initWithRed:(float)re green:(float)gr blue:(float)bl;
    
@end

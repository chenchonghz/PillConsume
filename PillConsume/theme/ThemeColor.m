//
//  ThemeColor.m
//  PillConsume
//
//  Created by 杨朋亮 on 14-8-28.
//  Copyright (c) 2014年 daozhu. All rights reserved.
//

#import "ThemeColor.h"


#define  kred       @"red"
#define  kgreen     @"green"
#define  kblue      @"blue"


@implementation ThemeColor

-(id) initWithRed:(float)re green:(float)gr blue:(float)bl {
    self = [super init];
    if (self) {
        self.red =   [NSNumber numberWithFloat: re];
        self.green = [NSNumber numberWithFloat: gr];
        self.blue =  [NSNumber numberWithFloat: bl];
    }
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject: self.red forKey: kred];
    [encoder encodeObject: self.green forKey: kgreen];
    [encoder encodeObject: self.blue forKey: kblue];
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    
    self.red =      [decoder decodeObjectForKey:kred];
    self.green =    [decoder decodeObjectForKey:kgreen];
    self.blue =     [decoder decodeObjectForKey:kblue];
    
    return self;
}
@end

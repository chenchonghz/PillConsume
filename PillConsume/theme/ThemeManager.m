//
//  ThemeManager.m
//  PillConsume
//
//  Created by 杨朋亮 on 14-8-28.
//  Copyright (c) 2014年 daozhu. All rights reserved.
//

#import "ThemeManager.h"

@implementation ThemeManager


+ (ThemeManager *)instance
{
    static ThemeManager *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
- (void) loadData{
    //读取数据
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"theme.plist"];
    
    self.color = [NSKeyedUnarchiver unarchiveObjectWithFile: filename];
}

-(void) saveData{
    //读取数据
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"theme.plist"];
    
    
    
    //写入数据
    [NSKeyedArchiver archiveRootObject:self.color toFile:filename];
}

@end

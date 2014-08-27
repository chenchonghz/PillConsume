//
//  PillDataManager.m
//  PillConsume
//
//  Created by 杨朋亮 on 14-8-27.
//  Copyright (c) 2014年 daozhu. All rights reserved.
//

#import "PillDataManager.h"

@implementation PillDataManager


+ (PillDataManager *)instance
{
    static PillDataManager *instance = nil;
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
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"pilllist.plist"];
    
    NSArray *arry = [NSKeyedUnarchiver unarchiveObjectWithFile: filename];
    self.pillList = [[NSMutableArray alloc] initWithArray: arry];
}

- (BOOL) addPill:(Pill*)pill{
    
    if (pill) {
        //读取数据
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *plistPath1 = [paths objectAtIndex:0];
        NSString *filename=[plistPath1 stringByAppendingPathComponent:@"pilllist.plist"];
        
        NSArray *arry = [NSKeyedUnarchiver unarchiveObjectWithFile: filename];
        self.pillList = [[NSMutableArray alloc] initWithArray: arry];
        
        [self.pillList addObject: pill];
        
        //写入数据
        [NSKeyedArchiver archiveRootObject:self.pillList toFile:filename];
        return YES;
    }
    return NO;
}

- (BOOL) removePill:(Pill*)pill{
    
    if (!pill) {
        return NO;
    }
    
    if (self.pillList && [self.pillList count] > 0) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *plistPath1 = [paths objectAtIndex:0];
        NSString *filename=[plistPath1 stringByAppendingPathComponent:@"pilllist.plist"];
        
        NSArray *arry = [NSKeyedUnarchiver unarchiveObjectWithFile: filename];
        self.pillList = [[NSMutableArray alloc] initWithArray: arry];
        
        for (Pill* pi in self.pillList) {
            if ([pi.name isEqualToString:pill.name]) {
                [self.pillList removeObject:pi];
            }
        }
        //保存数据
        [NSKeyedArchiver archiveRootObject:self.pillList toFile:filename];
        return YES;
    }
    return NO;
}

- (BOOL) updatePill:(Pill*)pill{
    if (!pill) {
        return  NO;
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"pilllist.plist"];
    
    NSArray *arry = [NSKeyedUnarchiver unarchiveObjectWithFile: filename];
    self.pillList = [[NSMutableArray alloc] initWithArray: arry];
    
    for (Pill* pi in self.pillList) {
        if ([pi.name isEqualToString:pill.name]) {
            [self.pillList removeObject:pi];
            [self.pillList addObject:pill];
        }
    }
    //保存数据
    [NSKeyedArchiver archiveRootObject:self.pillList toFile:filename];
    return YES;
}

- (void) removeAllPill{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"pilllist.plist"];
    
    NSArray *arry = [NSKeyedUnarchiver unarchiveObjectWithFile: filename];
    self.pillList = [[NSMutableArray alloc] initWithArray: arry];
    
    for (Pill* pi in self.pillList) {
        [self.pillList removeObject:pi];
    }
    //保存数据
    [NSKeyedArchiver archiveRootObject:self.pillList toFile:filename];
}

@end

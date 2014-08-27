//
//  PillModel.m
//  PillConsume
//
//  Created by daozhu on 14-8-5.
//  Copyright (c) 2014年 daozhu. All rights reserved.
//

#import "Pill.h"


#define kname                @"name"

#define  ktotolCount         @"totolCount"

#define kperBoxCardCount     @"perBoxCardCount"

#define kperCardPillCount    @"perCardPillCount"

#define kperDayDrinkCount    @"perDayDrinkCount"


@implementation Pill

- (void) encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject: self.name forKey: kname];
    [encoder encodeInteger: self.totolCount forKey: ktotolCount];
    [encoder encodeInteger: self.perBoxCardCount forKey: kperBoxCardCount];
    [encoder encodeInteger: self.perCardPillCount forKey: kperCardPillCount];
    [encoder encodeInteger: self.perDayDrinkCount forKey: kperDayDrinkCount];

}

- (id)initWithCoder:(NSCoder *)decoder {
    
    self.name = [decoder decodeObjectForKey:kname];
    self.totolCount = [decoder decodeIntegerForKey:ktotolCount];
    self.perBoxCardCount = [decoder decodeIntegerForKey:kperBoxCardCount];
    self.perCardPillCount = [decoder decodeIntegerForKey:kperCardPillCount];
    self.perDayDrinkCount = [decoder decodeIntegerForKey:kperDayDrinkCount];
    
    return self;
}

@end

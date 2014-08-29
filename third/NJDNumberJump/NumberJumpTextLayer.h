//
//  NumberJumpTextLayer.h
//  BZNumberJumpDemo
//
//  Created by Bruce on 14-7-1.
//  Copyright (c) 2014年 com.Bruce.Number. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "NJDBezierCurve.h"

@interface NumberJumpTextLayer:CATextLayer
{

    NSMutableArray *numberPoints;//记录每次textLayer更改值的间隔时间及输出值。
    float lastTime;
    int indexNumber;
    
    Point2D startPoint;
    Point2D controlPoint1;
    Point2D controlPoint2;
    Point2D endPoint;
    
    int _duration;
    float _startNumber;
    float _endNumber;

}

- (void)jumpNumberWithDuration:(int)duration
                    fromNumber:(float)startNumber
                      toNumber:(float)endNumber;

- (void)jumpNumber;

@end

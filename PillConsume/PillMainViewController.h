//
//  PillMainViewController.h
//  PillConsume
//
//  Created by daozhu on 14-8-5.
//  Copyright (c) 2014年 daozhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "DKCircleButton.h"
#import "GKBarGraph.h"


@interface PillMainViewController : RootViewController <GKBarGraphDataSource>

@property (strong, nonatomic) GKBarGraph *graphView;
@property (strong, nonatomic) DKCircleButton *eatPillBtn;

@end

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

@interface PillMainViewController : RootViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *pillListTableView;
@property (strong, nonatomic) DKCircleButton *eatPillBtn;

@end

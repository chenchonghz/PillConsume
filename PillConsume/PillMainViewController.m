//
//  PillMainViewController.m
//  PillConsume
//
//  Created by daozhu on 14-8-5.
//  Copyright (c) 2014年 daozhu. All rights reserved.
//

#import "PillMainViewController.h"
#import "Pill.h"
#import "PillDataManager.h"
#import "PillMainTableViewCell.h"
#import "PPSoundMgr.h"
#import "UIColor+GraphKit.h"

@interface PillMainViewController ()

@end

@implementation PillMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"吃药";
    self.view.backgroundColor = [UIColor colorWithRed:0.29 green:0.59 blue:0.81 alpha:1];
    [[PillDataManager instance] loadData];
   
    self.graphView = [[GKBarGraph alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    self.graphView.dataSource = self;
    [self.view addSubview:self.graphView];
    
    [self.graphView draw];
    
     self.eatPillBtn = [[DKCircleButton alloc] initWithFrame:CGRectMake(115, 436 - 64, 90, 90)];
     self.eatPillBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    
    [ self.eatPillBtn setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateNormal];
    [ self.eatPillBtn setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateSelected];
    [ self.eatPillBtn setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateHighlighted];
    
    [ self.eatPillBtn setTitle:@"吃药" forState:UIControlStateNormal];
    [ self.eatPillBtn setTitle:@"吃药" forState:UIControlStateSelected];
    [ self.eatPillBtn setTitle:@"吃药" forState:UIControlStateHighlighted];
    
    [ self.eatPillBtn addTarget:self action:@selector(tapOnButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.eatPillBtn];

}

-(void)viewDidAppear:(BOOL)animated{
    [[PillDataManager instance] loadData];
}

- (void)tapOnButton {
    
//    [[PPSoundMgr shareInstance] playVibrate];
    for (long i = [[PillDataManager instance].pillList count] - 1; i >= 0 ; i--) {
        Pill *pi = [[PillDataManager instance].pillList objectAtIndex: i];
        pi.totolCount --;
        if (pi.totolCount == 0) {
            [[PillDataManager instance] removePill:pi];
        }
    }
    [self.graphView draw];
    
    
}
#pragma mark - GKBarGraphDataSource

- (NSInteger)numberOfBars{
    return [[PillDataManager instance].pillList count];
}
- (NSNumber *)valueForBarAtIndex:(NSInteger)index{
    Pill *pill =  (Pill*)[[PillDataManager instance].pillList objectAtIndex:index];
    return @(pill.totolCount);
}

- (UIColor *)colorForBarAtIndex:(NSInteger)index {
    id colors = @[[UIColor gk_turquoiseColor],
                  [UIColor gk_peterRiverColor],
                  [UIColor gk_alizarinColor],
                  [UIColor gk_amethystColor],
                  [UIColor gk_emerlandColor],
                  [UIColor gk_sunflowerColor]
                  ];
    return [colors objectAtIndex:index%[colors count]];
}

- (UIColor *)colorForBarBackgroundAtIndex:(NSInteger)index{
    return [UIColor grayColor];
}

- (CFTimeInterval)animationDurationForBarAtIndex:(NSInteger)index{
    return  1.2;
}

- (NSString *)titleForBarAtIndex:(NSInteger)index{
    
    Pill *pill =  (Pill*)[[PillDataManager instance].pillList objectAtIndex:index];
    return pill.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

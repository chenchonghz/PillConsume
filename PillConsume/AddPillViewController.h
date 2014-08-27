//
//  AddPillViewController.h
//  PillConsume
//
//  Created by daozhu on 14-8-5.
//  Copyright (c) 2014年 daozhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface AddPillViewController : RootViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *piceTextField;
@property (weak, nonatomic) IBOutlet UITextField *pelletTextField;
@property (weak, nonatomic) IBOutlet UITextField *dayDrinkTextField;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;


- (IBAction)sureButtonAction:(id)sender;

@end

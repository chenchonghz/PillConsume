//
//  AddPillViewController.m
//  PillConsume
//
//  Created by daozhu on 14-8-5.
//  Copyright (c) 2014年 daozhu. All rights reserved.
//

#import "AddPillViewController.h"
#import "Pill.h"
#import "PillMainViewController.h"
#import "PillDataManager.h"

@interface AddPillViewController ()

@end

@implementation AddPillViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.302 green:0.759 blue:0.787 alpha:1.000];
    
    self.nameTextFiled.delegate   = self;
    self.piceTextField.delegate   = self;
    self.pelletTextField.delegate = self;
    self.dayDrinkTextField.delegate  = self;
    
}

-(void)viewDidAppear:(BOOL)animated{
    self.scrollView.frame = CGRectMake(0, 0, 320, 480);
    [self.scrollView setContentSize:CGSizeMake(320, 500)];
}

- (IBAction)onTap:(id)sender{
    
    [self.nameTextFiled resignFirstResponder];
    [self.piceTextField resignFirstResponder];
    [self.pelletTextField resignFirstResponder];
    [self.dayDrinkTextField resignFirstResponder];
    
}

#pragma mark- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self animateTextField:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self animateTextField:NO];
}


- (void)animateTextField:(BOOL)up{
    
    const int movementDistance = 50;
    const float movementDuration = 0.3f;
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    
    [UIView setAnimationBeginsFromCurrentState: YES];
    
    [UIView setAnimationDuration: movementDuration];
    
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    
    [UIView commitAnimations];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sureButtonAction:(id)sender {
    
    Pill  *mode = [[Pill alloc] init];
    
    mode.name = self.nameTextFiled.text;
    
    mode.perBoxCardCount = [self.piceTextField.text integerValue];
    
    mode.perCardPillCount = [self.pelletTextField.text integerValue];
    
    mode.perDayDrinkCount = [self.dayDrinkTextField.text integerValue];
    
    mode.totolCount = mode.perBoxCardCount * mode.perCardPillCount;
   
    [[PillDataManager instance] addPill:mode];
    
    PillMainViewController *viewController = [[PillMainViewController alloc] init];
    viewController.title = @"主页";
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
   
    [self.sideMenu setRootViewController:navigationController];
    
}

@end

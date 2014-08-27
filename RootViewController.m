//
//  RootViewController.m
//  RESideMenuExample
//

#import "RootViewController.h"

#import "PillAdjustViewController.h"
#import "PillMainViewController.h"
#import "PillManagerViewController.h"
#import "AddPillViewController.h"
#import "SettingViewController.h"
#import "SchemesViewController.h"


#import "AppDelegate.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStyleBordered target:self action:@selector(showMenu)];
}

#pragma mark -
#pragma mark Button actions

- (void)showMenu
{
    if (!_sideMenu) {
        RESideMenuItem *homeItem = [[RESideMenuItem alloc] initWithTitle:@"主页" action:^(RESideMenu *menu, RESideMenuItem *item) {
            PillMainViewController *viewController = [[PillMainViewController alloc] init];
            viewController.title = item.title;
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
            [menu setRootViewController:navigationController];
        }];
        RESideMenuItem *exploreItem = [[RESideMenuItem alloc] initWithTitle:@"新加" action:^(RESideMenu *menu, RESideMenuItem *item) {
            AddPillViewController *secondViewController = [[AddPillViewController alloc] init];
            secondViewController.title = item.title;
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
            [menu setRootViewController:navigationController];
        }];
        RESideMenuItem *activityItem = [[RESideMenuItem alloc] initWithTitle:@"管理" action:^(RESideMenu *menu, RESideMenuItem *item) {
            [menu hide];
            PillManagerViewController *secondViewController = [[PillManagerViewController  alloc] init];
            secondViewController.title = item.title;
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
            [menu setRootViewController:navigationController];
        }];
        RESideMenuItem *profileItem = [[RESideMenuItem alloc] initWithTitle:@"设置" action:^(RESideMenu *menu, RESideMenuItem *item) {
            [menu hide];
            SettingViewController *secondViewController = [[SettingViewController alloc] init];
            secondViewController.title = item.title;
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
            [menu setRootViewController:navigationController];
            NSLog(@"Item %@", item);
        }];
//        RESideMenuItem *aroundMeItem = [[RESideMenuItem alloc] initWithTitle:@"消耗" action:^(RESideMenu *menu, RESideMenuItem *item) {
//            [menu hide];
//            NSLog(@"Item %@", item);
//        }];
        
//        RESideMenuItem *helpPlus1 = [[RESideMenuItem alloc] initWithTitle:@"关于" action:^(RESideMenu *menu, RESideMenuItem *item) {
//            NSLog(@"Item %@", item);
//            [menu hide];
//        }];
//        
//        RESideMenuItem *helpPlus2 = [[RESideMenuItem alloc] initWithTitle:@"反馈" action:^(RESideMenu *menu, RESideMenuItem *item) {
//            NSLog(@"Item %@", item);
//            [menu hide];
//        }];
        
//        RESideMenuItem *helpCenterItem = [[RESideMenuItem alloc] initWithTitle:@"Help +" action:^(RESideMenu *menu, RESideMenuItem *item) {
//            NSLog(@"Item %@", item);
//        }];
//        helpCenterItem.subItems  = @[helpPlus1,helpPlus2];
//        
//        RESideMenuItem *itemWithSubItems = [[RESideMenuItem alloc] initWithTitle:@"Sub items +" action:^(RESideMenu *menu, RESideMenuItem *item) {
//            NSLog(@"Item %@", item);
//        }];
//        itemWithSubItems.subItems = @[aroundMeItem,helpCenterItem];
        
        RESideMenuItem *logOutItem = [[RESideMenuItem alloc] initWithTitle:@"Log out" action:^(RESideMenu *menu, RESideMenuItem *item) {
            [menu hide];
            SchemesViewController *secondViewController = [[SchemesViewController alloc] init];
            secondViewController.title = item.title;
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
            [menu setRootViewController:navigationController];
            NSLog(@"Item %@", item);
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:@"Are you sure you want to log out?" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Log Out", nil];
//            [alertView show];
        }];
        
        _sideMenu = [[RESideMenu alloc] initWithItems:@[homeItem, exploreItem, activityItem, profileItem,logOutItem]];
        _sideMenu.verticalOffset = IS_WIDESCREEN ? 110 : 76;
        _sideMenu.hideStatusBarArea = [AppDelegate OSVersion] < 7;
    }
    
    [_sideMenu show];
}

@end

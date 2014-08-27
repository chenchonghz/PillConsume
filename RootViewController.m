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
            viewController.sideMenu = menu;
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
            [menu setRootViewController:navigationController];
        }];
        RESideMenuItem *exploreItem = [[RESideMenuItem alloc] initWithTitle:@"新加" action:^(RESideMenu *menu, RESideMenuItem *item) {
            AddPillViewController *secondViewController = [[AddPillViewController alloc] init];
            secondViewController.title = item.title;
            secondViewController.sideMenu = menu;
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
            [menu setRootViewController:navigationController];
        }];
        RESideMenuItem *activityItem = [[RESideMenuItem alloc] initWithTitle:@"管理" action:^(RESideMenu *menu, RESideMenuItem *item) {
            [menu hide];
            PillManagerViewController *secondViewController = [[PillManagerViewController  alloc] init];
            secondViewController.title = item.title;
            secondViewController.sideMenu = menu;
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
            [menu setRootViewController:navigationController];
        }];
        RESideMenuItem *profileItem = [[RESideMenuItem alloc] initWithTitle:@"设置" action:^(RESideMenu *menu, RESideMenuItem *item) {
            [menu hide];
            SettingViewController *secondViewController = [[SettingViewController alloc] init];
            secondViewController.title = item.title;
            secondViewController.sideMenu = menu;
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
            [menu setRootViewController:navigationController];
            NSLog(@"Item %@", item);
        }];
        
        RESideMenuItem *logOutItem = [[RESideMenuItem alloc] initWithTitle:@"Log out" action:^(RESideMenu *menu, RESideMenuItem *item) {
            [menu hide];
            SchemesViewController *secondViewController = [[SchemesViewController alloc] init];
            secondViewController.title = item.title;
            secondViewController.sideMenu = menu;
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
            [menu setRootViewController:navigationController];
            NSLog(@"Item %@", item);
        }];
        
        self.sideMenu = [[RESideMenu alloc] initWithItems:@[homeItem, exploreItem, activityItem, profileItem,logOutItem]];
        self.sideMenu.verticalOffset = IS_WIDESCREEN ? 110 : 76;
        self.sideMenu.hideStatusBarArea = [AppDelegate OSVersion] < 7;
    }
    
    [self.sideMenu show];
}

@end

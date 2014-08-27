//
// RESideMenuItem.h
// RESideMenu
//
 

#import <Foundation/Foundation.h>

@class RESideMenu;

@interface RESideMenuItem : NSObject

@property (copy, readwrite, nonatomic) NSString *title;
@property (strong, readwrite, nonatomic) UIImage *image;
@property (strong, readwrite, nonatomic) UIImage *highlightedImage;
@property (assign, readwrite, nonatomic) NSInteger tag;
@property (copy, readwrite, nonatomic) void (^action)(RESideMenu *menu, RESideMenuItem *item);

@property (strong, readwrite, nonatomic) NSArray *subItems;

- (id)initWithTitle:(NSString *)title action:(void(^)(RESideMenu *menu, RESideMenuItem *item))action;
- (id)initWithTitle:(NSString *)title image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage action:(void(^)(RESideMenu *menu, RESideMenuItem *item))action;

@end

//
//  MMSoundMgr.h
//

#import <Foundation/Foundation.h>


@interface PPSoundMgr : NSObject {
	NSMutableDictionary* soundNameAndIds;	
    BOOL isPlaying_;
}
@property (nonatomic) BOOL isPlaying;

+ (PPSoundMgr*)shareInstance;

- (void)playSound:(NSString*)fileName;

- (void)playKeyPressSound;
- (void)playVibrate;

@end

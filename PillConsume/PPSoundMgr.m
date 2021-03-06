//
//

#import "PPSoundMgr.h"
#import <AudioToolbox/AudioToolbox.h>


static void completionCallback (SystemSoundID  mySSID, void* myself) {
	AudioServicesRemoveSystemSoundCompletion(mySSID);
	 
	[PPSoundMgr shareInstance].isPlaying = NO;
}

@implementation PPSoundMgr
@synthesize isPlaying = isPlaying_;

+ (PPSoundMgr*)shareInstance {
	static id _instance = nil;
    @synchronized(self) {
        if(_instance == nil) 
            _instance = [[[self class] alloc] init];
    }
    return _instance;
}

- (id)init {
	if (self = [super init]) {
		soundNameAndIds = [[NSMutableDictionary alloc] init];
	}
	return self;
}


- (void)playSound:(NSString*)fileName {
	assert([NSThread isMainThread]);
	
	NSNumber* soundIdObject = [soundNameAndIds objectForKey:fileName];
	if (!soundIdObject) {
//		NSString* path = @"sound";
		NSString* soundPath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
		
		NSFileManager* fileManager = [NSFileManager defaultManager];
		if (![fileManager fileExistsAtPath:soundPath]) {
			NSLog(@"sound file not exist: %@", soundPath);
			return;
		}
		
		CFURLRef soundURL = (__bridge CFURLRef)[NSURL fileURLWithPath:soundPath];
		SystemSoundID soundId;
		AudioServicesCreateSystemSoundID(soundURL, &soundId);
		
		soundIdObject = [NSNumber numberWithUnsignedInt:soundId];
		[soundNameAndIds setObject:soundIdObject forKey:fileName];
	}

    //防止大量播放
    if (isPlaying_) {
        return;
    }
    isPlaying_ = YES;
    
    AudioServicesAddSystemSoundCompletion([soundIdObject unsignedIntValue], NULL, NULL, completionCallback, NULL);
	AudioServicesPlaySystemSound([soundIdObject unsignedIntValue]);
}

- (void)playKeyPressSound {
    static CFTimeInterval lastPlayTime = 0;
    
    CFTimeInterval currentTime = CACurrentMediaTime();
    if (currentTime - lastPlayTime > 2) {
        lastPlayTime = currentTime;
        
        [self playSound:@"be.mp3"];
    }
}

- (void)playVibrate {
    static CFTimeInterval lastPlayTime = 0;
    
    CFTimeInterval currentTime = CACurrentMediaTime();
    if (currentTime - lastPlayTime > 2) {
        lastPlayTime = currentTime;
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
}

@end

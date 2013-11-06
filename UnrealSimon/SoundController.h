//
//  SoundController.h
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-08.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundController : NSObject <AVAudioPlayerDelegate> {
    AVAudioPlayer* audioPlayer;
    AVAudioSession *audioSession;
}

@property(nonatomic, assign)BOOL soundEffectsOn;
-(void)play:(NSString*)name ;
-(void)playMusic;
-(void)stopMusic;

@end

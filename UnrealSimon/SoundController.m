//
//  SoundController.m
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-08.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import "SoundController.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation SoundController

//call initialize method when Controller initiated
- (id)init {
    //    NSLog(@"initiating SoundController");
    if (self = [super init]) {
        
        //setup input boolean
        self.soundEffectsOn = TRUE;
        [self playMusic];
        
        return self;
    }
    return nil;
}

-(void)play:(NSString *)name{
    
    if(self.soundEffectsOn){
        CFBundleRef mainBundle = CFBundleGetMainBundle();
        CFURLRef soundfileURLRef;
        soundfileURLRef = CFBundleCopyResourceURL(mainBundle, (__bridge CFStringRef) name, CFSTR ("wav"), NULL);
        UInt32 SoundID;
        AudioServicesCreateSystemSoundID(soundfileURLRef, &SoundID);
        AudioServicesPlaySystemSound(SoundID);
    }
}

//play background ambient noise
- (void)playMusic{
    NSString* music = [[NSBundle mainBundle]pathForResource:@"ambientnoise" ofType:@"wav"];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:music] error:NULL];
    audioPlayer.delegate = self;
    audioPlayer.numberOfLoops = -1;
    [audioPlayer play];
}

-(void)stopMusic{
    [audioPlayer stop];
}

@end

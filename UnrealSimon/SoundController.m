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

+(void)play:(NSString *)name{
    
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef soundfileURLRef;
    soundfileURLRef = CFBundleCopyResourceURL(mainBundle, (__bridge CFStringRef) name, CFSTR ("wav"), NULL);
    UInt32 SoundID;
    AudioServicesCreateSystemSoundID(soundfileURLRef, &SoundID);
    AudioServicesPlaySystemSound(SoundID);
}

//play background ambient noise
//+ (void)music{
//    NSString* music = [[NSBundle mainBundle]pathForResource:@"ambientnoise" ofType:@"wav"];
//    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:music] error:NULL];
//    audioPlayer.delegate = self;
//    audioPlayer.numberOfLoops = -1;
//    [audioPlayer play];
//}

@end

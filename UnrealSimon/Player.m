//
//  Player.m
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-06.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import "Player.h"

@implementation Player

-(id)initWithName:(NSString *)name
       difficulty:(NSInteger)difficulty
     soundEffects:(BOOL)soundEffects
            music:(BOOL)music{
    self = [super init];
    if(self){
        _name = name;
        _difficulty = difficulty;
        _soundEffects = soundEffects;
        _music = music;
        return self;
    }
    return nil;
}

//NSUserDefaults

@end

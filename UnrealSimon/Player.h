//
//  Player.h
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-06.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, assign) NSInteger UID;
@property (nonatomic, assign) NSInteger difficulty;
@property (nonatomic, assign) BOOL soundEffects;
@property (nonatomic, assign) BOOL music;
@property (nonatomic, assign) NSInteger highScore;

-(id)initWithName:(NSString *)name
       difficulty:(NSInteger)difficulty
     soundEffects:(BOOL)soundEffects
            music:(BOOL)music
       highScore:(NSInteger)highScore;

@end

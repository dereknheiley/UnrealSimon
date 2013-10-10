//
//  PlayerController.h
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-06.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"
//#import "Player.h"
#import "SoundController.h"

@interface PlayerController : NSObject

//single player representation for easy listening and storage
@property (weak, nonatomic) Game* game;
@property (weak, nonatomic) SoundController* sound;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, assign) NSInteger difficulty;
@property (nonatomic, assign) NSInteger health;
@property (nonatomic, assign) NSInteger points;
@property (nonatomic, assign) NSInteger mode;
@property (nonatomic, assign) BOOL soundEffects;
@property (nonatomic, assign) BOOL music;

//FUTURE
//@property (nonatomic, copy) NSMutableArray* playerList;
//@property (nonatomic, assign) NSInteger currentPlayer;
//- (void)loadPlayers;
//- (void)savePlayers;
//- (Player *)objectInListAtIndex:(NSUInteger)index;
//- (void)addPlayer:(Player *)player;

@end

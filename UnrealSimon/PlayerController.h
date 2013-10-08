//
//  PlayerController.h
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-06.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface PlayerController : NSObject

@property (nonatomic, assign) NSInteger currentPlayer;
@property (nonatomic, copy) NSMutableArray* playerList;
- (Player *)objectInListAtIndex:(NSUInteger)index;
- (void)addPlayer:(Player *)player;
//- (void)loadPlayers;
//- (void)savePlayers;

//- (void)newScore:(NSUInteger)score; //implement as observer?



@end

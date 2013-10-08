//
//  PlayerController.m
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-06.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import "PlayerController.h"

@interface PlayerController()
- (void)initializeDefaultPlayerList;
@end

@implementation PlayerController

////call initialize method when Controller initiated
//- (id)init { //awakeFromNib
//    if (self = [super init]) {
//        [self initializeDefaultPlayerList];
//        return self;
//    }
//    return nil;
//}

//initialize list with default entry
- (void)initializeDefaultPlayerList {
    //initialize
    NSMutableArray *playerList = [[NSMutableArray alloc] init];
    self.playerList = playerList;
    
    //create initial dummy entry
    Player *player;
    player = [[Player alloc] initWithName:@"Megatron" difficulty:2 soundEffects:TRUE music:FALSE highScore:0];
    
    //populate list with dummy entry
    [self addPlayer:player];
}

//override default method to ensure remains mutable
- (void)setplayerList:(NSMutableArray *)newList {
    if (_playerList != newList) {
        _playerList = [newList mutableCopy];
    }
}

//get object at a specific index of the list
- (Player *)objectInListAtIndex:(NSUInteger)index {
    return [self.playerList objectAtIndex:index];
}

- (void)addPlayer:(Player *)player {
    [self.playerList addObject:player];
}

@end

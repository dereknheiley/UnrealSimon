//
//  PlayerController.m
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-06.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import "PlayerController.h"

@interface PlayerController()
//FUTURE
//- (void)initializeDefaultPlayerList;
@end

@implementation PlayerController

- (id)init {
    if (self = [super init]) {
        
        //load default player values
        self.name = @"Player";
        self.difficulty = 1;
        self.health = 100;
        self.points = 0;
        self.mode = 0;
        self.soundEffects = TRUE;
        self.music = TRUE;
        
        //TODO: load saved player
        
        
        return self;
    }
    return nil;
}

-(void)setGame:(Game *)newGame{
    //get save new ref to game
    _game = newGame;
    
    if(self.game !=nil){
        [self.game addObserver:self forKeyPath:@"goodSequences" options:NSKeyValueObservingOptionNew context:NULL];
        [self.game addObserver:self forKeyPath:@"badMove" options:NSKeyValueObservingOptionNew context:NULL];
    }
}

-(void)setSound:(SoundController *)newSound{
    _sound = newSound;

    if(self.sound !=nil){
        //set sound according to player prefs
        if(self.music){
            [self.sound playMusic];
        }
        else{
            [self.sound stopMusic];
        }
        //set sound according to player prefs
        if(self.soundEffects){
            [self.sound setSoundEffectsOn:TRUE];
        }
        else{
            [self.sound setSoundEffectsOn:FALSE];
        }
    }
}

- (void)observeValueForKeyPath:(NSString*)keyPath
                      ofObject:(id)object
                        change:(NSDictionary*)change
                       context:(void*)context {
    
    //debug observers
    NSLog(@"   PC observer %@ -> %@", keyPath, [change objectForKey:NSKeyValueChangeNewKey]);
    
    //game listeners
    if ([keyPath isEqualToString:@"goodSequences"]) {
        NSNumber* _goodSequences = [change objectForKey:NSKeyValueChangeNewKey];
        if( _goodSequences>0){
            self.points++;
        }
    }
    else if ([keyPath isEqualToString:@"badMove"]) {
        if([[change objectForKey:NSKeyValueChangeNewKey] boolValue] == TRUE){
            NSInteger _step = 25;
            if(self.health <= _step){
                [self.game abortGame];
            }
            else{
                self.health = self.health - _step;
            }
        }
    }
}

//FUTURE

////call initialize method when Controller initiated
//- (id)init { //awakeFromNib
//    if (self = [super init]) {
//        [self initializeDefaultPlayerList];
//        return self;
//    }
//    return nil;
//}

//initialize list with default entry
//- (void)initializeDefaultPlayerList {
//    //initialize
//    NSMutableArray *playerList = [[NSMutableArray alloc] init];
//    self.playerList = playerList;
//    
//    //create initial dummy entry
//    Player *player;
//    player = [[Player alloc] initWithName:@"Megatron" difficulty:2 soundEffects:TRUE music:FALSE highScore:0];
//    
//    //populate list with dummy entry
//    [self addPlayer:player];
//}

//override default method to ensure remains mutable
//- (void)setplayerList:(NSMutableArray *)newList {
//    if (_playerList != newList) {
//        _playerList = [newList mutableCopy];
//    }
//}

//get object at a specific index of the list
//- (Player *)objectInListAtIndex:(NSUInteger)index {
//    return [self.playerList objectAtIndex:index];
//}
//
//- (void)addPlayer:(Player *)player {
//    [self.playerList addObject:player];
//}

@end

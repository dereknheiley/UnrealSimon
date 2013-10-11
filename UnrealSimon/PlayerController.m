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
        
        //load saved player
        self.userDefaults = [NSUserDefaults standardUserDefaults];
        [[NSUserDefaults standardUserDefaults] registerDefaults:@{
         @"name": @"PlayerNameHere",
         @"difficulty": @1,
         @"health":@100,
         @"points":@0,
         @"mode":@1,
         @"soundEffects":@0,
         @"music":@0
         }];
        
        // Read save settings
        self.name = [self.userDefaults stringForKey:@"name"];
        self.difficulty = [self.userDefaults integerForKey:@"difficulty"];
        self.health = [self.userDefaults integerForKey:@"health"];
        self.points = [self.userDefaults integerForKey:@"points"];
        self.mode = [self.userDefaults integerForKey:@"mode"];
        self.soundEffects = [self.userDefaults boolForKey:@"soundEffects"];
        self.music = [self.userDefaults boolForKey:@"music"];
        
        return self;
    }
    return nil;
}

-(void)setGame:(Game *)newGame{
    _game = newGame;
    
    if(self.game !=nil){
        [self.game addObserver:self forKeyPath:@"goodSequences" options:NSKeyValueObservingOptionNew context:NULL];
        [self.game addObserver:self forKeyPath:@"level" options:NSKeyValueObservingOptionNew context:NULL];
        [self.game addObserver:self forKeyPath:@"badMove" options:NSKeyValueObservingOptionNew context:NULL];
    }
}

-(void)setDifficulty:(NSInteger)newDifficulty{
    _difficulty = newDifficulty;
    [self.userDefaults setInteger:self.difficulty forKey:@"difficulty"];
    if(self.difficulty){
        //update in game logic
        [self.game setDifficulty:self.difficulty];
    }
}

-(void)setMode:(NSInteger)newMode{
    _mode = newMode;
    [self.userDefaults setInteger:self.mode forKey:@"mode"];
    if(self.mode){
        //update in game logic
        [self.game setGameMode:self.mode];
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

-(void)setMusic:(BOOL)newMusic{
    _music = newMusic;
    [self.userDefaults setBool:self.music forKey:@"music"];
    //set sound according to player prefs
    if(self.music){
        [self.sound playMusic];
    }
    else{
        [self.sound stopMusic];
    }
}

-(void)setSoundEffects:(BOOL)newSoundEffects{
    _soundEffects = newSoundEffects;
    [self.userDefaults setBool:self.soundEffects forKey:@"soundEffects"];
    
    //set sound according to player prefs
    if(self.soundEffects){
        [self.sound setSoundEffectsOn:TRUE];
    }
    else{
        [self.sound setSoundEffectsOn:FALSE];
    }
}

- (void)observeValueForKeyPath:(NSString*)keyPath
                      ofObject:(id)object
                        change:(NSDictionary*)change
                       context:(void*)context {
    
    //debug observers
//    NSLog(@"   PC observer %@ -> %@", keyPath, [change objectForKey:NSKeyValueChangeNewKey]);
    
    //game listeners
    if ([keyPath isEqualToString:@"goodSequences"]) {
        NSInteger _goodSequences = [[change objectForKey:NSKeyValueChangeNewKey] intValue];
        if( _goodSequences > 0){
            self.points++;
            [self.userDefaults setInteger:self.points forKey:@"points"];
        }
    }
    else if ([keyPath isEqualToString:@"badMove"]) {
        if([[change objectForKey:NSKeyValueChangeNewKey] boolValue] == TRUE){
            NSInteger _step = 25;
            if(self.health <= _step){
                [self.game abortGame];
                self.Health = 100;
            }
            else{
                self.health = self.health - _step;
                [self.userDefaults setInteger:self.health forKey:@"health"];
            }
        }
    }
    else if ([keyPath isEqualToString:@"level"]) {
        if([[change objectForKey:NSKeyValueChangeNewKey] intValue] == 1){
            //game was restarted
            //reset points
            self.points = 0;
            self.health = 100;
            [self.userDefaults setInteger:self.points forKey:@"points"];
            [self.userDefaults setInteger:self.health forKey:@"health"];
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

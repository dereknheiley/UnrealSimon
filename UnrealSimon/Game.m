//
//  GameController.m
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-06.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import "Game.h"

@interface Game()
- (void)initializeSequence;
- (void)playNextMove;
- (void)donePlayingSequence;
- (void)increaseSequence;
- (void)resetSequence;
@end

@implementation Game

//call initialize method when Controller initiated
- (id)init {
//    NSLog(@"initiating Game");
    if (self = [super init]) {
        
        //setup input boolean to be observed
        self.acceptingInput = FALSE;
        
        //setup sequence
        [self initializeSequence];
        self.goodSequences = 0;
        self.currentMove = 0;
        self.currentMoveIndex = 0;
        
        //setup other booleans
        self.correctSequenceSeen = FALSE;
        self.isIdle = TRUE;
        
        return self;
    }
    return nil;
}

//initialize list with default entry
- (void)initializeSequence {
    //initialize
    NSMutableArray *sequence = [[NSMutableArray alloc] init];
    self.sequence = sequence;
    
    //populate list with first entry
    [self increaseSequence];
}

- (void)increaseSequence{
    //create new move between inclusive range
    NSInteger newInt= [self random:1:4];
    NSNumber *newMove = [NSNumber numberWithInt:newInt];
    [self.sequence addObject:newMove];
}

- (void)resetSequence{
    [self initializeSequence];
}

//override default method to ensure remains mutable
- (void)setsequence:(NSMutableArray *)newSequence {
    if (_sequence != newSequence) {
        _sequence = [newSequence mutableCopy];
    }
}

- (void)playSequence{
    
//    NSLog(@"game playSequence startcall");
    
    //start from begining of sequence
    self.currentMove = 0;
    self.currentMoveIndex = 0;
    self.acceptingInput = FALSE;
    self.correctSequenceSeen = FALSE;
    self.isIdle = FALSE;
    
    //get players current level of difficulty
    int _difficulty = 3;
    
    //calculate time based on difficulty
    float _interval = 1.0/_difficulty;
    
    //wait predefined interval
    [self.playMoveTimer invalidate];
    self.playMoveTimer = [NSTimer scheduledTimerWithTimeInterval:_interval
                                                         target:self
                                                       selector:@selector(playNextMove)
                                                       userInfo:nil
                                                        repeats:TRUE];

//    NSLog(@"game playSequence endcall");
}

-(void)playNextMove{
    if(self.currentMoveIndex < [self.sequence count]){
        self.currentMove = [[self.sequence objectAtIndex:self.currentMoveIndex] integerValue ];
        self.currentMoveIndex++ ;
        //        NSLog(@"game currentMoveIndex -> %lu", (unsigned long)self.currentMoveIndex);
    }
    else{
        [self donePlayingSequence];
    }
}

-(void)donePlayingSequence{
    //done with timer
    [self.playMoveTimer invalidate];
    
    //reset move and index
    self.currentMove = 0;
    self.currentMoveIndex = 0;
    
    //start accepting player input
    self.acceptingInput = TRUE;
    self.isIdle = TRUE;
//    NSLog(@"game donePlayingSequence");
}

- (void)abortGame{
    [self donePlayingSequence];
    [self resetSequence];
}


- (BOOL)checkIsMoveGood:(NSUInteger)move{
    
    //make sure there's more moves to check against
    if( self.acceptingInput ){
        
        NSLog(@"game checkIsMoveGood -> %lu", (unsigned long)move);
        
        //check move
        if(move == [[self.sequence objectAtIndex:self.currentMoveIndex] intValue]){
        
            //increment move counter
            self.currentMoveIndex++;
            
            //see if that was that last move
            if( self.currentMoveIndex >= [self.sequence count] ){
                //good job!
                self.correctSequenceSeen = TRUE;
                self.goodSequences++;
                //TODO updatepoints?
                
                //reset for next sequence play
                self.currentMoveIndex = 0;
                self.acceptingInput = FALSE;
                
                //add new move for next sequence play
                [self increaseSequence];
                
                //call next sequence to play after short break
                self.playMoveTimer = [NSTimer scheduledTimerWithTimeInterval:1.5
                                                                      target:self
                                                                    selector:@selector(playSequence)
                                                                    userInfo:nil
                                                                     repeats:FALSE];
            }
            return TRUE;
        }
        else{
            self.currentMoveIndex = 0;
            self.acceptingInput = FALSE;
            [self resetSequence];
            //TODO decrease health?
            
            return FALSE;
        }
    }
    //else just ignore the input
    return FALSE;
}

- (int) random:(int)min :(int)max {
    return ( (arc4random() % (max-min+1)) + min );
}

@end

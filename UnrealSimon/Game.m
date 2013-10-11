//
//  GameController.m
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-06.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import "Game.h"
#import "math.h"

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
//    //NSLog(@"initiating Game");
    if (self = [super init]) {
        
        //setup input boolean to be observed
        self.acceptingInput = FALSE;
        
        //setup sequence
        [self initializeSequence];
        self.goodSequences = 0;
        self.currentMove = 0;
        self.currentMoveIndex = 0;
        self.level = 1;
        self.tries = 0;
        self.difficulty = 1;
        self.gameMode = 0;
        
        //setup other booleans
//        self.correctSequenceSeen = FALSE;
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
    self.acceptingInput = FALSE;
    [self initializeSequence];
    
    //generate a new equal length sequence for stepped game mode
    if(self.gameMode == 0){
        //start at 1 since initialized sequence has one move
        for(int i=1; i<self.level; i++){
            [self increaseSequence];
        }
    }
}

//override default method to ensure remains mutable
- (void)setsequence:(NSMutableArray *)newSequence {
    if (_sequence != newSequence) {
        _sequence = [newSequence mutableCopy];
    }
}

- (void)playSequence{
    
    //NSLog(@"game playSequence startcall");
    
    //start from begining of sequence
    self.currentMove = 0;
    self.currentMoveIndex = 0;
    self.acceptingInput = FALSE;
    self.isIdle = FALSE;
    
    //calculate time based on difficulty
    float _interval = 1.0/self.difficulty;
    
    //wait predefined interval
    [self.playMoveTimer invalidate];
    self.playMoveTimer = [NSTimer scheduledTimerWithTimeInterval:_interval
                                                         target:self
                                                       selector:@selector(playNextMove)
                                                       userInfo:nil
                                                        repeats:TRUE];

    //NSLog(@"game playSequence endcall");
}

-(void)playNextMove{
    if(self.currentMoveIndex < [self.sequence count]){
        self.currentMove = [[self.sequence objectAtIndex:self.currentMoveIndex] integerValue ];
        self.currentMoveIndex++ ;
        //NSLog(@"game currentMoveIndex -> %lu", (unsigned long)self.currentMoveIndex);
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
    //NSLog(@"game donePlayingSequence");
}

- (void)abortGame{
    //NSLog(@"game abortGame start");
    [self donePlayingSequence];
    self.level = 1;
    self.tries = 0;
    self.goodSequences = 0;
    [self resetSequence];
    //NSLog(@"game abortGame done");
}


- (void)checkIsMoveGood:(NSUInteger)move{
    
    //make sure there's more moves to check against
    if( self.acceptingInput ){
        
//        //NSLog(@"game checkIsMoveGood -> %lu", (unsigned long)move);
        
        //check move
        if(move == [[self.sequence objectAtIndex:self.currentMoveIndex] intValue]){
        
            //increment move counter
            self.currentMoveIndex++;
            
            //see if that was that last move
            if( self.currentMoveIndex >= [self.sequence count] ){
                //good job!
                self.goodSequences++;
                
                //reset for next sequence play
                self.currentMoveIndex = 0;
                self.acceptingInput = FALSE;
                
                if(self.gameMode == 0){//generate new sequence
                    
                    //only increment if user has done required number of sequences at current length
                    if(self.tries == (floor(4/self.difficulty)+1) ){
                        self.tries = 0;
                        self.level++;
                    }
                    else{
                        self.tries++;
                    }
                    [self resetSequence];
                }
                
                else if(self.gameMode == 1){//keep sequence and add new move for next sequence play
                    [self increaseSequence];
                    self.level++;
                }
                
                //call next sequence to play after short break
                [self playNextSequence];
            }
        }
        else{
            [self resetSequence];
            self.currentMoveIndex = 0;
            self.acceptingInput = FALSE;
            self.goodSequences = 0;
            [self playNextSequence];
            self.badMove = TRUE;
        }
    }
}

-(void)playNextSequence{
    //call next sequence to play after short break
    self.playMoveTimer = [NSTimer scheduledTimerWithTimeInterval:1.5
                                                          target:self
                                                        selector:@selector(playSequence)
                                                        userInfo:nil
                                                         repeats:FALSE];
}

- (int) random:(int)min :(int)max {
    return ( (arc4random() % (max-min+1)) + min );
}

@end

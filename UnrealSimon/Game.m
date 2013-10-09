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

- (void)resetSequence{
    [self initializeSequence];
}

//override default method to ensure remains mutable
- (void)setsequence:(NSMutableArray *)newSequence {
    if (_sequence != newSequence) {
        _sequence = [newSequence mutableCopy];
    }
}
     
- (void)increaseSequence{
    //create new move between inclusive range
//    NSInteger = random(1,4);
    NSNumber *newMove = [NSNumber numberWithInt:2];
    [self.sequence addObject:newMove];
}

- (void)playSequence{
    
    //start from begining of sequence
    self.currentMove = 0;
    self.currentMoveIndex = 0;
    self.acceptingInput = FALSE;
    self.correctSequenceSeen = FALSE;
    self.isIdle = FALSE;
    
    //get players current level of difficulty
    
    
    //wait predefined interval
    self.playMoveTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                         target:self
                                                       selector:@selector(playNextMove)
                                                       userInfo:nil
                                                        repeats:TRUE];

}

-(void)donePlayingSequence{
    //done with timer
    self.playMoveTimer = NULL;
    
    //reset move and index
    self.currentMove = 0;
    self.currentMoveIndex = 0;
    
    //start accepting player input
    self.acceptingInput = TRUE;
    self.isIdle = TRUE;
}

-(void)playNextMove{
    if(self.currentMoveIndex < [self.sequence count]){
        self.currentMove = [[self.sequence objectAtIndex:self.currentMoveIndex] integerValue ];
        self.currentMoveIndex++ ;
    }
    else{
        [self donePlayingSequence];
    }
}

- (void)abortGame{
    [self donePlayingSequence];
    [self resetSequence];
}


- (BOOL)checkIsMoveGood:(NSUInteger)move{
    
    //make sure there's more moves to check against
    if( self.acceptingInput ){
        
        //check move
        NSNumber* _newMove =[NSNumber numberWithInt:move];
        if( _newMove == [self.sequence objectAtIndex:self.currentMoveIndex] ){
            
            //increment move counter
            self.currentMoveIndex++;
            
            //see if that was that last move
            if( self.currentMoveIndex != [self.sequence count] ){
                self.acceptingInput = FALSE;
                self.correctSequenceSeen = TRUE;
                self.goodSequences++;
                
                //increase sequence according to difficulty
                if( self.goodSequences % 4 == 0 ){
                    [self increaseSequence];
                    //correctSequenceSeen = FALSE;
                }
            }
            return TRUE;
        }
        else{
            self.currentMoveIndex = 0;
            self.acceptingInput = FALSE;
            [self resetSequence];
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

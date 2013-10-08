//
//  GameController.m
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-06.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import "Game.h"
#define random(min,max) ((arc4random() % (max-min+1)) + min)

@interface Game()
+ (void)initializeSequence;
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
    NSNumber *newMove = [NSNumber numberWithInt:2]; //random(1,4)
    [self.sequence addObject:newMove];
}

- (void)playSequence{
    
    //start from begining of sequence
    self.currentMove = 0;
    self.acceptingInput = FALSE;
    self.correctSequenceSeen = FALSE;
    
    //get players current level of difficulty
    
    
    //iterate through sequence
    for (self.currentMoveIndex = 0; self.currentMoveIndex < [self.sequence count]; self.currentMoveIndex++ ) {

        //wait predefined interval
        
        
        //call playMove in gameViewController
        self.currentMove = [[self.sequence objectAtIndex:self.currentMoveIndex] integerValue ];
    
    }
    //reset move and index
    self.currentMove = 0;
    self.currentMoveIndex = 0;
    
    //start accepting player input
    self.acceptingInput = TRUE;
    
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

@end

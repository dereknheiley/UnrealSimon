//
//  GameController.m
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-06.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import "Game.h"
#import "GameViewController.h"

@interface Game()
- (void)initilizeSequence;
@end

@implementation Game

//call initialize method when Controller initiated
- (id)init {
    if (self = [super init]) {
        
        //setup properties
        acceptingInput = FALSE;
        correctSequenceSeen = FALSE;
        goodSequenes=0;
        
        [self initializeSequence];
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
    NSNumber *newMove = [NSNumber numberWithInt:random(1,4)];
    [self.sequence addObject:newMove];
}

- (void)playSequence{
    
    //start from begining of sequence
    currentMove = 0;
    acceptingInput = FALSE;
    correctSequenceSeen = FALSE;
    
    //get players current level of difficulty
    
    
    //iterate through sequence
    for (currentMoveIndex = 0; currentMoveIndex < [self.sequence count]; currentMoveIndex++ ) {

        //wait predefined interval
        
        
        //call playMove in gameViewController
        currentMove = [self.sequence objectAtIndex:currentMoveIndex];
    
    }
    //reset move and index
    currentMove = 0;
    currentMoveIndex = 0;
    
    //start accepting player input
    acceptingInput = TRUE;
    
}

- (void)checkIsMoveGood:(NSUInteger)move{
    
    //make sure there's more moves to check against
    if( acceptingInput ){
        
        //check move
        if( move == [self.sequence objectAtIndex:currentMoveIndex] ){
            
            //increment move counter
            currentMoveIndex++;
            
            //see if that was that last move
            if( currentMoveIndex != [self.sequence count] ){
                acceptingInput = FALSE;
                correctSequenceSeen = TRUE;
                goodSequences++;
                
                //increase sequence according to difficulty
                if( goodSequences % 4 == 0 ){
                    [self increaseSequence];
                    //correctSequenceSeen = FALSE;
                }
            }
            return TRUE;
        }
        else{
            currentMoveIndex = 0;
            acceptingInput = FALSE;
            [self resetSequence];
            return FALSE;
        }
    }
    //else just ignore the input
}

@end

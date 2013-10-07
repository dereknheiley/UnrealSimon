//
//  GameController.m
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-06.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import "GameController.h"

@interface GameController()
- (void)initilizeSequence;
@end

@implementation GameController

//call initialize method when Controller initiated
- (id)init {
    if (self = [super init]) {
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

//override default method to ensure remains mutable
- (void)setsequence:(NSMutableArray *)newSequence {
    if (_sequence != newSequence) {
        _sequence = [newSequence mutableCopy];
    }
}

//returns length of sequence
- (NSUInteger)countOfList {
    return [self.sequence count];
}
     
- (void)increaseSequence{
    //create new move
    NSNumber *newMove = [NSNumber numberWithInt:random(1,4)];
    [self.sequence addObject:newMove];
}

@end

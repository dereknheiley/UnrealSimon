//
//  GameController.h
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-06.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import <Foundation/Foundation.h>

#define random(min,max) ((arc4random() % (max-min+1)) + min)

@interface Game : NSMutableArray

@property (nonatomic, copy) NSMutableArray* sequence;
@property (nonatomic, assign) NSUInteger currentMove;
@property (nonatomic, assign) NSUInteger currentMoveIndex;
@property (nonatomic, assign) NSUInteger goodSequences;
@property (nonatomic, assign) BOOL correctSequenceSeen;
@property (nonatomic, assign) BOOL acceptingInput;
- (BOOL)checkMove:(NSUInteger)move;
- (void)increaseSequence;
- (void)playSequence;
- (void)resetSequence;

@end

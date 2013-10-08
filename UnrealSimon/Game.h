//
//  GameController.h
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-06.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject

@property (nonatomic, retain) NSMutableArray* sequence;
@property (nonatomic, assign) NSUInteger currentMove;
@property (nonatomic, assign) NSUInteger currentMoveIndex;
@property (nonatomic, assign) NSUInteger goodSequences;
@property (nonatomic, assign) BOOL correctSequenceSeen;
@property (nonatomic, assign) BOOL acceptingInput;
@property (nonatomic, assign) BOOL isIdle;
- (BOOL)checkIsMoveGood:(NSUInteger)move;
- (void)increaseSequence;
- (void)playSequence;
- (void)resetSequence;

@end

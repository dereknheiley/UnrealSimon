//
//  GameController.h
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-06.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameViewController.h"

#define random(min,max) ((arc4random() % (max-min+1)) + min)

@interface GameController : NSMutableArray

@property (nonatomic, copy) NSMutableArray* sequence;
@property (nonatomic, assign) NSUInteger currentMove;
- (void)checkMove:(NSUInteger)move;
- (NSUInteger)countOfSequence;
- (void)increaseSequence;
- (void)playSequence;
- (void)resetSequence;

@end

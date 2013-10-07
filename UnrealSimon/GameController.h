//
//  GameController.h
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-06.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import <Foundation/Foundation.h>

#define random(min,max) ((arc4random() % (max-min+1)) + min)

@interface GameController : NSMutableArray

@property (nonatomic, copy) NSMutableArray* sequence;
- (BOOL)checkMove:(NSUInteger)move;
- (NSUInteger)countOfSequence;
- (void)increaseSequence;

@end

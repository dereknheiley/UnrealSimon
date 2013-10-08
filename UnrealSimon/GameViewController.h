//
//  FirstViewController.h
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-06.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@interface GameViewController : UIViewController
@property (strong, nonatomic) Game *game;
@property (weak, nonatomic) IBOutlet UIButton *playPause;
@property (weak, nonatomic) IBOutlet UILabel *health;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UIButton *greenButton;
@property (weak, nonatomic) IBOutlet UIButton *redButton;
@property (weak, nonatomic) IBOutlet UIButton *blueButton;
@property (weak, nonatomic) IBOutlet UIButton *yellowButton;

- (IBAction)start; //called by playPauseButton
- (IBAction)stop; //called by playPauseButton
- (IBAction)move:(id)sender; //calls [game checkIsGoodMove]

- (void)playGameSequence:(NSUInteger)move; //observe [game currentMove]
- (void)badMove; //activated by return from [game checkIsGoodMove]
- (void)successfullSequence; //observe [game correctSequenceSeen]

@end

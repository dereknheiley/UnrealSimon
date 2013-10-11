//
//  FirstViewController.h
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-06.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "SoundController.h"
#import "PlayerController.h"

@interface GameViewController : UIViewController

@property (weak, nonatomic) Game* game;
@property (weak, nonatomic) SoundController* sound;
@property (weak, nonatomic) PlayerController* player;

@property (weak, nonatomic) IBOutlet UIImageView *redBackground;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;
@property (weak, nonatomic) IBOutlet UILabel *health;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UIButton *greenButton;
@property (weak, nonatomic) IBOutlet UIButton *redButton;
@property (weak, nonatomic) IBOutlet UIButton *blueButton;
@property (weak, nonatomic) IBOutlet UIButton *yellowButton;
@property (nonatomic, assign) BOOL gameInputsEnabled;
@property (strong, nonatomic) NSMutableArray* encouragements;
@property (weak, nonatomic) IBOutlet UIImageView *whiteHealth;
@property (weak, nonatomic) IBOutlet UIImageView *blueScore;

- (IBAction)playPauseAction:(id)sender; //called by playPauseButton
- (IBAction)move:(id)sender; //calls [game checkIsGoodMove]

@end

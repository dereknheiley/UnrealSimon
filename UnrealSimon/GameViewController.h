//
//  FirstViewController.h
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-06.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameController.h"

@interface GameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *playPause;
@property (weak, nonatomic) IBOutlet UILabel *health;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UIButton *greenButton;
@property (weak, nonatomic) IBOutlet UIButton *redButton;
@property (weak, nonatomic) IBOutlet UIButton *blueButton;
@property (weak, nonatomic) IBOutlet UIButton *yellowButton;

- (IBAction)start;
- (IBAction)stop;
- (IBAction)move:(id)sender;

- (void)playMove:(NSUInteger)move;
- (void)badMove;
- (void)goodMove;

@end

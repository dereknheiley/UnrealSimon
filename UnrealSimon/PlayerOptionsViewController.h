//
//  SecondViewController.h
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-06.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerController.h"

@interface PlayerOptionsViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) PlayerController* player;
@property (weak, nonatomic) IBOutlet UITextField *nameInput;
@property (weak, nonatomic) IBOutlet UISegmentedControl *difficultyButton;
@property (weak, nonatomic) IBOutlet UISwitch *soundEffectsSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *musicSwitch;
@property (copy, nonatomic) NSString* inputtext;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeButton;
- (IBAction)nameChanged:(id)sender;
- (IBAction)difficultyChanged:(id)sender;
- (IBAction)modeChanged:(id)sender;
- (IBAction)soundEffectsChanged:(id)sender;
- (IBAction)musicChanged:(id)sender;


@end

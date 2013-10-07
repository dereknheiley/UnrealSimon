//
//  SecondViewController.h
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-06.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerOptionsViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameInput;
@property (weak, nonatomic) IBOutlet UISegmentedControl *difficultyInput;
@property (weak, nonatomic) IBOutlet UISwitch *soundEffectsInput;
@property (weak, nonatomic) IBOutlet UISwitch *musicInput;
@property (copy, nonatomic) NSString* inputtext;

@end

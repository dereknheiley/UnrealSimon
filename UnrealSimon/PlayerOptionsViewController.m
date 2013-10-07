//
//  SecondViewController.m
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-06.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import "PlayerOptionsViewController.h"

@interface PlayerOptionsViewController ()

@end

@implementation PlayerOptionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //resign on either button "Done keyboard button" being pressed
    if (textField == self.nameInput) {
        [textField resignFirstResponder];
    }
    return YES;
}

@end

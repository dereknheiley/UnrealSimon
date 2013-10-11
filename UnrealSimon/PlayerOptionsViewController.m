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
    
    //playerController observer if difficulty increases through gameplay
    [self.player addObserver:self forKeyPath:@"difficulty" options:NSKeyValueObservingOptionNew context:NULL];
    
    //get initial values from playerController
    self.nameInput.Text = [self.player name];
    self.difficultyButton.selectedSegmentIndex = [self.player difficulty]-1;
    self.gameModeButton.selectedSegmentIndex = [self.player mode];
    self.soundEffectsSwitch.on = [self.player soundEffects];
    self.musicSwitch.on = [self.player music];
}

- (void)observeValueForKeyPath:(NSString*)keyPath
                      ofObject:(id)object
                        change:(NSDictionary*)change
                       context:(void*)context {
    
//    //NSLog(@"   POVC observer %@ -> %@", keyPath, [change objectForKey:NSKeyValueChangeNewKey]);
    
    //playerController listeners
    if ([keyPath isEqualToString:@"difficulty"]) {
        self.difficultyButton.selectedSegmentIndex = [[change objectForKey:NSKeyValueChangeNewKey] intValue]-1;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    //    //NSLog(@"viewWillAppear ");
    [self.sound play:@"menu-2"];
}

- (void)viewWillDisappear:(BOOL)animated{
    //    //NSLog(@"viewWillDisappear ");
    [self.sound play:@"menu-3"];
    
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

- (IBAction)nameChanged:(id)sender {
    [self.player setName:self.nameInput.text];
}

- (IBAction)difficultyChanged:(id)sender {
    [self.player setDifficulty:[sender selectedSegmentIndex]+1 ];
}

- (IBAction)modeChanged:(id)sender {
    [self.player setMode:[sender selectedSegmentIndex] ];
}

- (IBAction)soundEffectsChanged:(id)sender {
    [self.player setSoundEffects:[sender isOn] ];
}

- (IBAction)musicChanged:(id)sender {
    [self.player setMusic: [sender isOn] ];
}

- (IBAction)optionChangeSound:(id)sender {
    [self.sound play:@"menu"];
}
@end

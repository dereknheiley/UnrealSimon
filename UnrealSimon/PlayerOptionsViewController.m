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
    
    //update player properties from playerController
    [self.player addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:NULL];
    [self.player addObserver:self forKeyPath:@"difficulty" options:NSKeyValueObservingOptionNew context:NULL];
    [self.player addObserver:self forKeyPath:@"mode" options:NSKeyValueObservingOptionNew context:NULL];
    [self.player addObserver:self forKeyPath:@"soundEffects" options:NSKeyValueObservingOptionNew context:NULL];
    [self.player addObserver:self forKeyPath:@"music" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)observeValueForKeyPath:(NSString*)keyPath
                      ofObject:(id)object
                        change:(NSDictionary*)change
                       context:(void*)context {
    
    //debug observers
    NSLog(@"   POVC observer %@ -> %@", keyPath, [change objectForKey:NSKeyValueChangeNewKey]);
    
    //playerController listeners
    if ([keyPath isEqualToString:@"name"]) {
        self.nameInput.text = [[change objectForKey:NSKeyValueChangeNewKey] stringValue];
    }
    else if ([keyPath isEqualToString:@"difficulty"]) {
        self.difficultyButton.selectedSegmentIndex = [[change objectForKey:NSKeyValueChangeNewKey] intValue]-1;
    }
    else if ([keyPath isEqualToString:@"mode"]) {
        self.gameModeButton.selectedSegmentIndex = [[change objectForKey:NSKeyValueChangeNewKey] intValue];
    }
    else if ([keyPath isEqualToString:@"soundEffects"]) { //bool
        self.soundEffectsSwitch.on = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
    }
    else if ([keyPath isEqualToString:@"music"]) { //bool
        self.musicSwitch.on = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
    }
}

//actions for name, difficulty, mode, soundEffects, music


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
    NSLog(@"POVC got sender value -> %@",[sender currentTitle]);
    [self.player setName:[sender currentTitle]];
}

- (IBAction)difficultyChanged:(id)sender {
    NSLog(@"POVC got sender value -> %d",[sender selectedSegmentIndex]);
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
@end

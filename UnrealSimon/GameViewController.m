//
//  FirstViewController.m
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-06.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import "GameViewController.h"
#import "SoundController.h"

@interface GameViewController ()
- (void)disableGameInputs;
- (void)enableGameInputs;
@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //play start sound?
    
    //disable all buttons until ready for player input
//    [self disableGameInputs];
    
    //initiate an instance of the game
    self.game = [[Game alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)start:(id)sender{
    
    // hide start/stop button while running
    //self.playPause.setTitle:@"Stop";
    [sender setTitle:@"Stop" forState:UIControlStateNormal];
    self.playPause.enabled = NO;
    
    [SoundController play:@"start"];
    
    //pass off to gameController
    [self.game playSequence];
    
}

- (IBAction)move:(id)move{
    int moveCode = 0;
    if(move == self.greenButton){
        moveCode=1;
        [SoundController play:@"gun-green"];
    }
    else if ( move == self.redButton ){
        moveCode=2;
        [SoundController play:@"gun-red"];
    }
    else if (move == self.blueButton){
        moveCode=3;
        [SoundController play:@"gun-blue"];
    }
    else if (move == self.yellowButton){
        moveCode=4;
        [SoundController play:@"gun-yellow"];
    }
    else{
        //thow error
    }
    
    //check move
    [self.game checkIsMoveGood:moveCode];
}

- (void)successfullSequence{
    //highlight points added
    
    //play sucess audio infrequently????
}

- (void)badMove{
    //change game view background colour
}

- (IBAction)stop{
    // hide start/stop button while running
    self.playPause.enabled = YES;
    
}

- (void)disableGameInputs{
    self.greenButton.enabled = NO;
    self.redButton.enabled = NO;
    self.blueButton.enabled = NO;
    self.yellowButton.enabled = NO;
}
- (void)enableGameInputs{
    self.greenButton.enabled = YES;
    self.redButton.enabled = YES;
    self.blueButton.enabled = YES;
    self.yellowButton.enabled = YES;
}

//observe [game currentMove]
- (void)playGameSequence:(NSUInteger)move{
    if(move==1){
        //press green
    }
    else if (move==2){
        //press red
    }
    else if (move==3){
        //press blue
    }
    else if (move==4){
        //press yellow
    }
    else{
        //thow error
    }
}

@end

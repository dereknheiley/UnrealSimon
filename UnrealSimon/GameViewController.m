//
//  FirstViewController.m
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-06.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import "GameViewController.h"
#import "Game.h"

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
    [self disableGameInputs];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)start{
    
    // hide start/stop button while running
    self.playPause.enabled = NO;
    
    //pass off to gameController
    [Game playSequence];
    
}

- (IBAction)move:(id)move{
    int moveCode = 0;
    if(move == self.greenButton){
        moveCode=1;
    }
    else if ( move == self.redButton ){
        moveCode=2;
    }
    else if (move == self.blueButton){
        moveCode=3;
    }
    else if (move == self.yellowButton){
        moveCode=4;
    }
    else{
        //thow error
    }
    
    //check move
    [Game checkMove:moveCode];
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

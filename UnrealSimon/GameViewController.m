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
@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.encouragements = [NSMutableArray arrayWithObjects:
                      @"rampage",
                      @"dominating",
                      @"unstoppable",
                      @"godlike",
                      nil];
}

//plays better with UINavigationController or UITabBarController
- (void)viewWillAppear:(BOOL)animated{
    //disable all buttons until ready for player input
    //    [self disableGameInputs];
    
    //initiate an instance of the game
    self.game = [[Game alloc] init];
    
    //add observers to game
    [self.game addObserver:self forKeyPath:@"currentMove" options:NSKeyValueObservingOptionNew context:NULL];
    [self.game addObserver:self forKeyPath:@"goodSequences" options:NSKeyValueObservingOptionNew context:NULL];
    [self.game addObserver:self forKeyPath:@"correctSequenceSeen" options:NSKeyValueObservingOptionNew context:NULL];
    [self.game addObserver:self forKeyPath:@"acceptingInput" options:NSKeyValueObservingOptionNew context:NULL];
    [self.game addObserver:self forKeyPath:@"isIdle" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.game removeObserver:self forKeyPath:@"currentMove"];
    [self.game removeObserver:self forKeyPath:@"goodSequences"];
    [self.game removeObserver:self forKeyPath:@"correctSequenceSeen"];
    [self.game removeObserver:self forKeyPath:@"acceptingInput"];
    [self.game removeObserver:self forKeyPath:@"isIdle"];
}

- (void)observeValueForKeyPath:(NSString*)keyPath
                      ofObject:(id)object
                        change:(NSDictionary*)change
                       context:(void*)context {
    
    if ([keyPath isEqualToString:@"currentMove"]) {
        NSNumber* _move = [change objectForKey:NSKeyValueChangeNewKey];
        [self playGameSequence:[_move integerValue]];
    }
    else if ([keyPath isEqualToString:@"goodSequences"]) {
        NSNumber* _goodSequences = [change objectForKey:NSKeyValueChangeNewKey];
        NSInteger _goodSequencesInt = [_goodSequences integerValue];
        if( _goodSequences>0 && _goodSequencesInt % 10 == 0){
            [self encouragementSounds];
        }
    }
    else if ([keyPath isEqualToString:@"correctSequenceSeen"]) {
        NSNumber* _done = [change objectForKey:NSKeyValueChangeNewKey];
        if( _done ){
            [self successfullSequence];
        }
    }
    else if ([keyPath isEqualToString:@"acceptingInput"]) {
        NSNumber* _acceptingInput = [change objectForKey:NSKeyValueChangeNewKey];
        if( _acceptingInput ){
//            [self enableGameInputs];
            self.gameInputsEnabled = TRUE;
        }
        else{
//            [self disableGameInputs];
            self.gameInputsEnabled = FALSE;
        }
    }
    else if ([keyPath isEqualToString:@"isIdle"]) {
        NSNumber* _gameIdle = [change objectForKey:NSKeyValueChangeNewKey];
        if( _gameIdle ){
            self.playPauseButton.enabled = TRUE;
            self.playPauseButton.hidden = FALSE;
        }
        else{
            self.playPauseButton.enabled = FALSE;
            self.playPauseButton.hidden = TRUE;
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)playPauseAction:(id)sender{

    if( [[sender title] isEqualToString:@"Start"] ){
        
        //Change Button
        [sender setTitle:@"Stop" forState:UIControlStateNormal];
        
        //play game start sound
        [SoundController play:@"start"];
        
        //pass off to gameController
        [self.game playSequence];
    }
//    else if( [[sender title] isEqualToString:@"Stop"] ){
//        
//        //Change Button
//        [sender setTitle:@"Start" forState:UIControlStateNormal];
//        
//        //play game start sound
//        [self badMove];
//        
//        //abort game
//        [self.game abortGame];
//    }
    
}

- (IBAction)move:(id)move{
    int moveCode = 0;
    
    if(self.gameInputsEnabled){
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
        if( [self.game checkIsMoveGood:moveCode] == FALSE){
            [self badMove];
        }
    }
}

- (void)successfullSequence{
    //play success sound
    [SoundController play:@"newplayer"];
    
    //highlight points added
    
}

- (void)encouragemenSounds{
    //play random encourangement sound
    [SoundController play: [self.encouragements objectAtIndex:[Game random:1:4]] ];
}

- (void)badMove{
    //change game view background colour
    
    [SoundController play:@"dying"];
}


//- (void)disableGameInputs{
//    self.greenButton.enabled = NO;
//    self.redButton.enabled = NO;
//    self.blueButton.enabled = NO;
//    self.yellowButton.enabled = NO;
//}
//- (void)enableGameInputs{
//    self.greenButton.enabled = YES;
//    self.redButton.enabled = YES;
//    self.blueButton.enabled = YES;
//    self.yellowButton.enabled = YES;
//}

//observe [game currentMove]
- (void)playGameSequence:(NSUInteger)move{
    
    [self.greenButton setHighlighted:FALSE];
    [self.redButton setHighlighted:FALSE];
    [self.blueButton setHighlighted:FALSE];
    [self.yellowButton setHighlighted:FALSE];
    
    if(move==1){ //press green
        [SoundController play:@"gun-green"];
        [self.greenButton sendActionsForControlEvents: UIControlEventTouchUpInside];
        [self.greenButton setHighlighted:TRUE];
    }
    else if (move==2){ //press red
        [SoundController play:@"gun-red"];
        [self.redButton sendActionsForControlEvents: UIControlEventTouchUpInside];
        [self.redButton setHighlighted:TRUE];
    }
    else if (move==3){ //press blue
        [SoundController play:@"gun-blue"];
        [self.blueButton sendActionsForControlEvents: UIControlEventTouchUpInside];
        [self.blueButton setHighlighted:TRUE];
    }
    else if (move==4){ //press yellow
        [SoundController play:@"gun-yellow"];
        [self.yellowButton sendActionsForControlEvents: UIControlEventTouchUpInside];
        [self.yellowButton setHighlighted:TRUE];
    }
    else{ //thow error
    }
}

@end

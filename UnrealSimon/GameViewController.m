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

- (void)playGameSequence:(NSUInteger)move; //observe [game currentMove]
- (void)pressButton:(UIButton *)button;
- (void)releaseButton:(UIButton *)button;
- (void)badMove; //activated by return from [game checkIsGoodMove]

- (void)successfullSequence; //observe [game correctSequenceSeen]
- (void)encouragementSounds; //observe [game goodSequences]

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     NSLog(@"viewDidLoad ");
    
	// Do any additional setup after loading the view, typically from a nib.
    self.encouragements = [NSMutableArray arrayWithObjects:
                      @"rampage",
                      @"dominating",
                      @"unstoppable",
                      @"godlike",
                      nil];
    
    self.gameInputsEnabled = FALSE;
    
    //initiate an instance of the game
    self.game = [[Game alloc] init];

}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAppear ");
    
    //add observers to game
    [self.game addObserver:self forKeyPath:@"currentMove" options:NSKeyValueObservingOptionNew context:NULL];
    [self.game addObserver:self forKeyPath:@"goodSequences" options:NSKeyValueObservingOptionNew context:NULL];
    [self.game addObserver:self forKeyPath:@"correctSequenceSeen" options:NSKeyValueObservingOptionNew context:NULL];
    [self.game addObserver:self forKeyPath:@"acceptingInput" options:NSKeyValueObservingOptionNew context:NULL];
    [self.game addObserver:self forKeyPath:@"isIdle" options:NSKeyValueObservingOptionNew context:NULL];
    
    //[Player userData synchronize]
}

- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"viewWillDisappear ");
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
    
    //debug observers
    NSLog(@"   observer %@ -> %@", keyPath, [change objectForKey:NSKeyValueChangeNewKey]);
    
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
        BOOL _done = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
        if( _done ){
            [self successfullSequence];
        }
    }
    else if ([keyPath isEqualToString:@"acceptingInput"]) {
        self.gameInputsEnabled = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
    }
    else if ([keyPath isEqualToString:@"isIdle"]) {
        self.playPauseButton.enabled = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
        self.playPauseButton.hidden = !self.playPauseButton.enabled;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)playPauseAction:(id)sender{

    NSLog(@"playPauseAction -> %@", [sender currentTitle]);
    
    if( [[sender currentTitle ] isEqualToString:@"Play"] ){
        
        //Change Button
        [sender setTitle:@"Quit" forState:UIControlStateNormal];
        
        //play game start sound
        [SoundController play:@"start"];
        
        //pass off to gameController
        [self.game playSequence];
    }
    else if( [[sender currentTitle] isEqualToString:@"Quit"] ){
        [self abortGame];
    }
    
}

- (IBAction)move:(id)move{
    int moveCode = 0;
    
    if(self.gameInputsEnabled){
        NSLog(@"move -> %@", [move restorationIdentifier]);
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
            [self abortGame];
        }
    }
    else{
        NSLog(@"moveIgnored -> %@", [move restorationIdentifier]);
    }
}

- (void)abortGame{
    //Change Button
    [self.playPauseButton setTitle:@"Play" forState:UIControlStateNormal];

    //play game start sound
    [self badMove];

    //abort game
    [self.game abortGame];
}

- (void)successfullSequence{
    //highlight points added
    
     //play success sound
    [self performSelector:@selector(delayPlaySound:)
               withObject:@"armour"
               afterDelay:0.5];
}

- (void)delayPlaySound:(NSString *)soundName{
    [SoundController play:soundName];
}

- (void)encouragementSounds{
    //play random encourangement sound
    [self performSelector:@selector(delayPlaySound:)
               withObject:[self.encouragements objectAtIndex:[self.game random:1:3]]
               afterDelay:0.5];
}

- (void)badMove{
    //flash game view background colour with red
    self.redBackground.alpha = 0.5;
    
    [self performSelector:@selector(delayPlaySound:)
               withObject:@"dying"
               afterDelay:0.1];
    
    //Animate to black color over period of two seconds (changeable)
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1]; 
    self.redBackground.alpha = 0;
    [UIView commitAnimations];
}


//observe [game currentMove]
//play game sequence to user
- (void)playGameSequence:(NSUInteger)move{
    
    NSLog(@"playGameSequence -> %lu", (unsigned long)move);
    
//    [self.greenButton setHighlighted:FALSE];
//    [self.redButton setHighlighted:FALSE];
//    [self.blueButton setHighlighted:FALSE];
//    [self.yellowButton setHighlighted:FALSE];
    
    //TODO insert pause between duplicate sequence numbers
    //maybe have timer in each if that makes highlighted false again after 0.25
    //which is less than difficult time play
    
    if(move==1){ //press green
        [SoundController play:@"gun-green"];
        [self pressButton:self.greenButton];
    }
    else if (move==2){ //press red
        [SoundController play:@"gun-red"];
        [self pressButton:self.redButton];
    }
    else if (move==3){ //press blue
        [SoundController play:@"gun-blue"];
        [self pressButton:self.blueButton];
    }
    else if (move==4){ //press yellow
        [SoundController play:@"gun-yellow"];
        [self pressButton:self.yellowButton];
    }
    else{ //thow error
    }
}

//worker method simulating button pushes
- (void)pressButton:(UIButton *)button{
//    NSLog(@"pressButton -> %@", [button restorationIdentifier]);
    [button sendActionsForControlEvents: UIControlEventTouchUpInside];
    [button setHighlighted:TRUE];
    [self performSelector:@selector(releaseButton:)
               withObject:button
               afterDelay:0.25];
}

//relase simulated button pushes
- (void)releaseButton:(UIButton *)button{
//    NSLog(@"releaseButton -> %@", [button restorationIdentifier]);
    [button setHighlighted:FALSE];
}

@end

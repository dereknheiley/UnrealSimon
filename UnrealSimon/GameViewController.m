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
    
//     NSLog(@"viewDidLoad ");
    
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
    
    //add observers to game
    [self.game addObserver:self forKeyPath:@"currentMove" options:NSKeyValueObservingOptionNew context:NULL];
    [self.game addObserver:self forKeyPath:@"goodSequences" options:NSKeyValueObservingOptionNew context:NULL];
    [self.game addObserver:self forKeyPath:@"correctSequenceSeen" options:NSKeyValueObservingOptionNew context:NULL];
    [self.game addObserver:self forKeyPath:@"acceptingInput" options:NSKeyValueObservingOptionNew context:NULL];
    [self.game addObserver:self forKeyPath:@"isIdle" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)viewWillAppear:(BOOL)animated{
//    NSLog(@"viewWillAppear ");
}

- (void)viewWillDisappear:(BOOL)animated{
//    NSLog(@"viewWillDisappear ");
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
        
        //Change Button
        [sender setTitle:@"Play" forState:UIControlStateNormal];
        
        //play game start sound
        [self badMove];
        
        //abort game
        [self.game abortGame];
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
            [self badMove];
        }
    }
    else{
        NSLog(@"moveIgnored -> %@", [move restorationIdentifier]);
    }
}

- (void)successfullSequence{
    //play success sound
    [SoundController play:@"newplayer"];
    
    //highlight points added
    
    
}

- (void)encouragemenSounds{
    //play random encourangement sound
    [SoundController play: [self.encouragements objectAtIndex:[Game random:0:3]] ];
}

- (void)badMove{
    //change game view background colour
    
    [SoundController play:@"dying"];
}

//observe [game currentMove]
- (void)playGameSequence:(NSUInteger)move{
    
    NSLog(@"playGameSequence -> %lu", (unsigned long)move);
    
    [self.greenButton setHighlighted:FALSE];
    [self.redButton setHighlighted:FALSE];
    [self.blueButton setHighlighted:FALSE];
    [self.yellowButton setHighlighted:FALSE];
    
    //TODO insert pause between duplicate sequence numbers
    
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

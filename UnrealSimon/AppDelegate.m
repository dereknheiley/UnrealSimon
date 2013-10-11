//
//  AppDelegate.m
//  UnrealSimon
//
//  Created by Derek Neil on 2013-10-06.
//  Copyright (c) 2013 DKN Teck. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //go back to tab see if child view controllers has everything already started
    UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
    
    //get refs for other view controllers
    if (tabController.viewControllers){
        
        //look for the nav controller in tab bar views
        for (UITabBarController *view2 in tabController.viewControllers) {
            
            if ([view2 isKindOfClass:[GameViewController class]]){
                self.GVC = (GameViewController *) view2;
            }
            else if ([view2 isKindOfClass:[PlayerOptionsViewController class]]){
                self.POVC = (PlayerOptionsViewController *) view2;
            }
//FUTURE
//            else if ([view2 isKindOfClass:[HighScoresViewController class]]){
//                self.HSVC = (HighScoresViewController *) view2;
//            }
            
        }
    }
    
    //instantiate Game
    self.game = [[Game alloc] init];

    //pass gameViewController ref to game
    //send moves to game
    //listens for results
    [self.GVC setGame:self.game];
    
    //init SoundController
    //plays sounds
    self.SC = [[SoundController alloc]init];
    
    //pass gameViewController ref to soundController
    [self.GVC setSound:self.SC];
    
    //init playerController
    //stores name, score, health
    self.PC = [[PlayerController alloc] init];
    
    //pass soundController ref to playerController
    //listens to music and effects attributes of player
    [self.PC setSound:self.SC];
    
    //pass playerController ref to game
    //sends changes to player data and options ( mode, difficulty )
    //listens for results of moves
    [self.PC setGame:self.game];
    
    //pass playerViewController ref to playerController
    //sends change to player data and options
    [self.POVC setPlayer:self.PC];
    
    [self.POVC setSound:self.SC];
    
    //pass gameViewController ref to playerController
    //observes score, health
    [self.GVC setPlayer:self.PC];
    
    
    //FUTURE
    
    //init highScoreConroller
    //stores list of scores
    //keeps record of highestScore
    
    
    //pass highScoreConroller ref to playerController
    //listens to changes in player score and compares against highestScore
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

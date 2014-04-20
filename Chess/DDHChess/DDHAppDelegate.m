//
//  DDHAppDelegate.m
//  DDHChess
//
//  Created by Colin Eberhardt and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2012 Colin Eberhardt. All rights reserved.
//

#import "DDHAppDelegate.h"

#import "DDHViewController.h"

@implementation DDHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // TAKEN FROM RAY WENDERLICH TUTORIAL AT http://www.raywenderlich.com/259/audio-tutorial-for-ios-playing-audio-programatically
//    // Set up the audio session
//	// See handy chart on pg. 55 of the Audio Session Programming Guide for what the categories mean
//	// Not absolutely required in this example, but good to get into the habit of doing
//	// See pg. 11 of Audio Session Programming Guide for "Why a Default Session Usually Isn't What You Want"
//	NSError *setCategoryError = nil;
//	[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:&setCategoryError];
//	
//	// Create audio player with background music
//    NSString *backgroundMusicPath = [[NSBundle mainBundle] pathForResource:@"sail" ofType:@"m4a"];
//	NSURL *backgroundMusicURL = [NSURL fileURLWithPath:backgroundMusicPath];
//	NSError *error;
//	_backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
//	[_backgroundMusicPlayer setDelegate:self];  // We need this so we can restart after interruptions
//	[_backgroundMusicPlayer setNumberOfLoops:1];	// Negative number means loop forever
//    [_backgroundMusicPlayer prepareToPlay];
//    [_backgroundMusicPlayer play];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[DDHViewController alloc] initWithNibName:@"DDHViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
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

//
//  DDHAppDelegate.h
//  DDHChess
//
//  Created by Colin Eberhardt and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2012 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class DDHViewController;



@interface DDHAppDelegate : UIResponder <UIApplicationDelegate, AVAudioPlayerDelegate>
{
    AVAudioPlayer *_backgroundMusicPlayer;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) DDHViewController *viewController;

@end

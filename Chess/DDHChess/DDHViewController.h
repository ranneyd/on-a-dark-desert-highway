//
//  DDHViewController.h - View controller for the main game view
//  DDHChess
//
//  Created by the app during startup. Displays background images
//  and creates instance of DDHBoard to run the game in.
//
//  Created by Colin Eberhardt and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2012 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDHRandomChessController.h"
#import <AVFoundation/AVFoundation.h>

@interface DDHViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *gameOverImage;

-(void) startFalling:(DDHRandomChessController *) caller;

-(AVAudioPlayer *) getPlayer;
@end

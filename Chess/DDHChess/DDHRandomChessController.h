//
//  DDHRandomChessController.h
//  DDHChess
//
//  Created by CS121 on 4/1/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDHMenuViewController.h"
#import "TransitionDelegate.h"
#import "DDHChessInfoView.h"


@interface DDHRandomChessController : UIViewController

@property (strong, nonatomic) TransitionDelegate *transitionController;
@property (strong, nonatomic) UILabel *player;
@property (retain, nonatomic) NSString *playerText;
@property (strong, nonatomic) DDHMenuViewController* menu;
@property (strong, nonatomic) DDHChessInfoView* info;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andRandom: (BOOL) random;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andSuperRandom: (BOOL) random;

-(IBAction)settings:(id)sender;

-(void)quitView;

@end

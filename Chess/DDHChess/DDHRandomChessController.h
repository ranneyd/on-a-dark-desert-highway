//
//  DDHRandomChessController.h
//  DDHChess
//
//  Created by CS121 on 4/1/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDHMenuViewController.h"

@interface DDHRandomChessController : UIViewController

@property (strong, nonatomic) UILabel *player;
@property (retain, nonatomic) NSString *playerText;
@property (strong, nonatomic) DDHMenuViewController* menu;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andRandom: (BOOL) random;

-(IBAction)settings:(id)sender;

@end

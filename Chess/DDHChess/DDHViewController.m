//
//  DDHViewController.m - Implementation of main game view controller
//  DDHChess
//
//  Created by Colin Eberhardt and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2012 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDHViewController.h"
#import "DDHRandomChessController.h"
#import <QuartzCore/QuartzCore.h>

@interface DDHViewController()
@property (weak, nonatomic) IBOutlet UIButton *randomChessButton;
@property (weak, nonatomic) IBOutlet UIButton *boringChessButton;

@end

@implementation DDHViewController
{
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _randomChessButton.layer.cornerRadius = 20;
    _randomChessButton.layer.masksToBounds = YES;
    
    _boringChessButton.layer.cornerRadius = 5;
    _boringChessButton.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)randomChessAction:(id)sender
{
    DDHRandomChessController *controller = [[DDHRandomChessController alloc] initWithNibName:nil bundle:nil];
    
    [self presentViewController:controller animated:NO completion:nil];
}

- (IBAction)boringChessAction:(id)sender
{
    DDHRandomChessController *controller = [[DDHRandomChessController alloc] initWithNibName:nil bundle:nil];
    
    [self presentViewController:controller animated:NO completion:nil];
}

@end

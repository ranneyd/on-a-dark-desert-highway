//
//  DDHViewController.m
//  DDHReversiGame
//
//  Created by Ray Wenderlich and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2012 Colin Eberhardt. All rights reserved.
//

#import "DDHViewController.h"
#import "DDHReversiBoard.h"
#import "DDHReversiBoardView.h"

@interface DDHViewController ()

@end

@implementation DDHViewController
{
    DDHReversiBoard* _board;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set the various background images
    self.backgroundImage.image = [UIImage imageNamed: @"Reversi.png"];
    self.gameOverImage.image = [UIImage imageNamed: @"GameOver.png"];
    self.gameOverImage.hidden = YES;
    
    //make board
    _board = [[DDHReversiBoard alloc] init];
    [_board setToInitialState];
    
    //make view
    
    DDHReversiBoardView* reversiBoard = [[DDHReversiBoardView alloc] initWithFrame:CGRectMake(88,160,600, 585) andBoard:_board];
    
    [self.view addSubview:reversiBoard];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
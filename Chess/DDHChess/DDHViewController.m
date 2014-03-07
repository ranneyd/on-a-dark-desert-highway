//
//  DDHViewController.m - Implementation of main game view controller
//  DDHChess
//
//  Created by Colin Eberhardt and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2012 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDHViewController.h"
#import "DDHBoard.h"
#import "DDHChessBoardView.h"

@implementation DDHViewController
{
    DDHBoard* _board; // Contains the board on which the game will be played
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create the board object
    _board = [[DDHBoard alloc] init];
    // Initialize the board
    [_board setToInitialState];
    

    // Set background color. For displaying images, use self.backgroundImage.image = [UIImage imageNamed: @"image.png"]
    self.view.backgroundColor = [UIColor blackColor];
    
    // Create and initialize view to display the board and add it to this controller
    DDHChessBoardView* chessBoard = [[DDHChessBoardView alloc] initWithFrame:CGRectMake(88,160,600, 585) andBoard:_board];
    [self.view addSubview:chessBoard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

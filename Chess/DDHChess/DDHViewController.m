//
//  DDHViewController.m
//  DDHReversiGame
//
//  Created by Colin Eberhardt and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2012 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDHViewController.h"
#import "DDHBoard.h"
#import "DDHChessBoardView.h"

@interface DDHViewController ()

@end

@implementation DDHViewController
{
    DDHBoard* _board;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set the various background images
//    self.backgroundImage.image = [UIImage imageNamed: @"Reversi.png"];
//    self.gameOverImage.image = [UIImage imageNamed: @"GameOver.png"];
//    self.gameOverImage.hidden = YES;
    
    
    // THIS IS COMMENTED OUT UNTIL THE BOARD IS READY TO GO
    //make board
    _board = [[DDHBoard alloc] init];
    [_board setToInitialState];
    
    NSLog(@"Built Board");
    
    self.view.backgroundColor = [UIColor grayColor];
    
    //make view
    DDHChessBoardView* chessBoard = [[DDHChessBoardView alloc] initWithFrame:CGRectMake(88,160,600, 585) andBoard:_board];
    
    [self.view addSubview:chessBoard];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  DDHRandomChessController.m
//  DDHChess
//
//  Created by CS121 on 4/1/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDHRandomChessController.h"
#import "DDHBoard.h"
#import "DDHChessBoardView.h"

@interface DDHRandomChessController ()

@end

@implementation DDHRandomChessController
{
    DDHBoard* _board; // Contains the board on which the game will be played
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Create the board object
    _board = [[DDHBoard alloc] init];
    // Initialize the board
    [_board setToInitialState];
    
    
    // Set background color. For displaying images, use self.backgroundImage.image = [UIImage imageNamed: @"image.png"]
    self.view.backgroundColor = [UIColor blackColor];
    
    // Create and initialize view to display the board and add it to this controller
    DDHChessBoardView* chessBoard = [[DDHChessBoardView alloc] initWithFrame:CGRectMake(88,160,600, 585) andBoard:_board];
    [_board addBoardView:chessBoard];
    [self.view addSubview:chessBoard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

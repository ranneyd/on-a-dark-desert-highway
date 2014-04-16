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
#import "DDHChessInfoView.h"

@interface DDHRandomChessController ()

@end

@implementation DDHRandomChessController
{
    DDHBoard* _board; // Contains the board on which the game will be played
    BOOL random;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andRandom: (BOOL) rand
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        random = rand;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    DDHChessInfoView* info = [[DDHChessInfoView alloc] initWithFrame:[[UIScreen mainScreen]applicationFrame]];
    
    
    // Create the board object
    _board = [[DDHBoard alloc] initWithView:info];
    // Initialize the board
    if(random)
        [_board setToInitialRandomState];
    else
        [_board setToInitialState];
    
    
    // Set background color. For displaying images, use self.backgroundImage.image = [UIImage imageNamed: @"image.png"]
    self.view.backgroundColor = [UIColor blackColor];
    
    // Create and initialize view to display the board and add it to this controller
    DDHChessBoardView* chessBoard = [[DDHChessBoardView alloc] initWithFrame:CGRectMake(88,([[UIScreen mainScreen]applicationFrame].size.height - 585.0)/2.0,600, 585) andBoard:_board];
    
    [self.view addSubview:info];
    [self.view addSubview:chessBoard];
    
    
    /* The spark that lit the powder keg
     
     
    NSMutableArray * imageArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 1; i <= 90; i++){
        [imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"explosion1_00%@%ld.png", i < 10? @"0" : @"", (long)i]]];
    }
	UIImageView * explosion = [[UIImageView alloc] initWithFrame:
                             CGRectMake(160, 120, 150, 130)];
	explosion.animationImages = imageArray;
	explosion.animationDuration = 1.1;
	explosion.contentMode = UIViewContentModeBottomLeft;
	[self.view addSubview:explosion];
	[explosion setAnimationRepeatCount:1];
    [explosion startAnimating];*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

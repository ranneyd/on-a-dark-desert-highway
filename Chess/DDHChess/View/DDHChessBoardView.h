//
//  DDHChessboardView.h - View to display the game board and hold subviews for each square
//  DDHChess
//
//  Created by DDHViewController to hold additional views for each square.
//  Handles general placement of views on game screen and adjusts size
//  based on parameters given by DDHViewController.
//
//  Created by Dustin Kane on 2/18/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDHBoard.h"

@interface DDHChessBoardView : UIView

@property (strong, nonatomic) UILabel *player;
@property (retain, nonatomic) NSString *playerText;

// Initialize the main view within a certain frame and specific board
- (id) initWithFrame:(CGRect)frame andBoard:(DDHBoard *)board;

@end

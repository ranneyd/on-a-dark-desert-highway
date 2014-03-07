//
//  DDHChesssBoardView.m - Implementation of main game view
//  DDHChess
//
//  Created by Dustin Kane on 2/18/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHChessBoardView.h"
#import "DDHBoardSquare.h"

@implementation DDHChessBoardView

- (id)initWithFrame:(CGRect)frame andBoard:(DDHBoard*) board
{
    // Initialize UIView and make sure it worked
    if (self = [super initWithFrame:frame])
    {
        // Use size of frame to determine size of board squares
        float rowHeight = frame.size.height / 8.0 - 1;
        float columnWidth = frame.size.width / 8.0 - 1;
        
        // Create the board using DDHBoardSquare objects
        for (int row = 0; row < 8; row++)
        {
            for(int col = 0; col < 8; col++)
            {
                // Create a DDHBoardSquare at each position on the board
                DDHBoardSquare * square = [[DDHBoardSquare alloc] initWithFrame:CGRectMake(col*columnWidth, row*rowHeight, columnWidth, rowHeight) column:col row:row board:board];
                
                // Make sure that we keep track of each square
                [self addSubview:square];
            }
        }
        
        // The DDHChessBoardView should be invisible. The square themselves have the correct colors
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end

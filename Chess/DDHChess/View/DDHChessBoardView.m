//
//  DDHChesssBoardView.m
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
    if (self = [super initWithFrame:frame])
    {
        float rowHeight = frame.size.height / 8.0 - 1;
        float columnWidth = frame.size.width / 8.0 - 1;
        
        //create the 8x8 cells for this board
        for (int row = 0; row < 8; row++)
        {
            for(int col = 0; col < 8; col++)
            {
                DDHBoardSquare * square = [[DDHBoardSquare alloc] initWithFrame:CGRectMake(col*columnWidth, row*rowHeight, columnWidth, rowHeight) column:col row:row board:board];
                
                // Set the colors of the squares of the board.
                if ((col+row) % 2 == 1)
                {
                    square.backgroundColor = [UIColor blackColor];
                }
                else
                {
                    square.backgroundColor = [UIColor colorWithRed:0.502 green:0 blue:0 alpha:1];
                }
                
                [self addSubview:square];
            }
        }
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


@end

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
        float rowHeight = frame.size.height / 8.0;
        float columnWidth = frame.size.width / 8.0;
        
        //create the 8x8 cells for this board
        for (int row = 0; row < 8; row++)
        {
            for(int col = 0; col < 8; col++)
            {
                DDHBoardSquare * square = [[DDHBoardSquare alloc] initWithFrame:CGRectMake(col*columnWidth, row*rowHeight, columnWidth, rowHeight) column:col row:row board:board];
                [self addSubview:square];
            }
        }
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


@end

//
//  DDHChesssBoardView.m - Implementation of main game view
//  DDHChess
//
//  Created by Dustin Kane on 2/18/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHChessBoardView.h"
#import "DDHBoardSquare.h"
#import <stdlib.h>
#import <AVFoundation/AVFoundation.h>

@implementation DDHChessBoardView{
    
}

- (id)initWithFrame:(CGRect)frame andBoard:(DDHBoard*) board
{
    // Initialize UIView and make sure it worked
    if (self = [super initWithFrame:frame])
    {
        
        
        // Use size of frame to determine size of board squares
        float rowHeight = frame.size.height / 8.0;
        float columnWidth = frame.size.width / 8.0;
        
        // Create the board using DDHBoardSquare objects
        for (int row = 0; row < 8; row++)
        {
            for(int col = 0; col < 8; col++)
            {
                int maxDist = 1000;
                int offset = arc4random() % maxDist;
                
                // Create a DDHBoardSquare at each position on the board
                DDHBoardSquare * square = [[DDHBoardSquare alloc] initWithFrame:CGRectMake(col*columnWidth, row*rowHeight-offset, columnWidth, rowHeight) column:col row:row board:board];
                
                [UIView animateWithDuration:(float)offset/(float)maxDist animations:^{
                    square.frame = CGRectOffset(square.frame, 0, offset+50);
                } completion:^(BOOL finished){
                    [UIView animateWithDuration:0.2f animations:^{
                        square.frame = CGRectOffset(square.frame, 0, -50);
                    }];
                }];
                
                // Make sure that we keep track of each square
                [self addSubview:square];
            }
        }
    }
    

    return self;
    
}


@end

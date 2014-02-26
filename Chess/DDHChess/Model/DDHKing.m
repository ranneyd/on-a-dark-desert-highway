//
//  DDHKing.m
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHKing.h"

@implementation DDHKing

-(void)highlightMoves
{
    DDHBoard* board = [self board];
    NSUInteger x = [self x];
    NSUInteger y = [self y];
    
    // Store moves in here.
    struct Tuple* points[8];
    
    // up
    points[0]->x = 0;
    points[0]->y = -1;
    // up right
    points[1]->x =  1;
    points[1]->y = -1;
    // right
    points[2]->x =  1;
    points[2]->y =  0;
    // down right
    points[3]->x =  1;
    points[3]->y =  1;
    // down
    points[4]->x =  0;
    points[4]->y =  1;
    // down left
    points[5]->x = -1;
    points[5]->y =  1;
    // left
    points[6]->x = -1;
    points[6]->y =  0;
    // up left
    points[7]->x = -1;
    points[7]->y = -1;
    
    // Iterate over moves. If on the board, go there. Knights don't have any other criteria for movement.
    int dx = 0;
    int dy = 0;
    for(int i = 0; i < 8; i++){
        dx = x + points[i]->x;
        dy = y + points[i]->y;
        if([board onBoardAtColumn:dx andRow:dy] && [board kingCouldMoveToColumn:dx andRow:dy])
            [board highlightAtColumn:dx andRow:dy withIndex:[self index]];
    }
}

@end

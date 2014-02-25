//
//  DDHKnight.m
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHKnight.h"

@implementation DDHKnight

-(void) highlightMoves
{
    DDHBoard* board = [self board];
    
    /*
     * Technically worse performance than the if statments, but more elegant?
     */
    
    // Iterate over all possible x shifts
    for(int dx = -2; dx <= 2; dx++)
    {
        // Iterate over all possible y shifts
        for(int dy = -2; dy <= 2; dy++)
        {
            // The y shift and the x shift cannot be the same, ie you can't move a knight two up and two left.
            // Knights cannot move in straight lines so neither dy nor dx can be 0.
            // Move must be on the board
            if(abs(dx) != abs(dy) && dx != 0 && dy != 00 && [board onBoardAtColumn:dx andRow:dy])
                [board highlightAtColumn:dx andRow:dy withIndex:[self index]];
        }
    }
    
    /*
    NSUInteger x = [self x];
    NSUInteger y = [self y];
    // up 1 left 2
    int dx = x - 2;
    int dy = y - 1;
    if([board onBoardAtColumn:dx andRow:dy])
        [board highlightAtColumn:dx andRow:dy withIndex:[self index]];
    // up 2 left 1
    dx = x - 1;
    dy = y - 2;
    if([board onBoardAtColumn:dx andRow:dy])
        [board highlightAtColumn:dx andRow:dy withIndex:[self index]];
    // up 2 right 1
    dx = x + 1;
    dy = y - 2;
    if([board onBoardAtColumn:dx andRow:dy])
        [board highlightAtColumn:dx andRow:dy withIndex:[self index]];
    // up 1 right 2
    dx = x + 2;
    dy = y - 1;
    if([board onBoardAtColumn:dx andRow:dy])
        [board highlightAtColumn:dx andRow:dy withIndex:[self index]];
    // down 1 right 2
    dx = x + 2;
    dy = y + 1;
    if([board onBoardAtColumn:dx andRow:dy])
        [board highlightAtColumn:dx andRow:dy withIndex:[self index]];
    // down 2 right 1
    dx = x + 1;
    dy = y + 2;
    if([board onBoardAtColumn:dx andRow:dy])
        [board highlightAtColumn:dx andRow:dy withIndex:[self index]];
    // down 2 left 1
    dx = x - 1;
    dy = y + 2;
    if([board onBoardAtColumn:dx andRow:dy])
        [board highlightAtColumn:dx andRow:dy withIndex:[self index]];
    // down 1 left 2
    dx = x - 2;
    dy = y + 1;
    if([board onBoardAtColumn:dx andRow:dy])
        [board highlightAtColumn:dx andRow:dy withIndex:[self index]];
    */
}

@end

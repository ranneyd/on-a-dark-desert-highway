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
    
    // left 1 up 1
    int dx = x - 1;
    int dy = y - 1;
    if([board onBoardAtColumn:dx andRow:dy] && [board kingCouldMoveToColumn:dx andRow:dy])
        [board highlightAtColumn:dx andRow:dy withIndex:[self index]];
    // up 1
    dx = x ;
    dy = y - 1;
    if([board onBoardAtColumn:dx andRow:dy] && [board kingCouldMoveToColumn:dx andRow:dy])
        [board highlightAtColumn:dx andRow:dy withIndex:[self index]];
    // right 1 up 1
    dx = x + 1;
    dy = y - 1;
    if([board onBoardAtColumn:dx andRow:dy] && [board kingCouldMoveToColumn:dx andRow:dy])
        [board highlightAtColumn:dx andRow:dy withIndex:[self index]];
    // right 1
    dx = x +1;
    dy = y;
    if([board onBoardAtColumn:dx andRow:dy] && [board kingCouldMoveToColumn:dx andRow:dy])
        [board highlightAtColumn:dx andRow:dy withIndex:[self index]];
    // right 1 down 1
    dx = x + 1;
    dy = y + 1;
    if([board onBoardAtColumn:dx andRow:dy] && [board kingCouldMoveToColumn:dx andRow:dy])
        [board highlightAtColumn:dx andRow:dy withIndex:[self index]];
    // down 1
    dx = x;
    dy = y + 1;
    if([board onBoardAtColumn:dx andRow:dy] && [board kingCouldMoveToColumn:dx andRow:dy])
        [board highlightAtColumn:dx andRow:dy withIndex:[self index]];
    // down 1 left 1
    dx = x - 1;
    dy = y + 1;
    if([board onBoardAtColumn:dx andRow:dy] && [board kingCouldMoveToColumn:dx andRow:dy])
        [board highlightAtColumn:dx andRow:dy withIndex:[self index]];
    // left 1
    dx = x -1;
    dy = y;
    if([board onBoardAtColumn:dx andRow:dy] && [board kingCouldMoveToColumn:dx andRow:dy])
        [board highlightAtColumn:dx andRow:dy withIndex:[self index]];
}

@end

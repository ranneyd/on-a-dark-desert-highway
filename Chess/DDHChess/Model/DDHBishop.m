//
//  DDHBishop.m
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHBishop.h"

@implementation DDHBishop

-(void) highlightMoves
{
    DDHBoard* board = [self board];
    NSUInteger x = [self x];
    NSUInteger y = [self y];
    
    // left up
    int dx = -1;
    int dy = -1;
    // Loop as long as the spots are still on the board
    while([board onBoardAtColumn:x + dx andRow: y + dy])
    {
        
        // If this spot has a piece in it...
        if(![board isEmptySquareAtColumn:x +dx andRow:y+dy])
        {
            // if it is our piece, do nothing and get out of the loop because you can't go further
            if([[board pieceAtColumn:x +dx andRow:y+dy] getPlayer] == [self getPlayer])
                break;
            // If it isn't our piece, highlight that spot but exit the loop because we can't go further
            else{
                [board highlightAtColumn:x + dx andRow:y + dy withIndex:[self index]];
                break;
            }
        }
        // If the place is empty...
        else{
            // highlight the current spot
            [board highlightAtColumn:x +dx andRow:y + dy withIndex:[self index]];
        }
        // Keep going
        --dy;
        --dx;
    }
    
    // left down
    dx = -1;
    dy = 1;
    // Loop as long as the spots are still on the board
    while([board onBoardAtColumn:x + dx andRow: y + dy])
    {
        
        // If this spot has a piece in it...
        if(![board isEmptySquareAtColumn:x +dx andRow:y+dy])
        {
            // if it is our piece, do nothing and get out of the loop because you can't go further
            if([[board pieceAtColumn:x +dx andRow:y+dy] getPlayer] == [self getPlayer])
                break;
            // If it isn't our piece, highlight that spot but exit the loop because we can't go further
            else{
                [board highlightAtColumn:x + dx andRow:y + dy withIndex:[self index]];
                break;
            }
        }
        // If the place is empty...
        else{
            // highlight the current spot
            [board highlightAtColumn:x +dx andRow:y + dy withIndex:[self index]];
        }
        // Keep going
        ++dy;
        --dx;
    }
    
    // right up
    dx = 1;
    dy = -1;
    // Loop as long as the spots are still on the board
    while([board onBoardAtColumn:x + dx andRow: y + dy])
    {
        
        // If this spot has a piece in it...
        if(![board isEmptySquareAtColumn:x +dx andRow:y+dy])
        {
            // if it is our piece, do nothing and get out of the loop because you can't go further
            if([[board pieceAtColumn:x +dx andRow:y+dy] getPlayer] == [self getPlayer])
                break;
            // If it isn't our piece, highlight that spot but exit the loop because we can't go further
            else{
                [board highlightAtColumn:x + dx andRow:y + dy withIndex:[self index]];
                break;
            }
        }
        // If the place is empty...
        else{
            // highlight the current spot
            [board highlightAtColumn:x +dx andRow:y + dy withIndex:[self index]];
        }
        // Keep going
        --dy;
        ++dx;
    }
    
    // left down
    dx = 1;
    dy = 1;
    // Loop as long as the spots are still on the board
    while([board onBoardAtColumn:x + dx andRow: y + dy])
    {
        
        // If this spot has a piece in it...
        if(![board isEmptySquareAtColumn:x +dx andRow:y+dy])
        {
            // if it is our piece, do nothing and get out of the loop because you can't go further
            if([[board pieceAtColumn:x +dx andRow:y+dy] getPlayer] == [self getPlayer])
                break;
            // If it isn't our piece, highlight that spot but exit the loop because we can't go further
            else{
                [board highlightAtColumn:x + dx andRow:y + dy withIndex:[self index]];
                break;
            }
        }
        // If the place is empty...
        else{
            // highlight the current spot
            [board highlightAtColumn:x +dx andRow:y + dy withIndex:[self index]];
        }
        // Keep going
        ++dy;
        ++dx;
    }
    
    
}

@end

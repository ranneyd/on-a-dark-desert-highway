//
//  DDHRook.m
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHRook.h"

@implementation DDHRook

-(void) highlightMovesWithBoard:(DDH2DArray *)board
{
    DDHBoard* board = [self board];
    NSUInteger x = [self x];
    NSUInteger y = [self y];
    
    // Store moves in here.
    struct Tuple* points[4];
    
    // up
    points[0]->x =  0;
    points[0]->y = -1;
    // down
    points[1]->x =  0;
    points[1]->y =  1;
    // left
    points[2]->x = -1;
    points[2]->y =  0;
    // right
    points[3]->x =  1;
    points[3]->y =  0;
    
    int dx;
    int dy;
    for(int i = 0; i < 4; i++){
        dx = x;
        dy = y;
        // Loop as long as the spots are still on the board
        while([board onBoardAtColumn:x + dx andRow: y + dy]){
            // If this spot has a piece in it...
            if(![board isEmptySquareAtColumn:x +dx andRow:y+dy]){
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
            dx += points[i]->x;
            dy += points[i]->y;
        }
    }
}

@end

//
//  DDHQueen.m
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHQueen.h"

@implementation DDHQueen

-(void) highlightMovesWithBoard:(DDH2DArray *)board
{
    
    //Code from DDHRook and DDHBishop. Don't judge.
    
    
    DDHBoard* board = [self board];
    NSUInteger x = [self x];
    NSUInteger y = [self y];
    
    // Store moves in here.
    struct Tuple* points[8];
    
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
    // left 1 up 1
    points[4]->x = -1;
    points[4]->y = -1;
    // left 1 down 1
    points[5]->x = -1;
    points[5]->y =  1;
    // right 1 up 1
    points[6]->x =  1;
    points[6]->y =  1;
    // right 1 down 1
    points[7]->x =  1;
    points[7]->y = -1;
    
    int dx;
    int dy;
    for(int i = 0; i < 8; i++){
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

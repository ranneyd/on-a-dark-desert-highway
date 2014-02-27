//
//  DDHBishop.m
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHBishop.h"

@implementation DDHBishop

-(BOOL**) highlightMovesWithBoard:(DDH2DArray *)board
{
    NSUInteger x = [self x];
    NSUInteger y = [self y];
    
    // Store moves in here.
    struct Tuple* points[4];
    
    // left 1 up 1
    points[0]->x = -1;
    points[0]->y = -1;
    // left 1 down 1
    points[1]->x = -1;
    points[1]->y =  1;
    // right 1 up 1
    points[2]->x =  1;
    points[2]->y =  1;
    // right 1 down 1
    points[3]->x =  1;
    points[3]->y = -1;
    
    BOOL** highlighting = [super blankHighlightingForBoard:board];
    
    // Iterate over move types. Either up and left, up and right, etc...
    for(int i = 0; i < 4; i++){
        // accumulate new positions. Don't want to include piece's current position.
        int dx = x + points[i]->x;
        int dy = y + points[i]->y;
        // While we're still on the board.
        while([self onBoard:board AtColumn:dx andRow:dy]){
            // If this spot has a piece in it...
            if(!([board objectAtColumn:dx andRow:dy] == nil)){
                // if it is our piece, do nothing and get out of the loop because you can't go further
                if([[board objectAtColumn:dx andRow:dy] getPlayer] == [self getPlayer])
                    break;
                // If it isn't our piece, highlight that spot but exit the loop because we can't go further
                else{
                    highlighting[dx][dy] = YES;
                    break;
                }
            }
            // If the place is empty...
            else{
                // highlight the current spot
                highlighting[dx][dy] = YES;
            }
            // Keep going
            dx += points[i]->x;
            dy += points[i]->y;
        }

    }
    return highlighting;
}

@end

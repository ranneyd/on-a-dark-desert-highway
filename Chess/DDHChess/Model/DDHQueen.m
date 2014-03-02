//
//  DDHQueen.m
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHQueen.h"

@implementation DDHQueen

-(NSMutableArray*) highlightMovesWithBoard:(DDH2DArray *)board
{
    NSUInteger x = [self x];
    NSUInteger y = [self y];
    
    // Store moves in here.
    DDHTuple* points[8];
    
    // up
    [points[0] setX:  0];
    [points[0] setY: -1];
    // down
    [points[1] setX:  0];
    [points[1] setY:  1];
    // left
    [points[2] setX: -1];
    [points[2] setY:  0];
    // right
    [points[3] setX:  1];
    [points[3] setY:  0];
    // left 1 up 1
    [points[4] setX: -1];
    [points[4] setY: -1];
    // left 1 down 1
    [points[5] setX: -1];
    [points[5] setY:  1];
    // right 1 up 1
    [points[6] setX:  1];
    [points[6] setY:  1];
    // right 1 down 1
    [points[7] setX:  1];
    [points[7] setY: -1];
    
    NSMutableArray *highlighting = [[NSMutableArray alloc]init];
    
    // Iterate over move types. Either up and left, up and right, etc...
    for(int i = 0; i < 4; i++){
        // accumulate new positions. Don't want to include piece's current position.
        int dx = x + [points[i] x];
        int dy = y + [points[i] y];
        // While we're still on the board.
        while([self onBoard:board AtColumn:dx andRow:dy]){
            // If this spot has a piece in it...
            if(!([board objectAtColumn:dx andRow:dy] == NULL)){
                // if it is our piece, do nothing and get out of the loop because you can't go further
                if([[board objectAtColumn:dx andRow:dy] getPlayer] == [self getPlayer])
                    break;
                // If it isn't our piece, highlight that spot but exit the loop because we can't go further
                else{
                    [highlighting addObject:[[DDHTuple alloc] initWithX:dx andY:dy]];
                    break;
                }
            }
            // If the place is empty...
            else{
                // highlight the current spot
                [highlighting addObject:[[DDHTuple alloc] initWithX:dx andY:dy]];
            }
            // Keep going
            dx += [points[i] x];
            dy += [points[i] y];
        }
        
    }
    return highlighting;
}
-(NSString*) description
{
    if ([super getPlayer] == ChessPlayerBlack)
        return @"BlackQueen";
    return @"WhiteQueen";
}
@end

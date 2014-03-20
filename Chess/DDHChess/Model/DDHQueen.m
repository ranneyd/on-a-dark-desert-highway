//
//  DDHQueen.m
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHQueen.h"
#import "DDHBoard.h"

@implementation DDHQueen

-(NSMutableArray*) highlightMovesWithBoard:(DDHBoard*)board andCheck:(BOOL) check
{
    NSUInteger x = [self x];
    NSUInteger y = [self y];
    
    // Store move types in here.
    NSMutableArray* points = [[NSMutableArray alloc] initWithCapacity:8];
    
    // up
    [points addObject:[[DDHTuple alloc] initWithX:0 andY:-1]];
    
    // down
    [points addObject:[[DDHTuple alloc] initWithX:0 andY:1]];
    
    // left
    [points addObject:[[DDHTuple alloc] initWithX:-1 andY:0]];
    
    // right
    [points addObject:[[DDHTuple alloc] initWithX:1 andY:0]];
    
    // up 1 left 1
    [points addObject:[[DDHTuple alloc] initWithX:-1 andY:-1]];
    
    // down 1 left 1
    [points addObject:[[DDHTuple alloc] initWithX:-1 andY:1]];
    
    // up 1 right 1
    [points addObject:[[DDHTuple alloc] initWithX:1 andY:-1]];
    
    // down 1 right 1
    [points addObject:[[DDHTuple alloc] initWithX:1 andY:1]];
    
    NSMutableArray *highlighting = [[NSMutableArray alloc]init];
    
    // Iterate over move types. Either up and left, up and right, etc...
    for(int i = 0; i < 8; i++){
        // accumulate new positions. Don't want to include piece's current position.
        DDHTuple* nextMove = [points objectAtIndex:i];
        int dx = x + [nextMove x];
        int dy = y + [nextMove y];
        // While we're still on the board.
        while([self onBoard:board AtColumn:dx andRow:dy]){
            if( !(check && [board checkIfMoveFromColumn:x andRow:y toColumn:dx andRow:dy])){
                /*if([self movingIntoCheckinColumn:dx andRow:dy withBoard:board])
                 NSLog(@"Moving into check");*/
                // If this spot has a piece in it...
                if(![board isEmptySquareAtColumn:dx andRow:dy ]){
                    // if it is our piece, do nothing and get out of the loop because you can't go further
                    if([[board pieceAtColumn:dx andRow:dy] getPlayer] == [self getPlayer])
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
            }
            // Keep going
            dx += [nextMove x];
            dy += [nextMove y];
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

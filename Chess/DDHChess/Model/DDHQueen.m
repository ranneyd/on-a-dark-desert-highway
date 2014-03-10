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

-(NSMutableArray*) attackablePositionsOnBoard:(DDHBoard*)board
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
    
    NSMutableArray *attackable = [[NSMutableArray alloc]init];
    
    // Iterate over move types. Either up and left, up and right, etc...
    for(int i = 0; i < 8; i++){
        // accumulate new positions. Don't want to include piece's current position.
        DDHTuple* nextMove = [points objectAtIndex:i];
        int dx = x + [nextMove x];
        int dy = y + [nextMove y];
        // While we're still on the board.
        while([self onBoard:board AtColumn:dx andRow:dy]){
            // If this spot has a piece in it...
            if(![board isEmptySquareAtColumn:dx andRow:dy ]){
                // if it is our piece, do nothing and get out of the loop because you can't go further
                if([[board pieceAtColumn:dx andRow:dy] getPlayer] == [self getPlayer])
                    break;
                // If it isn't our piece, highlight that spot but exit the loop because we can't go further
                else{
                    [attackable addObject:[[DDHTuple alloc] initWithX:dx andY:dy]];
                    break;
                }
            }
            // If the place is empty...
            else{
                // highlight the current spot
                [attackable addObject:[[DDHTuple alloc] initWithX:dx andY:dy]];
            }
            // Keep going
            dx += [nextMove x];
            dy += [nextMove y];
        }
        
    }
    return attackable;
}

-(NSMutableArray*) highlightMovesWithBoard:(DDHBoard*)board
{
    // Array of possible moves to be highlighted.
    NSMutableArray *highlighting = [[NSMutableArray alloc]init];
    
    // Array of all possible moves.
    NSMutableArray *attackable = [self attackablePositionsOnBoard:board];
    
    for (DDHTuple* position in attackable) {
        NSInteger positionColumn = [position x];
        NSInteger positionRow = [position y];
        // Check if moving to this square puts the king in check. If it doesn't put the king in check, add the move
        // to the list of possible moves.
        if (![self kingInCheckAfterMovingToColumn:positionColumn andRow:positionRow onBoard:board]) {
            [highlighting addObject:[[DDHTuple alloc] initWithX:positionColumn andY:positionRow]];
        }
    }
    
    // Iterate over move types. Either up and left, up and right, etc...
    return highlighting;
}
-(NSString*) description
{
    if ([super getPlayer] == ChessPlayerBlack)
        return @"BlackQueen";
    return @"WhiteQueen";
}
@end

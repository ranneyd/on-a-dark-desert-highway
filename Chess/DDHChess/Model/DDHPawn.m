//
//  DDHPawn.m
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHPawn.h"
#import "DDHTuple.h"
#import "DDHBoard.h"

@implementation DDHPawn
{
    BOOL hasNotMoved;
}

-(id) initWithPlayer:(ChessPlayer) player atColumn:(NSUInteger)column andRow:(NSUInteger)row
{
    self = [super initWithPlayer:player atColumn:column andRow:row];
    hasNotMoved = YES
    ;
    return self;
}

-(NSMutableArray*) highlightMovesWithBoard:(DDHBoard*)board
{
    // Array of moves to be returned
    NSMutableArray* highlighting = [[NSMutableArray alloc] init];
    
    NSInteger column = [self x];
    NSInteger row = [self y];
    
    NSInteger verticalMove = row + pow(-1, [self getPlayer]);
    
    // Variables for attacking other pieces. If the pawn can't move left or right,
    // set the values to be off the board!
    NSInteger leftMove = column - 1 > 0 ? column - 1 : -1;
    NSInteger rightMove = column + 1 < [board getColumns] ? column + 1 : -1;
    
    // Next check for ability to move two squares forward.
    if (hasNotMoved) {
        // Make pawn highlight two squares in front...note the direction of "front" is based on the player
        NSInteger verticalDoubleMove = row + 2*pow(-1, [self getPlayer]);
        
        // Sanity check to make sure the move is on the board
        if ([self onBoard:board AtColumn:column andRow:verticalDoubleMove]) {
            
            // Make sure both the square immediately in front of and two squares in front of the pawn are empty.
            if ([board isEmptySquareAtColumn:column andRow:verticalDoubleMove] && [board isEmptySquareAtColumn:column andRow:verticalMove]) {
                [highlighting addObject:[[DDHTuple alloc] initWithX:column andY:verticalDoubleMove]];
            }
        }
        
    }
    
    // Check if the pawn can move forward.
    if ([self onBoard:board AtColumn:column andRow:verticalMove]) {
        
        // If the square in front of the pawn is empty, it can move there.
        if ([board isEmptySquareAtColumn:column andRow:verticalMove]) {
            [highlighting addObject:[[DDHTuple alloc] initWithX:column andY:verticalMove]];
        }
    }
    
    // Check if we can attack other pieces to the left.
    if ([self onBoard:board AtColumn:leftMove andRow:verticalMove]) {
        if (![board isEmptySquareAtColumn:leftMove andRow:verticalMove]) {
            if ([board pieceAtColumn:leftMove andRow:verticalMove notBelongingToPlayer:[self getPlayer]]) {
                [highlighting addObject:[[DDHTuple alloc] initWithX:leftMove andY:verticalMove]];
            }
        }
    }
    
    // Check if the pawn can attack other pieces to the right.
    if ([self onBoard:board AtColumn:rightMove andRow:verticalMove]) {
        if (![board isEmptySquareAtColumn:rightMove andRow:verticalMove]) {
            if ([board pieceAtColumn:rightMove andRow:verticalMove notBelongingToPlayer:[self getPlayer]]) {
                [highlighting addObject:[[DDHTuple alloc] initWithX:rightMove andY:verticalMove]];
            }
        }
    }
 
    return highlighting;
}

-(void) moveToColumn:(NSInteger)column andRow:(NSInteger)row
{
    if (hasNotMoved)
    {
        hasNotMoved = NO;
    }
    [self setX:column];
    [self setY:row];
}

- (NSString*) description
{
    if ([self getPlayer] == ChessPlayerBlack)
        return @"BlackPawn";
    return @"WhitePawn";
}

@end

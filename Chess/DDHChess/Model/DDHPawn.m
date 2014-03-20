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
}

-(id) initWithPlayer:(ChessPlayer) player atColumn:(NSUInteger)column andRow:(NSUInteger)row
{
    self = [super initWithPlayer:player atColumn:column andRow:row];
    return self;
}

-(NSMutableArray*) highlightMovesWithBoard:(DDHBoard*)board andCheck:(BOOL) check
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
    if (([self getPlayer] == ChessPlayerBlack && [self y] == 6) || ([self getPlayer] == ChessPlayerWhite && [self y] == 1)) {
        // Make pawn highlight two squares in front...note the direction of "front" is based on the player
        NSInteger verticalDoubleMove = row + 2*pow(-1, [self getPlayer]);
        
        [self pacifistCheckAndMoveToColumn:column andRow:verticalDoubleMove withBoard:board andHighlighting:highlighting];
    }
    
    // Check if the pawn can move forward.
    [self pacifistCheckAndMoveToColumn:column andRow:verticalMove withBoard:board andHighlighting:highlighting];
    
    // Check if we can attack other pieces to the left.
    [self warmongerCheckAndMoveToColumn:leftMove andRow:verticalMove withBoard:board andHighlighting:highlighting];
    
    // Check if the pawn can attack other pieces to the right.
    [self warmongerCheckAndMoveToColumn:rightMove andRow:verticalMove withBoard:board andHighlighting:highlighting];
 
    return highlighting;
}

// Like checkAndMoveTo... except doesn't work if the desired square has any piece, including an enemy
-(void) pacifistCheckAndMoveToColumn:(NSUInteger) column andRow:(NSUInteger) row withBoard:(DDHBoard*) board andHighlighting:(NSMutableArray*) highlighting{
    // Check if the pawn can move forward.
    if ([self onBoard:board AtColumn:column andRow:row]) {
        // If the square in front of the pawn is empty, it can move there.
        if ([board isEmptySquareAtColumn:column andRow:row]) {
            [highlighting addObject:[[DDHTuple alloc] initWithX:column andY:row]];
        }
    }
}

// Like checkAndMoveTo... except only works if the desired square has an enemy
-(void) warmongerCheckAndMoveToColumn:(NSUInteger) column andRow:(NSUInteger) row withBoard:(DDHBoard*) board andHighlighting:(NSMutableArray*) highlighting{
    // Check if spot is on board
    if ([self onBoard:board AtColumn:column andRow:row]) {
        // If the square in front of the pawn is not empty and the piece in it does not belong to us
        if (![board isEmptySquareAtColumn:column andRow:row] && [board doesPieceAtColumn:column andRow:row notBelongToPlayer:[self getPlayer]]) {
            [highlighting addObject:[[DDHTuple alloc] initWithX:column andY:row]];
        }
    }
}

-(void) moveToColumn:(NSInteger)column andRow:(NSInteger)row
{
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

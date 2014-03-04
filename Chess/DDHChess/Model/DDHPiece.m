//
//  DDHPiece.m
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHPiece.h"
#import "DDHBoard.h"

@implementation DDHPiece
{
    ChessPlayer _owner;
}

-(id) initWithPlayer:(ChessPlayer) player atColumn:(NSUInteger)column andRow:(NSUInteger)row
{
    self = [super init];
    [self moveToColumn:column andRow:row];
    _owner = player;
    return self;
}

-(NSMutableArray*) highlightMovesWithBoard:(DDHBoard*)board
{
    // To be overridden
    return NULL;
}

-(void) moveToColumn:(NSInteger)column andRow:(NSInteger)row
{
    [self setX:column];
    [self setY:row];
}

-(ChessPlayer)getPlayer
{
    return _owner;
}

-(BOOL) onBoard:(DDHBoard*)board AtColumn:(NSInteger)column andRow:(NSInteger)row
{
    return column >= 0 && column < [board getColumns] && row >= 0 && row < [board getRows];
}

-(BOOL**) blankHighlightingForBoard:(DDHBoard*) board
{
    // New Array of booleans on heap (double pointers because 2d array in C means pointers to pointers? It was yelling at me otherwise)
    // Should be size of rows*columns
    BOOL** highlighting = malloc([board getRows]*[board getColumns]);
    // Initialize everything to false
    for (int i = 0; i < [board getRows]; i++)
        for (int j = 0; j < [board getColumns]; j++)
            highlighting[i][j] = NO;
    return highlighting;
}

-(NSString*) description
{
    if (_owner == ChessPlayerBlack)
        return @"Black";
    return @"White";
}

// After the pawn moves to (column, row) location, is the King in check?
-(BOOL) kingInCheckAfterMovingToColumn:(NSInteger)column andRow:(NSInteger)row onBoard:(DDHBoard*)board
{
    NSInteger oldColumn = [self x];
    NSInteger oldRow = [self y];
    
    // Find out if King is in check after moving by moving the piece and checking if
    // the King is in check.
    [self moveToColumn:column andRow:row];
    if ([board kingInCheckBelongingTo:[self getPlayer]])
    {
        // The move puts the King in check, so undo the move and return YES
        [self moveToColumn:oldColumn andRow:oldRow];
        return YES;
    }
    
    // Otherwise, the king is not in check, so return NO
    return NO;
}

// TODO: Make use of board's kingInCheck function. Make copy of board as to not mess things up

-(BOOL)movingIntoCheckinColumn:(NSInteger)column andRow:(NSInteger)row withBoard:(DDHBoard *)board
{
    return NO;
}

@end

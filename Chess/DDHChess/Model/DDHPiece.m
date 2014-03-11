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
    return NO;
}

// TODO: Make use of board's kingInCheck function. Make copy of board as to not mess things up

/*-(BOOL)movingIntoCheckinColumn:(NSInteger)column andRow:(NSInteger)row withBoard:(DDHBoard *)board
{
    NSLog(@"I am %@ and I'm at (%d, %d) moving to (%d, %d)", [self description], [self x], [self y], column, row);
    DDHPiece* oldPiece = [board pieceAtColumn:column andRow:row];
    NSLog(@"%@ at (%d, %d)", [oldPiece description],column, row);
    NSUInteger oldX = [self x];
    NSUInteger oldY = [self y];
    
    [board setHighlighterwithColumn:[self x] andRow:[self y]];
    [board makeMoveToColumn:column andRow:row];
    
    NSLog(@"Checking check?");
    BOOL movingIntoCheck = [board kingInCheckBelongingTo:[self getPlayer]];
    NSLog(@"Done Checking check");
    
    
    [board setHighlighterwithColumn:[oldPiece x] andRow:[oldPiece y]];
    [board putPiece:self inColumn:oldX andRow:oldY];
    [board putPiece:oldPiece inColumn: column andRow: row];
    [board invertState];
    
    
    NSLog(@"Piece now at (%d, %d) is %@", column, row,[board pieceAtColumn:column andRow:row]);
    NSLog(@"Piece now at (%d, %d) is %@", oldX, oldY,[board pieceAtColumn:oldX andRow:oldY]);
    
    
    NSLog(@"I'm outro");
    
    return movingIntoCheck;
}*/

@end

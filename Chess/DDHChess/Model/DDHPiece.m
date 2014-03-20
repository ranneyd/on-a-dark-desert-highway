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
    BOOL _hasMoved;
}

-(id) initWithPlayer:(ChessPlayer) player atColumn:(NSUInteger)column andRow:(NSUInteger)row
{
    self = [super init];
    [self moveToColumn:column andRow:row];
    _owner = player;
    _hasMoved = NO;
    return self;
}

-(NSMutableArray*) highlightMovesWithBoard:(DDHBoard*)board andCheck:(BOOL) check
{
    // To be overridden
    return NULL;
}

-(void) moveToColumn:(NSInteger)column andRow:(NSInteger)row
{
    _hasMoved = YES;
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

-(void) setPlayer:(ChessPlayer) player
{
    _owner = player;
}


-(NSString*) description
{
    if (_owner == ChessPlayerBlack)
        return @"Black";
    return @"White";
}

-(BOOL) checkAndMoveToColumn:(NSUInteger) column andRow:(NSUInteger) row withBoard:(DDHBoard*) board andHighlighting:(NSMutableArray*) highlighting andCheck:(BOOL)check
{
    
    //NSLog(@"Checking piece %@ going to (%d,%d)", [self description], column, row);
    // Check if spot is on the board
    if([self onBoard:board AtColumn:column andRow:row]){
        if(!(check &&[board checkIfMoveFromColumn:[self x] andRow:[self y] toColumn:column andRow:row])){
            // If the board is empty, we can move there, but there is no piece so return NO
            if([board isEmptySquareAtColumn:column andRow:row]){
                [highlighting addObject:[[DDHTuple alloc] initWithX:column andY:row]];
            }
            // If not empty (previous if returns) and not us, then it belongs to another player, so we can move there.
            if ([[board pieceAtColumn:column andRow:row] getPlayer] != [self getPlayer]){
                [highlighting addObject:[[DDHTuple alloc] initWithX:column andY:row]];
            }
        }
        
        if ([board isEmptySquareAtColumn:column andRow:row])
            return NO;
        else
            return YES;
    }
    return YES;
}

-(BOOL)hasMoved{
    return _hasMoved;
}

-(void) setMoved:(BOOL) moved{
    _hasMoved = moved;
}


@end

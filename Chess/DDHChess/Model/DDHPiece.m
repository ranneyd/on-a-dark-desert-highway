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

-(NSMutableArray*) highlightMovesWithBoard:(DDHBoard*)board andCheck:(BOOL) check
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

-(BOOL) checkAndMoveToColumn:(NSUInteger) column andRow:(NSUInteger) row withBoard:(DDHBoard*) board andHighlighting:(NSMutableArray*) highlighting
{
    // Check if spot is on the board and (If the square is empty or occupied by an enemy piece)
    BOOL success = ([self onBoard:board AtColumn:column andRow:row]
                    && ([board isEmptySquareAtColumn:column andRow:row]
                        || [board doesPieceAtColumn:row andRow:column notBelongToPlayer:[self getPlayer]]));
    if (success)
        [highlighting addObject:[[DDHTuple alloc] initWithX:column andY:row]];
    return success;
}


@end

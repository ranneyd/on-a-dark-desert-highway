//
//  DDHPiece.m
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHPiece.h"

@implementation DDHPiece
{
    ChessPlayer _owner;
}

-(id) initWithPlayer:(ChessPlayer) player andIndex:(int) index atColumn:(NSUInteger)column andRow:(NSUInteger)row
{
    self = [super init];
    [self setIndex:index];
    [self moveToColumn:column andRow:row];
    _owner = player;
    return self;
}

-(DDHTuple*) highlightMovesWithBoard:(DDH2DArray *)board
{
    // To be overridden
    return nil;
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

-(BOOL) onBoard:(DDH2DArray*)board AtColumn:(NSInteger)column andRow:(NSInteger)row
{
    return column < 0 || column >= [board columns] || row < 0 || row >= [board rows];
}

-(BOOL**) blankHighlightingForBoard:(DDH2DArray*) board
{
    // New Array of booleans on heap (double pointers because 2d array in C means pointers to pointers? It was yelling at me otherwise)
    // Should be size of rows*columns
    BOOL** highlighting = malloc([board rows]*[board columns]);
    // Initialize everything to false
    for (int i = 0; i < [board rows]; i++)
        for (int j = 0; j < [board columns]; j++)
            highlighting[i][j] = NO;
    return highlighting;
}

@end

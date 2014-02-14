//
//  DDHBoard.m
//  DDHChess
//
//  Created by Ray Wenderlich and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "DDHBoard.h"

@implementation DDHBoard
{
    // CHANGE FOR DYNAMICALLY SIZED BOARD
    NSUInteger _board[8][8];
}

- (id) init
{
    if (self = [super init]){
        [self clearBoard];
    }
    return self;
}

- (BoardCellState) cellStateAtColumn:(NSInteger)column andRow:(NSInteger)row
{
    [self checkBoundsForColumn:column andRow:row];
    return _board[column][row];
}

-(void) setCellState:(BoardCellState)state forColumn:(NSInteger)column andRow:(NSInteger)row
{
    [self checkBoundsForColumn:column andRow:row];
    _board[column][row] = state;
}

// CHANGE FOR DYNAMICALLY SIZED BOARD
-(void)checkBoundsForColumn: (NSInteger) column andRow: (NSInteger) row
{
    if (column < 0 || column > 7 || row < 0 || row > 7)
        [NSException raise:NSRangeException format:@"row or column out of bounds"];
}

// CHANGE FOR DYNAMICALLY SIZED BOARD
-(void) clearBoard
{
    // Hack way to do it. Change this
    memset(_board, 0, sizeof(NSUInteger) * 8 * 8);
}

@end

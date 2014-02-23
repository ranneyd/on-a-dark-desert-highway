//
//  DDHBoard.m
//  DDHChess
//
//  Created by Colin Eberhardt and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHBoard.h"
#import "DDHBoardDelegate.h"
#import "ChessPlayer.h"
#import "DDHPiece.h"
#import "DDHNullPiece.h"

@implementation DDHBoard
{
    // CHANGE FOR DYNAMICALLY SIZED BOARD
    NSMutableArray* _board;
    id<DDHBoardDelegate> _delegate;
}

- (id) init
{
    if (self = [super init]){
        [self clearBoard];
        _boardDelegate = [[DDHMulticastDelegate alloc] init];
        _delegate = (id)_boardDelegate;
    }
    return self;
}



- (DDHPiece*) pieceAtColumn:(NSInteger)column andRow:(NSInteger)row
{
    [self checkBoundsForColumn:column andRow:row];
    return [[_board objectAtIndex:row] objectAtIndex:column];
}

-(void) putPiece:(DDHPiece *)piece inColumn:(NSInteger)column andRow:(NSInteger)row
{
    [self checkBoundsForColumn:column andRow:row];
    [[_board objectAtIndex:row] replaceObjectAtIndex:column withObject:piece];
    //[self informDelegateOfStateChanged:state forColumn:column andRow:row];
}


-(void)informDelegateOfStateChanged:(BoardCellState) state forColumn:(NSInteger)column andRow:(NSInteger) row
{
    if([_delegate respondsToSelector:@selector(cellStateChanged:forColumn:addRow:)]){
        [_delegate cellStateChanged:state forColumn:column addRow:row];
    }
}

// CHANGE FOR DYNAMICALLY SIZED BOARD
-(void)checkBoundsForColumn: (NSInteger) column andRow: (NSInteger) row
{
    if (column < 0 || column > 7 || row < 0 || row > 7)
        [NSException raise:NSRangeException format:@"row or column out of bounds"];
}

// CHANGE FOR DYNAMICALLY SIZED BOARD

//SKETCHY AND PROBABLY HAS MEMORY LEAKS
-(void) clearBoard
{
    // Hack way to do it. Change this. Almost certainly doesn't work without leaks
    _board = [[NSMutableArray alloc] initWithCapacity:8];
    for (int i = 0; i < 8; i++){
        NSMutableArray* newRow = [[NSMutableArray alloc] initWithCapacity:8];
        [_board addObject:newRow];
        for(int j = 0; j < 8; j++){
            [newRow addObject:[[DDHNullPiece alloc] init]];
        }
    }
    //[self informDelegateOfStateChanged:BoardCellStateEmpty forColumn:-1 andRow:-1];
}

@end

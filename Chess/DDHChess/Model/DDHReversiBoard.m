//
//  DDHReversiBoard.m
//  DDHChess
//
//  Created by Ray Wenderlich and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "DDHReversiBoard.h"

@implementation DDHReversiBoard

-(void) setToInitialState
{
    // clear le board
    
    [super clearBoard];
    
    //add initial play counters
    [super setCellState:BoardCellStateWhitePiece forColumn:3 andRow:3];
    [super setCellState:BoardCellStateBlackPiece forColumn:4 andRow:3];
    [super setCellState:BoardCellStateBlackPiece forColumn:3 andRow:4];
    [super setCellState:BoardCellStateWhitePiece forColumn:4 andRow:4];
    
    _whiteScore = 2;
    _blackScore = 2;
    _nextMove = BoardCellStateBlackPiece;
}

-(BOOL) isValidMoveToColumn:(NSInteger)column andRow:(NSInteger)row
{
    if([super cellStateAtColumn:column andRow:row] != BoardCellStateEmpty)
        return NO;
    return YES;
}

-(void)makeMoveToColumn:(NSInteger)column andRow:(NSInteger)row
{
    //place the playing piece at the given location
    
    [self setCellState:self.nextMove forColumn:column andRow:row];
    
    _nextMove = [self invertState:_nextMove];
}

- (BoardCellState) invertState: (BoardCellState)state
{
    if (state == BoardCellStateBlackPiece)
        return BoardCellStateWhitePiece;
    if (state == BoardCellStateWhitePiece)
        return BoardCellStateBlackPiece;
    return BoardCellStateEmpty;
}

@end

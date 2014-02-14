//
//  SHCReversiBoard.m
//  SHCReversiGame
//
//  Created by Dustin Kane on 2/15/14.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "SHCReversiBoard.h"

@implementation SHCReversiBoard

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
}

@end

//
//  SHCBoard.h
//  SHCReversiGame
//
//  Created by Dustin Kane on 2/15/14.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoardCellState.h"

/* The Board */
@interface SHCBoard : NSObject


// Get the state of the board at a point
-(BoardCellState) cellStateAtColumn: (NSInteger) column andRow:(NSInteger)row;

// Sets cell at location
-(void) setCellState:(BoardCellState) state forColumn:(NSInteger) column andRow:(NSInteger) row;


// Sets every cell in board to empty
-(void) clearBoard;

@end

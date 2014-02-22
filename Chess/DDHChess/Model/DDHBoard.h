//
//  DDHBoard.h
//  DDHChess
//
//  Created by Colin Eberhardt and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2014 Dark Desert Highway Softworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoardCellState.h"
#import "DDHMulticastDelegate.h"


/* The Board */
@interface DDHBoard : NSObject

// multicasts changes in cell state. Each delegate is informed of changes in state of individual cells
@property (readonly) DDHMulticastDelegate* boardDelegate;


// Get the state of the board at a point
-(BoardCellState) cellStateAtColumn: (NSInteger) column andRow:(NSInteger)row;

// Sets cell at location
-(void) setCellState:(BoardCellState) state forColumn:(NSInteger) column andRow:(NSInteger) row;


// Sets every cell in board to empty
-(void) clearBoard;

@end

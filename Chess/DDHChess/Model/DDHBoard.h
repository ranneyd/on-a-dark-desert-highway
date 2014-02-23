//
//  DDHBoard.h
//  DDHChess
//
//  Created by Colin Eberhardt and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDHMulticastDelegate.h"
#import "DDHPiece.h"

typedef struct {
    NSInteger* x;
    NSInteger* y;
} Location;

/* The Board */
@interface DDHBoard : NSObject

// multicasts changes in cell state. Each delegate is informed of changes in state of individual cells
@property (readonly) DDHMulticastDelegate* boardDelegate;


// Get the state of the board at a point
-(DDHPiece*) pieceAtColumn: (NSInteger) column andRow:(NSInteger)row;

// Sets cell at location
-(void) putPiece:(DDHPiece*) piece inColumn:(NSInteger) column andRow:(NSInteger) row;


// Sets every cell in board to empty
-(void) clearBoard;

@end

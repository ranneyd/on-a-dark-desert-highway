//
//  DDHBoard.h
//  Chess
//
//  Created by Dustin Kane on 2/13/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDHPiece.h"


@interface DDHBoard : NSObject

@property NSMutableArray *pieces;   //contains DDHPiece objects
@property DDHPiece* board;          //Represents board. Consists of pointers to pieces and nil. Will be two dimensional.
@property int boardWidth;           //every word is taken! Can't do a setWidth if this is just width :(
@property int boardHeight;          //See above

+(id) newBoardOfWidth:(int) width andHeight: (int) height;

-(void) addPiece:(DDHPiece *) piece;            //Adds piece to the board via pieces array
-(BOOL) removePiece:(DDHPiece *) piece;         //Compares the pointer to elements in the pieces array and removes piece when it finds it.
                                                //Returns YES if it finds the piece, NO otherwise
-(DDHPiece*) getPieceAtLoc:(DDHLoc *) position; //Returns pointer to piece at location. Returns nil if nothing there.

@end

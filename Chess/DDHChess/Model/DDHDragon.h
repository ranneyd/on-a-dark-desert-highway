//
//  DDHDragon.h
//  Chess?
//
//  Created by Zakkai Davidson on 4/27/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHPiece.h"

@interface DDHDragon : DDHPiece

// Destroys pieces in adjacent squares after move
-(void) explodeAfterMoveOnBoard: (DDHBoard *) board;

@end

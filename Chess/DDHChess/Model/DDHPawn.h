//
//  DDHPawn.h
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHPiece.h"

@interface DDHPawn : DDHPiece

-(Tuple*) highlightMovesWithBoard:(DDH2DArray *) board;

@end

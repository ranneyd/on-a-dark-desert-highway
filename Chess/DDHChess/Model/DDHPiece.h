//
//  DDHPiece.h
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDHBoard.h"

@interface DDHPiece : NSObject

// This is the board the piece belongs to
@property (readonly) DDHBoard* board;
// This represents which player each piece belongs to
@property (readonly) int player;


@end

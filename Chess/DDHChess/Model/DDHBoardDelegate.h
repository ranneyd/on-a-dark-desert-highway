//
//  DDHBoardDelegate.h
//  DDHChess
//
//  Created by Dustin Kane on 2/18/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChessPlayer.h"
#import "DDHRandomSquare.h"

@protocol DDHBoardDelegate <NSObject>

-(void) pieceChangedAtColumn:(int)column addRow:(int)row;

-(void) explodeAtColumn:(int)column addRow:(int)row;

-(void) rotate;

-(void) randomLandAtColumn:(NSUInteger)column addRow:(NSUInteger)row withSquare:(DDHRandomSquare*) square;

@end

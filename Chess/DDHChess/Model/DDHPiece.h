//
//  DDHPiece.h
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChessPlayer.h"
#import "DDHTuple.h"

@class DDHBoard;

@interface DDHPiece : NSObject

@property NSInteger x;
@property NSInteger y;
@property int index;

-(id) initWithPlayer: (ChessPlayer) player atColumn:(NSUInteger) column andRow:(NSUInteger) row;

// Sets the highlighted array of the board to the places that are moveable by this piece
-(NSMutableArray*) highlightMovesWithBoard:(DDHBoard*) board;

// Changes the x and y properties of this piece
-(void) moveToColumn: (NSInteger) column andRow:(NSInteger)row;

-(ChessPlayer) getPlayer;

-(BOOL) onBoard:(DDHBoard*)board AtColumn:(NSInteger)column andRow:(NSInteger)row;

-(BOOL**) blankHighlightingForBoard:(DDHBoard*) board;

-(NSString*) description;

@end

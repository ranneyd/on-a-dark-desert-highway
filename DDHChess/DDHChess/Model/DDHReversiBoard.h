//
//  DDHReversiBoard.h
//  DDHChess
//
//  Created by Ray Wenderlich and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "DDHBoard.h"

@interface DDHReversiBoard : DDHBoard

// THESE WILL NEED TO BE CHANGED WHEN IMPLEMENTING MORE THAN TWO PLAYERS. MAKE ARRAY?
// ACTUALLY, THESE DON'T REALLY HAVE ANYTHING TO DO WITH CHESS SO...

// White player's score
@property (readonly) NSInteger whiteScore;
// Black player's score
@property (readonly) NSInteger blackScore;


// Sets board to opening positions for Reversi
- (void) setToInitialState;

@end

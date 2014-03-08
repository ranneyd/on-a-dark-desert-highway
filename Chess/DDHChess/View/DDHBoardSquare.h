//
//  DDHBoardSquare.h - A view for a single square of the board
//  DDHChess
//
//  Displays the current state of a piece on the board. This includes
//  showing the correct piece, the color of the background, highlighting
//  possible moves, and any other visual data. Also handles user input.
//  Note that the class adopts the DDHBoardDelgate protocol, allowing other
//  classes to communicate to a DDHBoardSquare through the delegate.
//
//  Created by Dustin Kane, Will Clausen, and Zakkai Davidson on 3/4/14. Adapted from code by Colin Eberhardt.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDHBoard.h"
#import "DDHBoardDelegate.h"

@interface DDHBoardSquare : UIView <DDHBoardDelegate>

// Initialize square at given postion with pointer to the board it belongs to
-(id) initWithFrame:(CGRect) frame column:(NSInteger) column row:(NSInteger)row board:(DDHBoard *)board;

// NOTE: All other communication with DDHBoardSquare is done through the DDHBoardDelegate.
//       This allows all squares to be updated at the same time through a single delegate.
//       See DDHBoardDelegate and DDHMulticastDelegate for more information.
@end


//
//  DDHBoardSquare.h
//  DDHChess
//
//  Created by Dustin Kane, Will Clausen, and Zakkai Davidson on 3/4/14. Adapted from code by Colin Eberhardt.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDHBoard.h"
#import "DDHBoardDelegate.h"

// This class represents the individual squares on the chess board.
@interface DDHBoardSquare : UIView <DDHBoardDelegate>

// Other classes only need to know to create squares and will send messages to squares via board delegates.
-(id) initWithFrame:(CGRect) frame column:(NSInteger) column row:(NSInteger)row board:(DDHBoard *)board;

@end


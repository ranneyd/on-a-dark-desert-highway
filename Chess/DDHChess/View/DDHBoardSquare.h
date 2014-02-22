//
//  DDHBoardSquare.h
//  DDHChess
//
//  Created by Colin Eberhardt and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2014 Dark Desert Highway Softworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDHReversiBoard.h"
#import "DDHBoardDelegate.h"

@interface DDHBoardSquare : UIView <DDHBoardDelegate>

-(id) initWithFrame:(CGRect) frame column:(NSInteger) column row:(NSInteger)row board:(DDHReversiBoard *)board;

@end


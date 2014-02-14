//
//  DDHBoardSquare.h
//  DDHChess
//
//  Created by Ray Wenderlich and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDHReversiBoard.h"

@interface DDHBoardSquare : UIView

-(id) initWithFrame:(CGRect) frame column:(NSInteger) column row:(NSInteger)row board:(DDHReversiBoard *)board;

@end


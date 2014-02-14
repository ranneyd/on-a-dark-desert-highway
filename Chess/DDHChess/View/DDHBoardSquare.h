//
//  SHCBoardSquare.h
//  SHCReversiGame
//
//  Created by Dustin Kane on 2/15/14.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHCReversiBoard.h"

@interface SHCBoardSquare : UIView

-(id) initWithFrame:(CGRect) frame column:(NSInteger) column row:(NSInteger)row board:(SHCReversiBoard *)board;

@end


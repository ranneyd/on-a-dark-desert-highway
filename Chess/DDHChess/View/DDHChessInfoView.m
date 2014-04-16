//
//  DDHChessInfoView.m
//  DDHChess
//
//  Created by Dustin Kane on 4/15/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHChessInfoView.h"

@implementation DDHChessInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setCheck:[[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 160, frame.size.width, 30)]];
        [self setCheck2:[[UILabel alloc] initWithFrame:CGRectMake(0, 100, frame.size.width, 30)]];
        
        
        [[self check] setText:@"Check!"];
        [[self check] setFont:[UIFont fontWithName:@"Trebuchet MS" size:40.0]];
        [[self check] setTextColor:[UIColor blackColor]];
        [[self check] setTextAlignment:NSTextAlignmentCenter];
        
        [[self check2] setText:@"Check!"];
        [[self check2] setFont:[UIFont fontWithName:@"Trebuchet MS" size:40.0]];
        [[self check2] setTextColor:[UIColor blackColor]];
        [[self check2] setTransform:CGAffineTransformMakeRotation( M_PI )];
        [[self check2] setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:[self check]];
        [self addSubview:[self check2]];
        // The DDHChessInfoView should be invisible. The square themselves have the correct colors
        self.backgroundColor = [UIColor clearColor];
    	
    }
    return self;
}


@end

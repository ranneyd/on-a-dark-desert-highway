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
        
        [self setCheck:[[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 50, 250, 50)]];
        
        [[self check] setText:@"Check!"];
        [[self check] setFont:[UIFont fontWithName:@"Trebuchet MS" size:40.0]];
        [[self check] setTextColor:[UIColor whiteColor]];
        
        [self setCheck2:[[UILabel alloc] initWithFrame:CGRectMake(0, 50, 250, 50)]];
        
        [[self check2] setText:@"Check!"];
        [[self check2] setFont:[UIFont fontWithName:@"Trebuchet MS" size:40.0]];
        [[self check2] setTextColor:[UIColor whiteColor]];
        [[self check2] setTransform:CGAffineTransformMakeRotation( M_PI )];
        
        [self addSubview:[self check]];
        [self addSubview:[self check2]];
        // The DDHChessInfoView should be invisible. The square themselves have the correct colors
        self.backgroundColor = [UIColor clearColor];
    
    }
    return self;
}


@end

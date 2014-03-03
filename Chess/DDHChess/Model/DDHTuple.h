//
//  DDHTuple.h
//  DDHChess
//
//  Created by Dustin Kane on 2/27/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import <Foundation/Foundation.h>

// Class used to store location data
@interface DDHTuple : NSObject

@property NSInteger x;
@property NSInteger y;

-(id) initWithX: (NSInteger) x andY:(NSInteger) y;

@end

//
//  DDHRandomChessController.h
//  DDHChess
//
//  Created by CS121 on 4/1/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDHRandomChessController : UIViewController

@property (strong, nonatomic) UILabel *player;
@property (retain, nonatomic) NSString *playerText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andRandom: (BOOL) random;

@end

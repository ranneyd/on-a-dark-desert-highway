//
//  DDHViewController.h
//  DDHChess
//
//  Created by Ray Wenderlich and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2012 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDHViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *blackScore;
@property (weak, nonatomic) IBOutlet UILabel *whiteScore;
@property (weak, nonatomic) IBOutlet UIImageView *gameOverImage;

@end

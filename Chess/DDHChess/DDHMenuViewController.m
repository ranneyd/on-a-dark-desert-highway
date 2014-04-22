//
//  DDHMenuViewController.m
//  Chess?
//
//  Created by Dustin Kane on 4/22/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHMenuViewController.h"
#import "DDHViewController.h"
#import "DDHRandomChessController.h"


@interface DDHMenuViewController ()

@end

@implementation DDHMenuViewController
{
    NSArray *options;
    DDHRandomChessController *parent_;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andParent: (UIViewController *) parent
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        parent_ = (DDHRandomChessController *)parent;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDictionary *defaultPrefs = [NSDictionary dictionaryWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"defaultPrefs" withExtension:@"plist"]];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPrefs];
    //options = [[[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] objectForKey:@"root"] allKeys];
    options = [NSArray arrayWithObjects:@"Quit to Main Menu", @"Enable Scary Music", @"Enable Scary Sound Effects", @"Enable Scary Explosions", @"Highlight Legal Moves", @"Back", nil];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [options count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    NSString *text =[options objectAtIndex:indexPath.row];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if (([text  isEqual: @"Enable Scary Music"] && [settings boolForKey:@"musicOn"]) ||
        ([text  isEqual: @"Enable Scary Sound Effects"] && [settings boolForKey:@"soundEffectsOn"]) ||
        ([text  isEqual: @"Enable Scary Explosions"] && [settings boolForKey:@"explosionsOn"]) ||
        ([text  isEqual: @"Highlight Legal Moves"] && [settings boolForKey:@"highlightingOn"]))
        cell.accessoryType =  UITableViewCellAccessoryCheckmark;
    cell.textLabel.text = text;
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *text = [options objectAtIndex:indexPath.row];
    if ([text isEqualToString:@"Back"]){
        
    }
    else if ([text isEqualToString:@"Quit to Main Menu"]){
        NSLog(@"Quit");
        [parent_ quitView];
        //[self dismissViewControllerAnimated:YES completion:nil];
        //[self presentViewController:[[self parentViewController] parentViewController] animated:YES completion:nil];
    }
    else{
        [selectedCell setAccessoryType: ([selectedCell accessoryType] == UITableViewCellAccessoryNone ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone)];
        NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
        if ([text isEqualToString:@"Enable Scary Music"])
            [settings setBool:![settings boolForKey:@"musicOn"] forKey:@"musicOn"];
        if ([text isEqualToString:@"Enable Scary Sound Effects"])
            [settings setBool:![settings boolForKey:@"soundEffectsOn"] forKey:@"soundEffectsOn"];
        if ([text isEqualToString:@"Enable Scary Explosions"])
            [settings setBool:![settings boolForKey:@"explosionsOn"] forKey:@"explosionsOn"];
        if ([text isEqualToString:@"Highlight Legal Moves"])
            [settings setBool:![settings boolForKey:@"highlightingOn"] forKey:@"highlightingOn"];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

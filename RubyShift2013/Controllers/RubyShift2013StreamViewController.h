//
//  RubyShift2013StreamViewController.h
//  RubyShift2013
//
//  Created by Alex on 8/26/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STTwitterAPI.h"

@interface RubyShift2013StreamViewController : UITableViewController

@property (nonatomic, strong) STTwitterAPI *twitter;
@property (nonatomic, retain) NSArray *twitterStatuses;

@end

//
//  RubyShift2013AgendaViewController.h
//  RubyShift2013
//
//  Created by Alex on 8/26/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RubyShift2013TalksViewController : UITableViewController

@property (nonatomic, strong) NSDate *beginDate;
@property (nonatomic, strong) NSDate *endDate;

- (IBAction)changeDate:(id)sender;

@end

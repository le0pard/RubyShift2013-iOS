//
//  RubyShift2013TalkDetailsViewController.h
//  RubyShift2013
//
//  Created by Alex on 9/11/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Talk.h"
#import "Speaker.h"

@interface RubyShift2013TalkDetailsViewController : UIViewController

@property (nonatomic, strong) Talk *talk;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UILabel *talkTitle;
@property (strong, nonatomic) UILabel *talkDescription;
@property (strong, nonatomic) UILabel *talkTime;
@property (strong, nonatomic) UIButton *speakerFullName;

- (IBAction)speakerPressed:(id)sender;

@end

//
//  RubyShift2013TalkDetailsViewController.m
//  RubyShift2013
//
//  Created by Alex on 9/11/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import "RubyShift2013TalkDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface RubyShift2013TalkDetailsViewController ()

@end

@implementation RubyShift2013TalkDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (self.talk && self.talk.speaker){
        [self.speakerPhoto setImageWithURL:[NSURL URLWithString:[[self.talk speaker] valueForKey:@"speakerPhoto"]]
                            placeholderImage:[UIImage imageNamed:@"speaker.png"]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

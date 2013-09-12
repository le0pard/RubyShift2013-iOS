//
//  RubyShift2013SpeakerDetailsViewController.m
//  RubyShift2013
//
//  Created by Alex on 9/11/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import "RubyShift2013SpeakerDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface RubyShift2013SpeakerDetailsViewController ()

@end

@implementation RubyShift2013SpeakerDetailsViewController

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
    if (self.speaker){
        self.speakerFullName.text = [[self speaker] valueForKey:@"speakerFullName"];
        [self.speakerPhoto setImageWithURL:[NSURL URLWithString:[[self speaker] valueForKey:@"speakerPhoto"]]
                          placeholderImage:[UIImage imageNamed:@"speaker.png"]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

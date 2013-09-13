//
//  RubyShift2013TalkDetailsViewController.m
//  RubyShift2013
//
//  Created by Alex on 9/11/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import "RubyShift2013TalkDetailsViewController.h"
#import "RubyShift2013SpeakerDetailsViewController.h"
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
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    self.speakerFullName = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.talkTitle = [UILabel new];
    self.talkDescription = [UILabel new];
    self.talkTime = [UILabel new];
    
    [self setInfo];
    
    [self.view addSubview:self.scrollView];
}

- (void) setInfo {
    
	// Do any additional setup after loading the view.
    if (self.talk){
        self.title = [[self talk] valueForKey:@"talkTitle"];
        
        // talk title
        self.talkTitle.text = [self.talk valueForKey:@"talkTitle"];
        self.talkTitle.lineBreakMode = NSLineBreakByWordWrapping;
        self.talkTitle.textAlignment = NSTextAlignmentCenter;
        [self.talkTitle setNumberOfLines:2];
        [self.talkTitle setFont:[UIFont systemFontOfSize:20]];
        [self.scrollView addSubview:self.talkTitle];
        
        // talk talkTime
        self.talkTime.text = [self.talk valueForKey:@"talkTimeRange"];
        self.talkTime.textAlignment = NSTextAlignmentCenter;
        [self.talkTime setNumberOfLines:1];
        [self.talkTime setFont:[UIFont systemFontOfSize:14]];
        [self.scrollView addSubview:self.talkTime];
        
        // talk speaker button
        [self.speakerFullName addTarget:self action:@selector(speakerPressed:) forControlEvents:UIControlEventTouchDown];
        [self.speakerFullName setTitle:[[self.talk speaker] valueForKey:@"speakerFullName"] forState:UIControlStateNormal];
        self.speakerFullName.titleLabel.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
        [self.speakerFullName.titleLabel setNumberOfLines:1];
        [self.scrollView addSubview:self.speakerFullName];
        
        //description
        self.talkDescription.lineBreakMode = NSLineBreakByWordWrapping;
        self.talkDescription.text = [self.talk valueForKey:@"talkDescription"];
        [self.talkDescription setNumberOfLines:0];
        [self.talkDescription setFont:[UIFont systemFontOfSize:14]];
        [self.scrollView addSubview:self.talkDescription];
        
    }
    [self setSizeAndPosition];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setSizeAndPosition];
}

- (void) setSizeAndPosition {
    self.talkTitle.frame = CGRectMake(20, 20, self.view.bounds.size.width - 40, 60);
    self.talkTime.frame = CGRectMake(20, 80, 100, 40);
    self.speakerFullName.frame = CGRectMake(140, 80, self.view.bounds.size.width - 160, 40);
    // bio
    CGSize maximumLabelSize = CGSizeMake(self.view.bounds.size.width - 40, FLT_MAX);
    CGSize expectedLabelSize = [self.talkDescription.text sizeWithFont:self.talkDescription.font constrainedToSize:maximumLabelSize lineBreakMode:self.talkDescription.lineBreakMode];
    CGFloat height = 140.0;
    self.talkDescription.frame = CGRectMake(20, height, self.view.bounds.size.width - 40, expectedLabelSize.height);
    height = height + expectedLabelSize.height;
    // scroll
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, height + 20);
}

- (IBAction)speakerPressed:(id)sender {
    [self performSegueWithIdentifier:@"speakerPressed" sender:sender];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"speakerPressed"]){
        RubyShift2013SpeakerDetailsViewController *sdv = [segue destinationViewController];
        sdv.speaker = self.talk.speaker;
    }
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self setSizeAndPosition];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

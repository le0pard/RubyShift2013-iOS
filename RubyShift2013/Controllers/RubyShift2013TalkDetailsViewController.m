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
    
    CGFloat fontSize = 14.0;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        fontSize = 20.0;
    }
    
	// Do any additional setup after loading the view.
    if (self.talk){
        self.title = [[self talk] valueForKey:@"talkTitle"];
        
        // talk title
        self.talkTitle.text = [self.talk valueForKey:@"talkTitle"];
        self.talkTitle.lineBreakMode = NSLineBreakByWordWrapping;
        self.talkTitle.textAlignment = NSTextAlignmentCenter;
        [self.talkTitle setNumberOfLines:2];
        [self.talkTitle setFont:[UIFont systemFontOfSize:fontSize + 6]];
        [self.scrollView addSubview:self.talkTitle];
        
        // talk talkTime
        self.talkTime.text = [self.talk valueForKey:@"talkTimeRange"];
        self.talkTime.textAlignment = NSTextAlignmentCenter;
        [self.talkTime setNumberOfLines:1];
        [self.talkTime setFont:[UIFont systemFontOfSize:fontSize]];
        [self.scrollView addSubview:self.talkTime];
        
        // talk speaker button
        if ([self.navigationController.viewControllers count] < 3){
            [self.speakerFullName addTarget:self action:@selector(speakerPressed:) forControlEvents:UIControlEventTouchDown];
            [self.speakerFullName setTitle:[[self.talk speaker] valueForKey:@"speakerFullName"] forState:UIControlStateNormal];
            self.speakerFullName.titleLabel.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
            [self.speakerFullName.titleLabel setNumberOfLines:1];
            [self.speakerFullName.titleLabel setFont:[UIFont systemFontOfSize:fontSize + 2]];
            [self.scrollView addSubview:self.speakerFullName];
        }
        
        //description
        self.talkDescription.lineBreakMode = NSLineBreakByWordWrapping;
        self.talkDescription.text = [self.talk valueForKey:@"talkDescription"];
        [self.talkDescription setNumberOfLines:0];
        [self.talkDescription setFont:[UIFont systemFontOfSize:fontSize]];
        [self.scrollView addSubview:self.talkDescription];
        
    }
    //[self setSizeAndPosition];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setSizeAndPosition];
}

- (void) setSizeAndPosition {
    CGFloat sizePadding = 100;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        sizePadding = 200;
    }
    
    CGFloat topFloat = 60;
    
    self.talkTitle.frame = CGRectMake(20, topFloat, self.view.bounds.size.width - 40, 60);
    self.talkTime.frame = CGRectMake(20, topFloat + 60, sizePadding, 40);
    self.speakerFullName.frame = CGRectMake(sizePadding + 40, topFloat + 60, self.view.bounds.size.width - sizePadding - 60, 40);
    // bio
    CGSize maximumLabelSize = CGSizeMake(self.view.bounds.size.width - 40, FLT_MAX);
    CGSize expectedLabelSize = [self.talkDescription.text sizeWithFont:self.talkDescription.font constrainedToSize:maximumLabelSize lineBreakMode:self.talkDescription.lineBreakMode];
    CGFloat height = topFloat + 120;
    self.talkDescription.frame = CGRectMake(20, height, self.view.bounds.size.width - 40, expectedLabelSize.height);
    height = height + expectedLabelSize.height;
    // scroll
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, height + 60);
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

//
//  RubyShift2013SpeakerDetailsViewController.m
//  RubyShift2013
//
//  Created by Alex on 9/11/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import "RubyShift2013SpeakerDetailsViewController.h"
#import "RubyShift2013TalkDetailsViewController.h"
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
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    self.speakerPhoto = [UIImageView new];
    self.speakerFullName = [UILabel new];
    self.speakerBio = [UILabel new];
    
    [self setInfo];
    
    [self.view addSubview:self.scrollView];
}

- (void) setInfo {
    
	// Do any additional setup after loading the view.
    if (self.speaker){
        
        self.title = [[self speaker] valueForKey:@"speakerFullName"];
        
        // full name
        self.speakerFullName.text = [[self speaker] valueForKey:@"speakerFullName"];
        self.speakerFullName.lineBreakMode = NSLineBreakByWordWrapping;
        self.speakerFullName.textAlignment = NSTextAlignmentCenter;
        [self.speakerFullName setNumberOfLines:3];
        [self.speakerFullName setFont:[UIFont systemFontOfSize:20]];
        [self.scrollView addSubview:self.speakerFullName];
        
        // photo
        [self.speakerPhoto setImageWithURL:[NSURL URLWithString:[[self speaker] valueForKey:@"speakerPhoto"]]
                          placeholderImage:[UIImage imageNamed:@"speaker.png"]];
        [self.speakerPhoto setContentMode:UIViewContentModeScaleAspectFit];
        [self.scrollView addSubview:self.speakerPhoto];
        
        //talks
        NSUInteger index = 0;
        NSMutableArray *tmpArray = [NSMutableArray new];
        for (Talk *talk in self.speaker.talks) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.tag = index;
            index++;
            [button addTarget:self action:@selector(talkPressed:) forControlEvents:UIControlEventTouchDown];
            [button setTitle:[talk valueForKey:@"talkTitle"] forState:UIControlStateNormal];
            button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
            [button.titleLabel setNumberOfLines:1];
            [tmpArray addObject:button];
        }
        
        self.talkButtons = [[NSArray alloc] initWithArray:tmpArray];
        for (UIButton *button in self.talkButtons){
            [self.scrollView addSubview:button];
        }
        
        //bio
        self.speakerBio.lineBreakMode = NSLineBreakByWordWrapping;
        self.speakerBio.text = [[self speaker] valueForKey:@"speakerBio"];
        [self.speakerBio setNumberOfLines:0];
        [self.speakerBio setFont:[UIFont systemFontOfSize:14]];
        [self.scrollView addSubview:self.speakerBio];

    }
    [self setSizeAndPosition];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setSizeAndPosition];
}

- (void) setSizeAndPosition {
    self.speakerFullName.frame = CGRectMake(20, 20, self.view.bounds.size.width - 40, 30);
    self.speakerPhoto.frame = CGRectMake(20, 50, 120, 120);
    // talk buttons
    CGFloat butHeight = 0.0;
    for (UIButton *button in self.talkButtons){
        button.frame = CGRectMake(150, 50 + butHeight, self.view.bounds.size.width - 170, 30);
        butHeight = butHeight + 40;
    }
    // bio
    CGSize maximumLabelSize = CGSizeMake(self.view.bounds.size.width - 40, FLT_MAX);
    CGSize expectedLabelSize = [self.speakerBio.text sizeWithFont:self.speakerBio.font constrainedToSize:maximumLabelSize lineBreakMode:self.speakerBio.lineBreakMode];
    CGFloat height = 180.0;
    self.speakerBio.frame = CGRectMake(20, height, self.view.bounds.size.width - 40, expectedLabelSize.height);
    height = height + expectedLabelSize.height;
    // scroll
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, height + 20);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self setSizeAndPosition];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)talkPressed:(id)sender {
    [self performSegueWithIdentifier:@"talkPressed" sender:sender];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"talkPressed"]){
        UIButton *button = (UIButton *)sender;
        RubyShift2013TalkDetailsViewController *tdv = [segue destinationViewController];
        tdv.talk = [[[self.speaker talks] allObjects] objectAtIndex:[button tag]];
    }
}


@end

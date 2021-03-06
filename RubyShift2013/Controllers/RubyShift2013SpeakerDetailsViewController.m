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
    
    CGFloat fontSize = 14.0;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        fontSize = 20.0;
    }
    
	// Do any additional setup after loading the view.
    if (self.speaker){
        
        self.title = [[self speaker] valueForKey:@"speakerFullName"];
        
        // full name
        self.speakerFullName.text = [[self speaker] valueForKey:@"speakerFullName"];
        self.speakerFullName.lineBreakMode = NSLineBreakByWordWrapping;
        self.speakerFullName.textAlignment = NSTextAlignmentCenter;
        [self.speakerFullName setNumberOfLines:3];
        [self.speakerFullName setFont:[UIFont systemFontOfSize:fontSize + 4]];
        [self.scrollView addSubview:self.speakerFullName];
        
        // photo
        [self.speakerPhoto setImageWithURL:[NSURL URLWithString:[[self speaker] valueForKey:@"speakerPhoto"]]
                          placeholderImage:[UIImage imageNamed:@"speaker_icon.png"]];
        [self.speakerPhoto setContentMode:UIViewContentModeScaleAspectFit];
        [self.scrollView addSubview:self.speakerPhoto];
        
        //talks
        NSUInteger index = 0;
        NSMutableArray *tmpArray = [NSMutableArray new];
        if ([self.navigationController.viewControllers count] < 3){
            for (Talk *talk in self.speaker.talks) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                button.tag = index;
                index++;
                [button addTarget:self action:@selector(talkPressed:) forControlEvents:UIControlEventTouchDown];
                [button setTitle:[talk valueForKey:@"talkTitle"] forState:UIControlStateNormal];
                button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
                [button.titleLabel setNumberOfLines:1];
                [button.titleLabel setFont:[UIFont systemFontOfSize:fontSize + 2]];
                [tmpArray addObject:button];
            }
        }
        
        self.talkButtons = [[NSArray alloc] initWithArray:tmpArray];
        for (UIButton *button in self.talkButtons){
            [self.scrollView addSubview:button];
        }
        
        //bio
        self.speakerBio.lineBreakMode = NSLineBreakByWordWrapping;
        self.speakerBio.text = [[self speaker] valueForKey:@"speakerBio"];
        [self.speakerBio setNumberOfLines:0];
        [self.speakerBio setFont:[UIFont systemFontOfSize:fontSize]];
        [self.scrollView addSubview:self.speakerBio];

    }
    //[self setSizeAndPosition];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setSizeAndPosition];
}

- (void) setSizeAndPosition {
    CGFloat topFloat = 60;
    
    self.speakerFullName.frame = CGRectMake(20, topFloat, self.view.bounds.size.width - 40, 30);
    self.speakerPhoto.frame = CGRectMake(20, topFloat + 30, 120, 120);
    // talk buttons
    if ([self.talkButtons count] > 0){
        CGFloat butHeight = topFloat;
        for (UIButton *button in self.talkButtons){
            button.frame = CGRectMake(150, 50 + butHeight, self.view.bounds.size.width - 170, 30);
            butHeight = butHeight + 40;
        }
    }
    // bio
    CGSize maximumLabelSize = CGSizeMake(self.view.bounds.size.width - 40, FLT_MAX);
    CGSize expectedLabelSize = [self.speakerBio.text sizeWithFont:self.speakerBio.font constrainedToSize:maximumLabelSize lineBreakMode:self.speakerBio.lineBreakMode];
    CGFloat height = topFloat + 160.0;
    self.speakerBio.frame = CGRectMake(20, height, self.view.bounds.size.width - 40, expectedLabelSize.height);
    height = height + expectedLabelSize.height;
    // scroll
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, height + 60);
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

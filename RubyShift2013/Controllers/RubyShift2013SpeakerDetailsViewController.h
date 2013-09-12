//
//  RubyShift2013SpeakerDetailsViewController.h
//  RubyShift2013
//
//  Created by Alex on 9/11/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Speaker.h"
#import "Talk.h"

@interface RubyShift2013SpeakerDetailsViewController : UIViewController

@property (nonatomic, strong) Speaker *speaker;
@property (strong, nonatomic) IBOutlet UILabel *speakerFullName;
@property (strong, nonatomic) IBOutlet UIImageView *speakerPhoto;

@end

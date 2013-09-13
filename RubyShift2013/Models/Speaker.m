//
//  Speaker.m
//  RubyShift2013
//
//  Created by Alex on 9/11/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import "Speaker.h"
#import "Talk.h"


@implementation Speaker

@dynamic id;
@dynamic speakerBio;
@dynamic speakerFullName;
@dynamic speakerPhoto;
@dynamic speakerThumb;
@dynamic isFullDeleted;
@dynamic talks;

- (NSString *)talksTitle {
    NSMutableString *result = [NSMutableString stringWithString:@""];
    for (Talk *talk in self.talks) {
        [result appendFormat:@"%@ ", [talk valueForKey:@"talkTitle"]];
    }
    return result;
}

@end

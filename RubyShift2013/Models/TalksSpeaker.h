//
//  TalksSpeaker.h
//  RubyShift2013
//
//  Created by Alex on 9/1/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Speaker, Talk;

@interface TalksSpeaker : NSManagedObject

@property (nonatomic, retain) Speaker *speaker;
@property (nonatomic, retain) Talk *talk;

@end

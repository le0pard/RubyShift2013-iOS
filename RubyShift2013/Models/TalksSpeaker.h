//
//  TalksSpeaker.h
//  RubyShift2013
//
//  Created by Alex on 8/26/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TalksSpeaker : NSManagedObject

@property (nonatomic, retain) NSManagedObject *talk;
@property (nonatomic, retain) NSManagedObject *speaker;

@end

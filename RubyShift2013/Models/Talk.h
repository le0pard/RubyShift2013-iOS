//
//  Talk.h
//  RubyShift2013
//
//  Created by Alex on 9/11/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Speaker;

@interface Talk : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSDate * talkDate;
@property (nonatomic, retain) NSString * talkDescription;
@property (nonatomic, retain) NSString * talkTitle;
@property (nonatomic, retain) NSString * talkTimeRange;
@property (nonatomic, retain) Speaker *speaker;

@end

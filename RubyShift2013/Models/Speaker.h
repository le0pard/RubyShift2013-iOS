//
//  Speaker.h
//  RubyShift2013
//
//  Created by Alex on 9/1/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TalksSpeaker;

@interface Speaker : NSManagedObject

@property (nonatomic, retain) NSString * bio;
@property (nonatomic, retain) NSString * full_name;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * photo;
@property (nonatomic, retain) NSSet *talks;
@end

@interface Speaker (CoreDataGeneratedAccessors)

- (void)addTalksObject:(TalksSpeaker *)value;
- (void)removeTalksObject:(TalksSpeaker *)value;
- (void)addTalks:(NSSet *)values;
- (void)removeTalks:(NSSet *)values;

@end

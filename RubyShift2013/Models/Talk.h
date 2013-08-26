//
//  Talk.h
//  RubyShift2013
//
//  Created by Alex on 8/26/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TalksSpeaker;

@interface Talk : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * talkDescription;
@property (nonatomic, retain) NSSet *speakers;
@property (nonatomic, retain) NSManagedObject *agenda;
@end

@interface Talk (CoreDataGeneratedAccessors)

- (void)addSpeakersObject:(TalksSpeaker *)value;
- (void)removeSpeakersObject:(TalksSpeaker *)value;
- (void)addSpeakers:(NSSet *)values;
- (void)removeSpeakers:(NSSet *)values;

@end

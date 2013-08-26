//
//  Agenda.h
//  RubyShift2013
//
//  Created by Alex on 8/26/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Talk;

@interface Agenda : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSSet *talks;
@end

@interface Agenda (CoreDataGeneratedAccessors)

- (void)addTalksObject:(Talk *)value;
- (void)removeTalksObject:(Talk *)value;
- (void)addTalks:(NSSet *)values;
- (void)removeTalks:(NSSet *)values;

@end

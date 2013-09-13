//
//  Speaker.h
//  RubyShift2013
//
//  Created by Alex on 9/11/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Talk;

@interface Speaker : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * speakerBio;
@property (nonatomic, retain) NSString * speakerFullName;
@property (nonatomic, retain) NSString * speakerPhoto;
@property (nonatomic, retain) NSString * speakerThumb;
@property (nonatomic, retain) NSNumber * isFullDeleted;
@property (nonatomic, retain) NSSet *talks;

- (NSString *)talksTitle;

@end

@interface Speaker (CoreDataGeneratedAccessors)

- (void)addTalksObject:(Talk *)value;
- (void)removeTalksObject:(Talk *)value;
- (void)addTalks:(NSSet *)values;
- (void)removeTalks:(NSSet *)values;

@end

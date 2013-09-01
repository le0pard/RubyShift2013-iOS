//
//  Speaker.h
//  RubyShift2013
//
//  Created by Alex on 9/1/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Talk;

@interface Speaker : NSManagedObject

@property (nonatomic, retain) NSString * speakerBio;
@property (nonatomic, retain) NSString * speakerFullName;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * speakerPhoto;
@property (nonatomic, retain) NSString * speakerThumb;
@property (nonatomic, retain) Talk *talk;

@end

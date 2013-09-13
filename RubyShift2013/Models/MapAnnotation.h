//
//  MapAnnotation.h
//  RubyShift2013
//
//  Created by Alex on 9/13/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MapAnnotation : NSManagedObject

@property (nonatomic, retain) NSString * annotIcon;
@property (nonatomic, retain) NSString * annotSubtitle;
@property (nonatomic, retain) NSString * annotTitle;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSNumber * lng;
@property (nonatomic, retain) NSNumber * isFullDeleted;

@end

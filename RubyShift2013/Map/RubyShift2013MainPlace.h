//
//  RubyShift2013MainPlace.h
//  RubyShift2013
//
//  Created by Alex on 9/12/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface RubyShift2013MainPlace : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;

// Title and subtitle for use by selection UI.
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (weak, nonatomic) NSString *icon;

@end

//
//  RubyShift2013PartyPlace.h
//  RubyShift2013
//
//  Created by Alex on 9/13/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface RubyShift2013PartyPlace : NSObject <MKAnnotation>

@property CLLocationCoordinate2D coordinate;

@property (weak, nonatomic) NSString *title;
@property (weak, nonatomic) NSString *subtitle;

@end

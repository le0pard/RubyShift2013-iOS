//
//  RubyShift2013MapViewController.h
//  RubyShift2013
//
//  Created by Alex on 9/12/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface RubyShift2013MapViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

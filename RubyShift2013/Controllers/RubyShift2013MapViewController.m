//
//  RubyShift2013MapViewController.m
//  RubyShift2013
//
//  Created by Alex on 9/12/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import "RubyShift2013MapViewController.h"
#import "RubyShift2013MainPlace.h"
#import "RubyShift2013PartyPlace.h"

@interface RubyShift2013MapViewController ()

@end

@implementation RubyShift2013MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"Map", nil);
    
    self.mapView.delegate = self;
    
    CLLocationCoordinate2D mainCoordinate = CLLocationCoordinate2DMake(50.451662, 30.522117);
    
    CLLocationDistance regionWidth  = 1500;
    CLLocationDistance regionHeight = 1500;
    
    MKCoordinateRegion startRegion = MKCoordinateRegionMakeWithDistance(mainCoordinate, regionWidth, regionHeight);
    [self.mapView setRegion:startRegion animated:YES];
    
    self.mapView.showsUserLocation = YES;
    
    RubyShift2013MainPlace *mainPlace = [[RubyShift2013MainPlace alloc] init];
    mainPlace.coordinate = mainCoordinate;
    mainPlace.title = @"Conference Place";
    mainPlace.subtitle = @"Hotel Kozatskiy, 1/3 Myhailivska Street";
    [self.mapView addAnnotation:mainPlace];
    
    RubyShift2013PartyPlace *partyPlace = [[RubyShift2013PartyPlace alloc] init];
    partyPlace.coordinate = CLLocationCoordinate2DMake(50.440127, 30.519450);
    partyPlace.title = @"Party Place";
    partyPlace.subtitle = @"Lucky Pub, Rohnidyns'ka street";
    [self.mapView addAnnotation:partyPlace];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *AnnoIdentifier = @"AnnotationView";
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    MKAnnotationView *view = [self.mapView dequeueReusableAnnotationViewWithIdentifier:AnnoIdentifier];
    if (!view) {
        view = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnoIdentifier];
    }
    
    if ([annotation isKindOfClass:[RubyShift2013MainPlace class]]) {
        view.image = [UIImage imageNamed:@"main_place.png"];
    } else {
        view.image = [UIImage imageNamed:@"party_place.png"];
    }
    view.canShowCallout = YES;
    
    return view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

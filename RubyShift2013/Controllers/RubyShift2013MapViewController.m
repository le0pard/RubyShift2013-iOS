//
//  RubyShift2013MapViewController.m
//  RubyShift2013
//
//  Created by Alex on 9/12/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "RubyShift2013MapViewController.h"
#import "RubyShift2013MainPlace.h"
#import "MapAnnotation.h"

@interface RubyShift2013MapViewController()
@end

@implementation RubyShift2013MapViewController

- (void)refetchData {
    [_fetchedResultsController performSelectorOnMainThread:@selector(performFetch:) withObject:nil waitUntilDone:YES modes:@[ NSRunLoopCommonModes ]];
}


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
    self.mapView.showsUserLocation = YES;
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"MapAnnotation"];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"id" ascending:YES]];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"isFullDeleted == %@", [NSNumber numberWithBool:NO]]];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[(id)[[UIApplication sharedApplication] delegate] managedObjectContext] sectionNameKeyPath:nil cacheName:@"MapAnnotations"];
    _fetchedResultsController.delegate = self;
    
    [self refetchData];
    
    [self updatedAnnotations];
    
    // refresh button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                           target:self
                                                                                           action:@selector(refetchData)];
}

- (void) updatedAnnotations {
    
    if ([self.mapView.annotations count] > 0){
        [self.mapView removeAnnotations:self.mapView.annotations];
    }
    
    NSArray *fetchedData = [_fetchedResultsController fetchedObjects];
    
    NSMutableArray *lats = [NSMutableArray new];
    NSMutableArray *lngs = [NSMutableArray new];
    
    for (MapAnnotation *annot in fetchedData){
        RubyShift2013MainPlace *mainPlace = [RubyShift2013MainPlace new];
        mainPlace.coordinate = CLLocationCoordinate2DMake([[annot lat] doubleValue], [[annot lng] doubleValue]);
        mainPlace.title = [annot annotTitle];
        mainPlace.subtitle = [annot annotSubtitle];
        mainPlace.icon = [annot annotIcon];
        [self.mapView addAnnotation:mainPlace];
        
        [lats addObject:[NSNumber numberWithDouble:[[annot lat] doubleValue]]];
        [lngs addObject:[NSNumber numberWithDouble:[[annot lng] doubleValue]]];
    }
    
    [lats sortUsingSelector:@selector(compare:)];
    [lngs sortUsingSelector:@selector(compare:)];

    if ([lats count] > 0 && [lngs count] > 0) {
        double smallestLat = [lats[0] doubleValue];
        double smallestLng = [lngs[0] doubleValue];
        double biggestLat  = [[lats lastObject] doubleValue];
        double biggestLng  = [[lngs lastObject] doubleValue];
        
        CLLocationCoordinate2D annotationsCenter = CLLocationCoordinate2DMake((biggestLat + smallestLat) / 2, (biggestLng + smallestLng) / 2);
        MKCoordinateSpan annotationsSpan = MKCoordinateSpanMake((biggestLat - smallestLat), (biggestLng - smallestLng));
        MKCoordinateRegion region = MKCoordinateRegionMake(annotationsCenter, annotationsSpan);
        [self.mapView setRegion:region];
    }
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
        RubyShift2013MainPlace *rannot = (RubyShift2013MainPlace *)annotation;
        if ([rannot icon] && [[rannot icon] length] > 0){
            view.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_place.png", [rannot icon]]];
        }
        
        UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        view.rightCalloutAccessoryView = infoButton;
    }
    view.canShowCallout = YES;
    
    return view;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    if ([control isKindOfClass:[UIButton class]] && [view.annotation isKindOfClass:[RubyShift2013MainPlace class]]) {
        RubyShift2013MainPlace *annot = (RubyShift2013MainPlace *)view.annotation;
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:annot.coordinate
                                                       addressDictionary:nil];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        mapItem.name = [NSString stringWithFormat:@"%@, %@", [annot title], [annot subtitle]];
        [mapItem openInMapsWithLaunchOptions:@{MKLaunchOptionsShowsTrafficKey: @YES, MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking}];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self updatedAnnotations];
}

@end

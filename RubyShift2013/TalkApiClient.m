//
//  AgendaApiClient.m
//  RubyShift2013
//
//  Created by Alex on 8/26/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import "TalkApiClient.h"

static NSString * const kAFIncrementalStoreAPIBaseURLString = @"http://rubyshift2013.herokuapp.com/api/v1";

@implementation TalkApiClient

+ (TalkApiClient *)sharedClient {
    static TalkApiClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kAFIncrementalStoreAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

#pragma mark - AFIncrementalStore

- (NSURLRequest *)requestForFetchRequest:(NSFetchRequest *)fetchRequest
                             withContext:(NSManagedObjectContext *)context
{
    NSMutableURLRequest *mutableURLRequest = nil;
    if ([fetchRequest.entityName isEqualToString:@"Talk"]) {
        mutableURLRequest = [self requestWithMethod:@"GET" path:@"talks" parameters:nil];
    } else if ([fetchRequest.entityName isEqualToString:@"Speaker"]) {
        mutableURLRequest = [self requestWithMethod:@"GET" path:@"speakers" parameters:nil];
    }
    
    return mutableURLRequest;
}


- (NSDictionary *)attributesForRepresentation:(NSDictionary *)representation
                                     ofEntity:(NSEntityDescription *)entity
                                 fromResponse:(NSHTTPURLResponse *)response
{
    NSMutableDictionary *mutablePropertyValues = [[super attributesForRepresentation:representation ofEntity:entity fromResponse:response] mutableCopy];
    
    if ([entity.name isEqualToString:@"Talk"]) {
        [mutablePropertyValues setValue:[NSNumber numberWithInteger:[[representation valueForKey:@"id"] integerValue]] forKey:@"id"];
        [mutablePropertyValues setValue:[representation valueForKey:@"title"] forKey:@"talkTitle"];
        [mutablePropertyValues setValue:[representation valueForKey:@"description"] forKey:@"talkDescription"];
        [mutablePropertyValues setValue:[representation valueForKey:@"time_range"] forKey:@"talkTimeRange"];
        [mutablePropertyValues setValue:[[NSValueTransformer valueTransformerForName:TTTISO8601DateTransformerName] reverseTransformedValue:[representation valueForKey:@"date"]] forKey:@"talkDate"];
    } else if ([entity.name isEqualToString:@"Speaker"]) {
        [mutablePropertyValues setValue:[NSNumber numberWithInteger:[[representation valueForKey:@"id"] integerValue]] forKey:@"id"];
        [mutablePropertyValues setValue:[representation valueForKey:@"full_name"] forKey:@"speakerFullName"];
        [mutablePropertyValues setValue:[representation valueForKey:@"bio"] forKey:@"speakerBio"];
        [mutablePropertyValues setValue:[representation valueForKey:@"photo"] forKey:@"speakerPhoto"];
    }
    
    return mutablePropertyValues;
}

- (BOOL)shouldFetchRemoteAttributeValuesForObjectWithID:(NSManagedObjectID *)objectID
                                 inManagedObjectContext:(NSManagedObjectContext *)context
{
    return NO;
}

- (BOOL)shouldFetchRemoteValuesForRelationship:(NSRelationshipDescription *)relationship
                               forObjectWithID:(NSManagedObjectID *)objectID
                        inManagedObjectContext:(NSManagedObjectContext *)context
{
    return NO;
}




@end

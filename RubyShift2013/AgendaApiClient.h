//
//  AgendaApiClient.h
//  RubyShift2013
//
//  Created by Alex on 8/26/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import "AFRESTClient.h"

@interface AgendaApiClient : AFRESTClient <AFIncrementalStoreHTTPClient>

+ (AgendaApiClient *)sharedClient;

@end

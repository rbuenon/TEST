//
//  ApiAccess.h
//  AFTest
//
//  Created by Ruben on 2/24/13.
//  Copyright (c) 2013 Ruben. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPClient.h>
#import <AFJSONRequestOperation.h>

#import "Colour.h"


typedef void(^ErrorBlock)(NSError *error);
typedef void(^SuccessBlock)(NSArray *objects);

@interface ApiAccess : AFHTTPClient

+(ApiAccess*)sharedClient;

-(void)getColours:(SuccessBlock)successBlock onFail:(ErrorBlock)errorBlock;


@end

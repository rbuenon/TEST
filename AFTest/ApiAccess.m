//
//  ApiAccess.m
//  AFTest
//
//  Created by Ruben on 2/24/13.
//  Copyright (c) 2013 Ruben. All rights reserved.
//

#import "ApiAccess.h"



static NSString * const kApiAccessBaseURL =  @"http://localhost:4567";

@implementation ApiAccess {
    
}


+(ApiAccess*)sharedClient {
    static ApiAccess *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ApiAccess alloc]initWithBaseURL:[NSURL URLWithString:kApiAccessBaseURL]];
    });
    
    return _sharedClient;
    
}

-(id)initWithBaseURL:(NSURL*)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
    
}

-(void)getColours:(SuccessBlock)successBlock onFail:(ErrorBlock)errorBlock {
    
    ApiAccess *api = [ApiAccess sharedClient];
    

    
    NSLog(@"doing request from api");
    [api getPath:@"colours" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){

        successBlock([self mapColours:responseObject]);
    
    }
     
         failure:^(AFHTTPRequestOperation *operation, NSError *error){
             NSLog(@"error: \n%@", error.localizedDescription);
         
             errorBlock(error);
         }];
    
    
}

-(NSArray*)mapColours:(NSDictionary*)dict {
    NSMutableArray * array = [NSMutableArray new];
    
    NSArray *c = [dict objectForKey:@"coloursArray"];
    
    for (NSDictionary *d in c) {
        Colour *col = [Colour new];
        col.name = [d objectForKey:@"colourName"];
        col.hexValue = [d objectForKey:@"hexValue"];
        [array addObject:col];
    }
    
    return  array;
}


@end

//
//  ViewController.m
//  AFTest
//
//  Created by Ruben on 2/23/13.
//  Copyright (c) 2013 Ruben. All rights reserved.
//

#import "ViewController.h"
//#import <AFNetworking/AFNetworking.h>
#import "ApiAccess.h"

@interface ViewController () {
    ApiAccess *api;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    api = [ApiAccess sharedClient];
    
    NSLog(@"getting colours");
    [api getColours:^(NSArray *objects){
        NSLog(@"%@", objects);
        [self printColours:objects];
        
    } onFail:^(NSError *error){
        NSLog(@"%@", error.localizedDescription);
    }];
    


    
   // [self testAF];

}

-(void)printColours:(NSArray*)colours {
    float h = self.view.frame.size.height/colours.count;
    
    for (int i=0; i<colours.count; i++) {
        Colour *c = colours[i];
        CGRect r = CGRectMake(0, i*h, self.view.frame.size.width, h);
        
        UILabel *l = [[UILabel alloc]initWithFrame:r];
        [l setText:c.name];
        
        [self.view addSubview:l];
    }
    
}


//-(void)testAF {
//    
//    NSURL * url = [NSURL URLWithString:@"https://alpha-api.app.net/stream/0/posts/stream/global"];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//        
//        NSLog(@"IP Adress: %@", [JSON valueForKeyPath:@"origin"]);
//        
//        
//        NSLog(@"the whole json: \n%@", JSON);
//        
//    }failure:nil];
//    
//
//    [operation start];
//}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

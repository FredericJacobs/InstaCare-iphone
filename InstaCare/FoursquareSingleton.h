//
//  FoursquareSingleton.h
//  InstaCare
//
//  Created by Frederic Jacobs on 29/9/12.
//  Copyright (c) 2012 Frederic Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BZFoursquare.h"
#import "CategoryViewController.h"

@interface FoursquareSingleton : NSObject< BZFoursquareRequestDelegate, BZFoursquareSessionDelegate>{
    BZFoursquare        *foursquare_;
    BZFoursquareRequest *request_;
    NSDictionary        *meta_;
    NSArray             *notifications_;
    NSDictionary        *response_;
    CategoryViewController *delegate;
}

@property(nonatomic,readwrite,strong) BZFoursquare *foursquare;
@property(nonatomic,strong) BZFoursquareRequest *request;
@property(nonatomic,copy) NSDictionary *meta;
@property(nonatomic,copy) NSArray *notifications;
@property(nonatomic,copy) NSDictionary *response;

- (void)setTheDelegate:(CategoryViewController*)aDelegate;
- (void)searchVenuesAtLocation:(NSString*)ll AndWithCategory:(NSString*)string;

+ (id)sharedManager;

@end

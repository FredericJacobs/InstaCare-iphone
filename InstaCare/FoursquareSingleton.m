//
//  FoursquareSingleton.m
//  InstaCare
//
//  Created by Frederic Jacobs on 29/9/12.
//  Copyright (c) 2012 Frederic Jacobs. All rights reserved.
//

#import "FoursquareSingleton.h"

#define kClientID       YOU_NEED_AN_APIKEY
#define kCallbackURL    @"instacare://foursquare"

@implementation FoursquareSingleton
@synthesize foursquare = foursquare_;
@synthesize request = request_;
@synthesize meta = meta_;
@synthesize notifications = notifications_;
@synthesize response = response_;

+ (id)sharedManager {
    static FoursquareSingleton *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (void)setTheDelegate:(CategoryViewController*)aDelegate{
    
    delegate = aDelegate;
}

- (void)searchVenuesAtLocation:(NSString*)ll AndWithCategory:(NSString*)string {
    [self prepareForRequest];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:ll, @"ll", string, @"categoryId", nil];
    self.request = [foursquare_ requestWithPath:@"venues/search" HTTPMethod:@"GET" parameters:parameters delegate:self];
    [request_ start];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (id)init {
    if (self = [super init]) {
        self.foursquare = [[BZFoursquare alloc] initWithClientID:kClientID callbackURL:kCallbackURL];
        foursquare_.version = @"20111119";
        foursquare_.locale = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
        foursquare_.sessionDelegate = self;
    }
    return self;
}

- (void)prepareForRequest {
    [self cancelRequest];
    self.meta = nil;
    self.notifications = nil;
    self.response = nil;
}

- (void)cancelRequest {
    if (request_) {
        request_.delegate = nil;
        [request_ cancel];
        self.request = nil;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

- (void)requestDidFinishLoading:(BZFoursquareRequest *)request {
    self.meta = request.meta;
    self.notifications = request.notifications;
    self.response = request.response;
    self.request = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [delegate updateViewWithDictionary:response_];
}

- (void)request:(BZFoursquareRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, error);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[[error userInfo] objectForKey:@"errorDetail"] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
    [alertView show];
    self.meta = request.meta;
    self.notifications = request.notifications;
    self.response = request.response;
    self.request = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


@end

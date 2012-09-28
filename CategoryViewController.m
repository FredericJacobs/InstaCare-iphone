//
//  CategoryViewController.m
//  InstaCare
//
//  Created by Frederic Jacobs on 28/9/12.
//  Copyright (c) 2012 Frederic Jacobs. All rights reserved.
//
#import "AppDelegate.h"
#import "CategoryViewController.h"

@interface CategoryViewController ()

@property(nonatomic,readwrite,strong) BZFoursquare *foursquare;
@property(nonatomic,strong) BZFoursquareRequest *request;
@property(nonatomic,copy) NSDictionary *meta;
@property(nonatomic,copy) NSArray *notifications;
@property(nonatomic,copy) NSDictionary *response;
@end

@implementation CategoryViewController
@synthesize foursquare = foursquare_;
@synthesize request = request_;
@synthesize meta = meta_;
@synthesize notifications = notifications_;
@synthesize response = response_;
@synthesize mapView, venuesTableView, medicalCategory, navigationBar;

#define kClientID       @"01K3AD3H0Q5P31JOQBPKNSAGT4QIDEUJY1Q34BKQGYC54J0W"
#define kCallbackURL    @"instacare://foursquare"

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil AndMedicalCategory:(MedicalCategory*)category
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        medicalCategory = category;
        locationSet = FALSE;
        self.foursquare = [[BZFoursquare alloc] initWithClientID:kClientID callbackURL:kCallbackURL];
        foursquare_.version = @"20111119";
        foursquare_.locale = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
        foursquare_.sessionDelegate = self;
        AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        [delegate setFoursquare:foursquare_];
    }
    return self;
}

- (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.05;
    span.longitudeDelta = 0.05;
    CLLocationCoordinate2D location;
    location.latitude = aUserLocation.coordinate.latitude;
    location.longitude = aUserLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    if (!locationSet) {
        [aMapView setRegion:region animated:YES];
        locationSet = true;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    navigationBar.topItem.title = medicalCategory.name;
    mapView.showsUserLocation = YES;
    mapView.mapType = MKMapTypeStandard;
    mapView.delegate = self;
    if (![foursquare_ isSessionValid]) {
        [foursquare_ startAuthorization];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeVC:(id)sender{
    
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    
}

@end

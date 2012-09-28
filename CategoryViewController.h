//
//  CategoryViewController.h
//  InstaCare
//
//  Created by Frederic Jacobs on 28/9/12.
//  Copyright (c) 2012 Frederic Jacobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BZFoursquare.h"
#import <MapKit/MapKit.h>
#import "MedicalCategory.h"

@interface CategoryViewController : UIViewController<MKMapViewDelegate, BZFoursquareRequestDelegate, BZFoursquareSessionDelegate>{
    IBOutlet MKMapView *mapView;
    IBOutlet UITableView *venuesTableView;
    MedicalCategory *medicalCategory;
    IBOutlet UINavigationBar *navigationBar;
    BOOL locationSet;
    BZFoursquare        *foursquare_;
    BZFoursquareRequest *request_;
    NSDictionary        *meta_;
    NSArray             *notifications_;
    NSDictionary        *response_;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UITableView *venuesTableView;
@property (nonatomic, retain) MedicalCategory *medicalCategory;

@property(nonatomic,readonly,strong) BZFoursquare *foursquare;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil AndMedicalCategory:(MedicalCategory*)category;

- (IBAction)closeVC:(id)sender;

@end

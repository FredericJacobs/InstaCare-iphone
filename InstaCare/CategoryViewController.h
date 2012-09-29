//
//  CategoryViewController.h
//  InstaCare
//
//  Created by Frederic Jacobs on 28/9/12.
//  Copyright (c) 2012 Frederic Jacobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MedicalCategory.h"

@interface CategoryViewController : UIViewController<MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate>{
    IBOutlet MKMapView *mapView;
    IBOutlet UITableView *venuesTableView;
    MedicalCategory *medicalCategory;
    IBOutlet UINavigationBar *navigationBar;
    BOOL locationSet;
    NSMutableArray *annotations;
    NSArray *venues;
    NSIndexPath *selectedRow;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UITableView *venuesTableView;
@property (nonatomic, retain) MedicalCategory *medicalCategory;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil AndMedicalCategory:(MedicalCategory*)category;
- (void) updateViewWithDictionary:(NSDictionary*)dictionary;
- (IBAction)closeVC:(id)sender;

@end

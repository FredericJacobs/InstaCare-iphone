//
//  CategoryViewController.m
//  InstaCare
//
//  Created by Frederic Jacobs on 28/9/12.
//  Copyright (c) 2012 Frederic Jacobs. All rights reserved.
//
#import "AppDelegate.h"
#import "FoursquareSingleton.h"
#import "CategoryViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController
@synthesize mapView, venuesTableView, medicalCategory, navigationBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil AndMedicalCategory:(MedicalCategory*)category
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        medicalCategory = category;
        locationSet = FALSE;
    }
    return self;
}

- (void) updateViewWithDictionary:(NSDictionary*)dictionary{
    
    venues = [dictionary objectForKey:@"venues"];
    
    NSLog(@"%@ and features %i entries",venues,[venues count]);
    
    
    [venuesTableView reloadData];
        
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"Close to you";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (venues != nil) {
        return [venues count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    cell.textLabel.text = [[venues objectAtIndex:indexPath.row]objectForKey:@"name"];
    
    NSLog(@"%@",  [[venues objectAtIndex:indexPath.row]objectForKey:@"name"]);
    return cell;
    
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
        [[FoursquareSingleton sharedManager]searchVenuesAtLocation:[NSString stringWithFormat:@"%f,%f",location.latitude, location.longitude]AndWithCategory:medicalCategory.iDentifier];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    
    if(![[[FoursquareSingleton sharedManager]foursquare] isSessionValid]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Session not valid" message:@"Fuck this shit" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
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
    [[FoursquareSingleton sharedManager]setTheDelegate:self];
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

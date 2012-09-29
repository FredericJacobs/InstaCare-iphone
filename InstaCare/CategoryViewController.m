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
#import "AddressAnnotation.h"

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

    NSLog(@"%@",venues);
    [venuesTableView reloadData];
    [self updateAnnotations];
        
}

- (void) updateAnnotations{
    
    if(annotations != nil) {
        NSMutableArray *toRemove = [NSMutableArray arrayWithCapacity:10];
        for (id annotation in mapView.annotations)
            if (annotation != mapView.userLocation)
                [toRemove addObject:annotation];
        [mapView removeAnnotations:toRemove];
        
        annotations = nil;
    }
    
    else{
        annotations = [[NSMutableArray alloc]init];
    }
    
    for (int i = 0; i < [venues count]; i++) {
        NSString *latitude = [[[venues objectAtIndex:i]objectForKey:@"location"]objectForKey:@"lat"];
        NSString *longitude = [[[venues objectAtIndex:i]objectForKey:@"location"]objectForKey:@"lng"];
        NSString *distance = [[[venues objectAtIndex:i]objectForKey:@"location"]objectForKey:@"distance"];
    
                
        float kmDistance = [distance integerValue];
        
        if (kmDistance > 1000) {
            float dividedNumber = kmDistance / 1000;
            NSString* formattedNumber = [NSString stringWithFormat:@"%.02f", dividedNumber];
            distance = [NSString stringWithFormat:@"%@ km",formattedNumber];
            
        }
        
        else{
            distance = [NSString stringWithFormat:@"%i m", (int)kmDistance];
        }
        
        NSString *name = [[venues objectAtIndex:i]objectForKey:@"name"];
        
        CLLocationCoordinate2D location = CLLocationCoordinate2DMake([latitude floatValue], [longitude floatValue]);
        
        AddressAnnotation *annotation = [[AddressAnnotation alloc]initWithCoordinate:location];
        annotation.title = name;
        [annotation setTag:i];
        annotation.subtitle = [NSString stringWithFormat:@"%@ away", distance];
        
        [annotations addObject:annotation];
    }

    [mapView addAnnotations:annotations];

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
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [mapView selectAnnotation:[annotations objectAtIndex:indexPath.row] animated:YES];
    
    if ([selectedRow isEqual:indexPath]) {
        
        NSString *venueID = [[venues objectAtIndex:indexPath.row]objectForKey:@"id"];
        
        NSString *fsqString = [NSString stringWithFormat:@"foursquare://venues/%@",venueID];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: fsqString]];
        
    }
    
    else{
        selectedRow = indexPath;
    }

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

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *mapPin = nil;
    if(annotation != map.userLocation)
    {
        static NSString *defaultPinID = @"defaultPin";
        mapPin = (MKPinAnnotationView *)[map dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if (mapPin == nil )
        {
            mapPin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                      reuseIdentifier:defaultPinID];
            mapPin.canShowCallout = YES;
            UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            mapPin.rightCalloutAccessoryView = infoButton;
            AddressAnnotation *annotation = (AddressAnnotation*)annotation;
            infoButton.tag = annotation.tag;
            [infoButton addTarget:self action:@selector(didSelectDisclosureInfo:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
            mapPin.annotation = annotation;
        
    }
    return mapPin;
}

- (void) didSelectDisclosureInfo:(UIButton*)button{
    int i = button.tag;
    
    NSString *latitude = [[[venues objectAtIndex:i]objectForKey:@"location"]objectForKey:@"lat"];
    NSString *longitude = [[[venues objectAtIndex:i]objectForKey:@"location"]objectForKey:@"lng"];
    
    NSString *ll = [NSString stringWithFormat:@"%f,%f",[latitude floatValue], [longitude floatValue]];
    
    NSString *queryString = [NSString stringWithFormat:@"http://maps.apple.com/maps?q=%@",ll];
    NSLog(@"%@",queryString);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: queryString]];
    
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

//
//  ViewController.m
//  InstaCare
//
//  Created by Frederic Jacobs on 28/9/12.
//  Copyright (c) 2012 Frederic Jacobs. All rights reserved.
//

#import "ViewController.h"
#import "MedicalCategory.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize myTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    myTableView.delegate = self;

    MedicalCategory *medicalCenter = [[MedicalCategory alloc]initWithName:@"Medical Center" ID:@"4bf58dd8d48988d104941735" andDescription:@""];
    MedicalCategory *dentist = [[MedicalCategory alloc]initWithName:@"Dentist's Office" ID:@"4bf58dd8d48988d178941735" andDescription:@""];
    MedicalCategory *doctor = [[MedicalCategory alloc]initWithName:@"Doctor's Office" ID:@"4bf58dd8d48988d177941735" andDescription:@""];
    MedicalCategory *emergency = [[MedicalCategory alloc]initWithName:@"Emergency Room" ID:@"4bf58dd8d48988d194941735" andDescription:@""];
    MedicalCategory *hospital = [[MedicalCategory alloc]initWithName:@"Hospital" ID:@"4bf58dd8d48988d196941735" andDescription:@""];
    MedicalCategory *medicalLab = [[MedicalCategory alloc]initWithName:@"Medical Lab" ID:@"4f4531b14b9074f6e4fb0103" andDescription:@""];
    MedicalCategory *optical = [[MedicalCategory alloc]initWithName:@"Optical Shops" ID:@"4d954afda243a5684865b473"
                                                     andDescription:@""];
    MedicalCategory *veterinarian = [[MedicalCategory alloc]initWithName:@"Veterinarian" ID:@"4d954af4a243a5684765b473" andDescription:@""];
    
    categories = [[NSArray alloc] initWithObjects:medicalCenter, dentist, doctor, emergency, hospital, medicalLab, optical , veterinarian, nil];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"What are you looking for ?";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    MedicalCategory *cat = (MedicalCategory*)[categories objectAtIndex:indexPath.row];
    
    cell.textLabel.text = cat.name;
    
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  MedicalCategory.m
//  InstaCare
//
//  Created by Frederic Jacobs on 28/9/12.
//  Copyright (c) 2012 Frederic Jacobs. All rights reserved.
//

#import "MedicalCategory.h"

@implementation MedicalCategory

@synthesize name,iDentifier,description;

- (id) initWithName:(NSString*)categoryName ID:(NSString*)identifier andDescription:(NSString*)categoryDescription{
    
    self = [super init];
    name = categoryName;
    iDentifier = identifier;
    description = categoryDescription;
    
    return self;
}

@end

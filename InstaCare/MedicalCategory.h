//
//  MedicalCategory.h
//  InstaCare
//
//  Created by Frederic Jacobs on 28/9/12.
//  Copyright (c) 2012 Frederic Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MedicalCategory : NSObject{
    NSString *name;
    NSString *iDentifier;
    NSString *description;
}

- (id) initWithName:(NSString*)categoryName ID:(NSString*)identifier andDescription:(NSString*)categoryDescription;

@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *iDentifier;
@property (nonatomic, retain) NSString *description;

@end

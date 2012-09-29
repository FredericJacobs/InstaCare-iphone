//
//  AddressAnnotation.h
//  InstaCare
//
//  Created by Frederic Jacobs on 29/9/12.
//  Copyright (c) 2012 Frederic Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface AddressAnnotation : NSObject<MKAnnotation> {
    CLLocationCoordinate2D coordinate;
    NSString *mTitle;
    NSString *mSubTitle;
    int tag;
}
@end

@implementation AddressAnnotation

@synthesize coordinate;

- (void) setTag:(int)i{
    tag = i;
}

- (int) tag {
    return tag;
}

- (NSString *)subtitle{
    return mSubTitle;
}

- (void) setSubtitle:(NSString*)string{
    mSubTitle = string;
}

- (void) setTitle:(NSString*)string{
    
    mTitle = string;
    
}

- (NSString *)title{
    return mTitle;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
    coordinate=c;
    return self;
}

@end


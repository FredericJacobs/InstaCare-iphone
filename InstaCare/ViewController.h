//
//  ViewController.h
//  InstaCare
//
//  Created by Frederic Jacobs on 28/9/12.
//  Copyright (c) 2012 Frederic Jacobs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    
    IBOutlet UITableView *myTableView;
    NSArray *categories;
    
}

@property (nonatomic,retain) UITableView *myTableView;

@end

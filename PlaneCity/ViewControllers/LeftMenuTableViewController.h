//
//  LeftMenuTableViewController.h
//  PlaneCity
//
//  Created by GlennChiu on 5/28/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import "public.h"
#import "GlobalPool.h"

@interface LeftMenuTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>{
    NSString *user_status;
}

@end

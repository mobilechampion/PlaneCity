//

//
//  PlaneCity
//
//  Created by Louis Laurent on 5/28/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.


#import <Parse/Parse.h>

//-------------------------------------------------------------------------------------------------------------------------------------------------
@protocol SelectSingleDelegate
//-------------------------------------------------------------------------------------------------------------------------------------------------

- (void)didSelectSingleUser:(PFUser *)user;

@end

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface SelectSingleView : UITableViewController <UISearchBarDelegate>
//-------------------------------------------------------------------------------------------------------------------------------------------------

@property (nonatomic, assign) IBOutlet id<SelectSingleDelegate>delegate;

@end

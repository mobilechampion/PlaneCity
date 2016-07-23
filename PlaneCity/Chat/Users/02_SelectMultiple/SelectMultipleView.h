//

//
//  PlaneCity
//
//  Created by Louis Laurent on 5/28/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.


#import <UIKit/UIKit.h>

//-------------------------------------------------------------------------------------------------------------------------------------------------
@protocol SelectMultipleDelegate
//-------------------------------------------------------------------------------------------------------------------------------------------------

- (void)didSelectMultipleUsers:(NSMutableArray *)users;

@end

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface SelectMultipleView : UITableViewController
//-------------------------------------------------------------------------------------------------------------------------------------------------

@property (nonatomic, assign) IBOutlet id<SelectMultipleDelegate>delegate;

@end

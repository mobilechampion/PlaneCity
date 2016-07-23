//
//  ReviewTableViewCell.h
//  PlaneCity
//
//  Created by GlennChiu on 5/28/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"

@interface ReviewTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *avatarView;

@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) MDRadialProgressView *happyProgressView;
@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UILabel *descriptionLbl;

@end

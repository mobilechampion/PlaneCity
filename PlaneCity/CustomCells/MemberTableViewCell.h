//
//  MemberTableViewCell.h
//  PlaneCity
//
//  Created by GlennChiu on 6/2/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *lblName;
@property (nonatomic, strong) UILabel *lblStatus;
@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UIImageView *socialView;
@property (nonatomic, strong) UIImageView *socialView2;

@property (nonatomic, strong) UIButton *chatBtn;

@end

//
//  ReviewTableViewCell.m
//  PlaneCity
//
//  Created by GlennChiu on 5/28/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import "ReviewTableViewCell.h"
#import <UIViewAdditions/UIView+RSAdditions.h>

#define kCellHeight 230.0
#define kCellWidth [UIScreen mainScreen].bounds.size.width-20

#define COLOR_TINT [UIColor colorWithRed:64.0/255.0 green:191.0/255.0 blue:242.0/255.0 alpha:1.0]
#define COLOR_TINT_GRAY  [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0]

@implementation ReviewTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self) {
        
        self.avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        self.avatarView.contentMode = UIViewContentModeScaleAspectFill;
        self.avatarView.clipsToBounds = YES;
        
        self.nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.avatarView.right+10, 10, kCellWidth-50, 30)];
        self.nameLbl.textAlignment = NSTextAlignmentLeft;
        self.nameLbl.font = [UIFont boldSystemFontOfSize:14];
        self.nameLbl.textColor = [UIColor blackColor];
        self.nameLbl.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
        [self addSubview:self.nameLbl];
        
        MDRadialProgressTheme *newTheme = [[MDRadialProgressTheme alloc] init];
        newTheme.completedColor = [UIColor colorWithRed:90/255.0 green:212/255.0 blue:39/255.0 alpha:1.0];
        newTheme.incompletedColor = [UIColor colorWithRed:164/255.0 green:231/255.0 blue:134/255.0 alpha:1.0];
        newTheme.centerColor = [UIColor clearColor];
        newTheme.centerColor = [UIColor colorWithRed:224/255.0 green:248/255.0 blue:216/255.0 alpha:1.0];
        newTheme.sliceDividerHidden = YES;
        newTheme.labelColor = COLOR_TINT;
        newTheme.labelShadowColor = [UIColor whiteColor];
        
        CGRect frame = CGRectMake(0, 0, 50, 50);
        self.happyProgressView = [[MDRadialProgressView alloc] initWithFrame:frame andTheme:newTheme];
        self.happyProgressView.progressTotal = 100;
        self.happyProgressView.progressCounter = 54;
        self.happyProgressView.right = kCellWidth - 15;

        self.descriptionLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, self.avatarView.bottom+10, kCellWidth, 30)];
        self.descriptionLbl.textAlignment = NSTextAlignmentLeft;
        self.descriptionLbl.font = [UIFont systemFontOfSize:12];
        self.descriptionLbl.numberOfLines = 3;
        self.descriptionLbl.textColor = [UIColor darkGrayColor];
        
        self.photoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.descriptionLbl.bottom, kCellWidth, 100)];
        self.photoView.contentMode = UIViewContentModeScaleAspectFill;
        self.photoView.clipsToBounds = YES;
        
        
        [self addSubview:self.nameLbl];

        [self addSubview:self.photoView];
        
        [self addSubview:self.happyProgressView];
        [self addSubview:self.descriptionLbl];
        [self addSubview:self.avatarView];

    }
    return self;
}

@end

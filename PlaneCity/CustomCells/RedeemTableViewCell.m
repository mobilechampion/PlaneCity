//
//  RedeemTableViewCell.m
//  PlaneCity
//
//  Created by GlennChiu on 6/2/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import "RedeemTableViewCell.h"
#import "public.h"

#define kCellHeight 70.0
#define kCellWidth [UIScreen mainScreen].bounds.size.width

@implementation RedeemTableViewCell

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
        
        self.photoView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, kCellHeight-40, kCellHeight-40)];
        self.photoView.contentMode = UIViewContentModeScaleAspectFill;
        self.photoView.clipsToBounds = YES;
        self.photoView.centerY = kCellHeight/2;
        
        self.lblContent = [[UILabel alloc] initWithFrame:CGRectMake(self.photoView.right+10, 0, kCellWidth-self.photoView.right-10-80-50, kCellHeight)];
        self.lblContent.font = [UIFont boldSystemFontOfSize:16];
        self.lblContent.textAlignment = NSTextAlignmentLeft;
        self.lblContent.textColor = COLOR_TINT_BLACK_MEDIUM;
        self.lblContent.numberOfLines = 2;
        
        self.lblCoins = [[UILabel alloc] initWithFrame:CGRectMake(self.lblContent.right, 0, kCellWidth-self.lblContent.right-40, kCellHeight-40)];
        self.lblCoins.font = [UIFont boldSystemFontOfSize:15];
        self.lblCoins.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.lblCoins.textAlignment = NSTextAlignmentCenter;
        self.lblCoins.textColor = [UIColor whiteColor];
        self.lblCoins.centerY = kCellHeight/2;
        self.lblCoins.backgroundColor = COLOR_TINT;
        
        self.lblCoins.layer.masksToBounds = YES;
        self.lblCoins.layer.borderWidth = 1;
        self.lblCoins.layer.cornerRadius = 6;
        
        [self addSubview:self.photoView];
        [self addSubview:self.lblContent];
        [self addSubview:self.lblCoins];
        
        UIImageView *line_view = [[UIImageView alloc] initWithFrame:CGRectMake(0, kCellHeight-1, PHONE_WIDTH, 1)];
        line_view.backgroundColor = [UIColor whiteColor];
        [self addSubview:line_view];
    }
    
    return self;
}


@end

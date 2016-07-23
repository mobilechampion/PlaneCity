//
//  FeedTableViewCell.m
//  PlaneCity
//
//  Created by GlennChiu on 5/28/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import "FeedTableViewCell.h"

#define kCellHeight 170.0
#define kCellWidth [UIScreen mainScreen].bounds.size.width-16

#define COLOR_TINT [UIColor colorWithRed:64.0/255.0 green:191.0/255.0 blue:242.0/255.0 alpha:1.0]
#define COLOR_TINT_GRAY  [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0]
#define COLOR_TINT_BLACK  [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1.0]

@implementation FeedTableViewCell

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
        
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [COLOR_TINT_GRAY CGColor];
        self.layer.borderWidth = 1;
        
        self.photoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kCellWidth, kCellHeight)];
        self.photoView.contentMode = UIViewContentModeScaleAspectFill;
        self.photoView.clipsToBounds = YES;
        
        self.lblContent = [[UILabel alloc] initWithFrame:CGRectMake(0, kCellHeight-50, kCellWidth, 35)];
        self.lblContent.font = [UIFont systemFontOfSize:14];
        self.lblContent.textAlignment = NSTextAlignmentLeft;
        self.lblContent.textColor = COLOR_TINT_BLACK;
        self.lblContent.numberOfLines = 2;
        self.lblContent.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
        
        self.lblDate = [[UILabel alloc] initWithFrame:CGRectMake(0, kCellHeight-15, kCellWidth, 15)];
        self.lblDate.font = [UIFont systemFontOfSize:12];
        self.lblDate.textAlignment = NSTextAlignmentLeft;
        self.lblDate.textColor = COLOR_TINT_BLACK;
        self.lblDate.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
        
        [self addSubview:self.photoView];
        [self addSubview:self.lblContent];
        [self addSubview:self.lblDate];
        
    }
    return self;
}

@end

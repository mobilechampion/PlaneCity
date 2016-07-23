//
//  MemberTableViewCell.m
//  PlaneCity
//
//  Created by GlennChiu on 6/2/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import "MemberTableViewCell.h"

#define kCellHeight 800.0
#define kCellWidth [UIScreen mainScreen].bounds.size.width-10-150

#define COLOR_TINT [UIColor colorWithRed:64.0/255.0 green:191.0/255.0 blue:242.0/255.0 alpha:1.0]
#define COLOR_TINT_GRAY  [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0]

@implementation MemberTableViewCell

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
        
        self.photoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 4, 42, 42)];
        self.photoView.contentMode = UIViewContentModeScaleToFill;
        self.photoView.layer.borderColor = [[[UIColor darkGrayColor] colorWithAlphaComponent:0.9] CGColor];
        self.photoView.layer.borderWidth = 2.0;
        self.photoView.layer.cornerRadius = 6.0;
        self.photoView.layer.masksToBounds = YES;
        
        [self addSubview:self.photoView];
        
        self.lblName = [[UILabel alloc] initWithFrame:CGRectMake(self.photoView.frame.size.width+4, 0, kCellWidth, 25)];
        self.lblName.textAlignment = NSTextAlignmentLeft;
        self.lblName.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:self.lblName];
        
        self.lblStatus = [[UILabel alloc] initWithFrame:CGRectMake(self.photoView.frame.size.width+4, 25, kCellWidth, 25)];
        self.lblStatus.textAlignment = NSTextAlignmentLeft;
        self.lblStatus.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:self.lblStatus];
        
        self.socialView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 50, 22, 22)];
        
        [self addSubview:self.socialView];
        
        self.socialView2 = [[UIImageView alloc] initWithFrame:CGRectMake(30, 50, 22, 22)];
        
        [self addSubview:self.socialView2];
        
        self.chatBtn = [[UIButton alloc] initWithFrame:CGRectMake(kCellWidth-28, 50, 22, 22)];
        [self.chatBtn setImage:[UIImage imageNamed:@"chat_circle_green.png"] forState:UIControlStateNormal];
        
        [self addSubview:self.chatBtn];
    }
    
    return self;
}

@end

//
//  PhoneCell.m
//  Conttacts
//
//  Created by Иван on 6/10/19.
//  Copyright © 2019 Иван. All rights reserved.
//

#import "PhoneCell.h"

@implementation PhoneCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.heightAnchor constraintEqualToConstant:70].active = YES;
        self.layer.borderColor = [UIColor colorWithRed:0xDF/255.0f
                                                 green:0xDF/255.0f
                                                  blue:0xDF/255.0f alpha:1].CGColor;
        
        self.phoneLabel = [UILabel new];
        [self.phoneLabel setFont:[UIFont systemFontOfSize:17]];
        [self addSubview:self.phoneLabel];
        self.phoneLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        [NSLayoutConstraint activateConstraints:@[
                                                  [self.phoneLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:20],
                                                  [self.phoneLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-20],
                                                  [self.phoneLabel.heightAnchor constraintEqualToConstant:44],
                                                  [self.phoneLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
                                                  ]
         ];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

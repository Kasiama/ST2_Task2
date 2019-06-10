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
   // self.phoneLabel = [UILabel new];
   // [self addSubview:self.phoneLabel];
    //self.phoneLabel.text = @"FE";
    self.phoneLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.phoneLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:20],
                                              [self.phoneLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-20],
                                              [self.phoneLabel.heightAnchor constraintEqualToConstant:44],
                                              [self.phoneLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
                                              ]
     ];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.phoneLabel = [UILabel new];
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

//
//  Person+imgCellView.m
//  Conttacts
//
//  Created by Иван on 6/10/19.
//  Copyright © 2019 Иван. All rights reserved.
//

#import "Person+imgCellView.h"

@implementation Person_imgCellView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contactImage = [UIImageView new];
    [self addSubview:self.contactImage];
    self.contactInfoLabel = [UILabel new];
    [self.contactInfoLabel sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contactImage = [UIImageView new];
        [self addSubview:self.contactImage];
        self.contactImage.translatesAutoresizingMaskIntoConstraints = NO;
        
        [NSLayoutConstraint activateConstraints:@[
                                                  [self.contactImage.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
                                                  [self.contactImage.heightAnchor constraintEqualToConstant:150],
                                                  [self.contactImage.widthAnchor constraintEqualToAnchor:self.contactImage.heightAnchor multiplier:1],
                                                  [self.contactImage.topAnchor constraintEqualToAnchor:self.topAnchor constant:50]
                                                  ]
         ];
        
        self.contactInfoLabel = [UILabel new];
        [self.contactInfoLabel sizeToFit];
        [self.contactInfoLabel setFont:[UIFont systemFontOfSize:23 weight:UIFontWeightMedium]];
        self.contactInfoLabel.textColor = [UIColor blackColor];
        [self addSubview:self.contactInfoLabel];
        self.contactInfoLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        [NSLayoutConstraint activateConstraints:@[
                                                  [self.contactInfoLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
                                                  [self.contactInfoLabel.heightAnchor constraintEqualToConstant:50],
                                                  [self.contactInfoLabel.topAnchor constraintEqualToAnchor:self.contactImage.bottomAnchor constant:20],
                                                  [self.contactInfoLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-20]
                                                  ]
         ];
    }
    return self;
}


@end

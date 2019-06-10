//
//  CeilViewTableViewCell.m
//  Conttacts
//
//  Created by Иван on 6/8/19.
//  Copyright © 2019 Иван. All rights reserved.
//

#import "CeilViewTableViewCell.h"

@implementation CeilViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleInfoIconTap:)];
    [self.infoBtn addGestureRecognizer:tap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    UIView *selectedColorBackgroundView = [UIView new];
    selectedColorBackgroundView.backgroundColor = [UIColor colorWithRed:0.996 green:0.9647 blue:0.9019 alpha:1];
    self.selectedBackgroundView = selectedColorBackgroundView;
    // Configure the view for the selected state
}
- (void)handleInfoIconTap:(UITapGestureRecognizer *)recognizer {
    [self.delegate showInfoControllerWithContact:self.cnt];
}
@end

//
//  HeaderCell2.m
//  Conttacts
//
//  Created by Иван on 6/9/19.
//  Copyright © 2019 Иван. All rights reserved.
//

#import "HeaderCell2.h"

@implementation HeaderCell2
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *sectionView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        [self.contentView addSubview:sectionView];
        sectionView.frame = self.contentView.bounds;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        [sectionView addGestureRecognizer:tap];
}
    return self;
}
-(void)onTap:(UITapGestureRecognizer*)recognizer{
    
    if ([self.listener respondsToSelector:@selector(didTapOnHeader:)]){
        [self.listener didTapOnHeader:self];
    }
    
    
   
    
} 

- (void)setExpanded:(BOOL)expanded {
    if (_expanded != expanded) {
        _expanded = expanded;
        if (!expanded) {
            self.sectionLetter.textColor = [UIColor blackColor];
            self.contactsLabel.textColor = [UIColor colorWithRed:0.59 green:0.59 blue:0.59 alpha:1.0];
            self.arrowImg.image = [UIImage imageNamed:@"arrow_down"];
        } else {
            self.sectionLetter.textColor = [UIColor colorWithRed:0.850 green:0.568 blue:0 alpha:1.0];
             self.contactsLabel.textColor = [UIColor colorWithRed:0.850 green:0.568 blue:0 alpha:1.0];
            self.arrowImg.image = [UIImage imageNamed:@"arrow_up"];
        }
    }
}
@end

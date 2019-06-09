//
//  HeaderCell2.h
//  Conttacts
//
//  Created by Иван on 6/9/19.
//  Copyright © 2019 Иван. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HeaderCell2;
@protocol DemoHeaderViewListener2 <NSObject>

-(void)didTapOnHeader:(HeaderCell2*)header;

@end


@interface HeaderCell2 : UITableViewHeaderFooterView
@property (assign, nonatomic, getter=isExpanded) BOOL expanded;
@property (nonatomic,weak) id<DemoHeaderViewListener2> listener;
@property (nonatomic,assign)NSInteger section;
@property (nonatomic,strong)UITapGestureRecognizer *taprecognizer;
@property (strong, nonatomic) IBOutlet UILabel *sectionLetter;
@property (strong, nonatomic) IBOutlet UILabel *contactsLabel;
@property (strong, nonatomic) IBOutlet UIImageView *arrowImg;


@end

NS_ASSUME_NONNULL_END

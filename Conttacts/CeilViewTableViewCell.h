//
//  CeilViewTableViewCell.h
//  Conttacts
//
//  Created by Иван on 6/8/19.
//  Copyright © 2019 Иван. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

NS_ASSUME_NONNULL_BEGIN
@class ContactTableViewCell;
@protocol CeilViewTableViewCellDelegate <NSObject>

- (void) showInfoControllerWithContact: (Contact *)contact;
@end


@interface CeilViewTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *contactName;
@property (strong, nonatomic) IBOutlet UIButton *infoBtn;
@property (strong, nonatomic) Contact *cnt;

@property (nonatomic, weak) id <CeilViewTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

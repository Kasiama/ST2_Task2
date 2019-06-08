//
//  CeilViewTableViewCell.h
//  Conttacts
//
//  Created by Иван on 6/8/19.
//  Copyright © 2019 Иван. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CeilViewTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *contactName;
@property (strong, nonatomic) IBOutlet UIImageView *contactImage;

@end

NS_ASSUME_NONNULL_END

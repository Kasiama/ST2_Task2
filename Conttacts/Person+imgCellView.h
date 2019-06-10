//
//  Person+imgCellView.h
//  Conttacts
//
//  Created by Иван on 6/10/19.
//  Copyright © 2019 Иван. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person_imgCellView : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *contactInfoLabel;
@property (strong, nonatomic) IBOutlet UIImageView *contactImage;
@end

NS_ASSUME_NONNULL_END

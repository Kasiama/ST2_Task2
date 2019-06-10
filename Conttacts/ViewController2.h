//
//  ViewController2.h
//  Conttacts
//
//  Created by Иван on 6/10/19.
//  Copyright © 2019 Иван. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
NS_ASSUME_NONNULL_BEGIN

@interface ViewController2 : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) Contact *contact;
@end

NS_ASSUME_NONNULL_END

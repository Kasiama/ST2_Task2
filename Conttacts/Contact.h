//
//  Contact.h
//  Conttacts
//
//  Created by Иван on 6/8/19.
//  Copyright © 2019 Иван. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Contact : NSObject
@property(nonatomic, strong) NSString *firstName;
@property(nonatomic, strong)NSString *lastName;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSMutableArray *phones;
@property (nonatomic,strong)NSString *fulname;
@end

NS_ASSUME_NONNULL_END

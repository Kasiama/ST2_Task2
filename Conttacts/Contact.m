//
//  Contact.m
//  Conttacts
//
//  Created by Иван on 6/8/19.
//  Copyright © 2019 Иван. All rights reserved.
//

#import "Contact.h"

@implementation Contact
- (instancetype)init
{
    self = [super init];
    if (self) {
        _phones = [[NSMutableArray alloc] init];
    }
    return self;
}
@end

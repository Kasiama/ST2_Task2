//
//  ViewController2.m
//  Conttacts
//
//  Created by Иван on 6/10/19.
//  Copyright © 2019 Иван. All rights reserved.
//

#import "ViewController2.h"
#import "Person+imgCellView.h"
#import "PhoneCell.h"

@interface ViewController2 ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[PhoneCell class] forCellReuseIdentifier:@"PhoneTableViewCell"];
  //  UINib *nibb = [UINib nibWithNibName:@"Person+imgCellView" bundle:nil];
    //[self.tableView registerNib:nibb forCellReuseIdentifier:@"PhotoAndNameTableViewCell"];
    [self.tableView registerClass:[Person_imgCellView class] forCellReuseIdentifier:@"PhotoAndNameTableViewCell"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contact.phones.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *cellIdentifier = @"PhotoAndNameTableViewCell";
        
        Person_imgCellView *cell = (Person_imgCellView *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        if(cell == nil) {
            cell = (Person_imgCellView *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
        }
        
        if (self.contact.image) {
            cell.contactImage.image = self.contact.image;
            cell.contactImage.contentMode = UIViewContentModeScaleAspectFill;
            cell.contactImage.layer.cornerRadius = 75;
            cell.contactImage.clipsToBounds = YES;
        }
        else {
            cell.contactImage.image = [UIImage imageNamed:@"noPhotoImage"];
        }
        cell.contactInfoLabel.text = [NSString stringWithFormat:@"%@ %@", self.contact.lastName, self.contact.firstName];
        
        return cell;
    }
    
    else {
        static NSString *cellIdentifier = @"PhoneTableViewCell";
        
        PhoneCell *cell = (PhoneCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        if(cell == nil) {
            cell = (PhoneCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
        }
        
        cell.phoneLabel.text = self.contact.phones[indexPath.row - 1];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


@end

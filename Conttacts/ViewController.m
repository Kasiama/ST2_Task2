//
//  ViewController.m
//  Conttacts
//
//  Created by Иван on 6/8/19.
//  Copyright © 2019 Иван. All rights reserved.
//

#import "ViewController.h"
#import "Contact.h"
#import "CeilViewTableViewCell.h"
#import <Contacts/Contacts.h>


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *contacts;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _contacts = [[NSMutableArray alloc] init];
    [self getArrOfContacts];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CeilViewTableViewCell"];
     self.tableView = [UITableView new];
    [self.view addSubview:self.tableView];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (@available(iOS 11.0, *)) {
        [NSLayoutConstraint activateConstraints:@[
                                                  [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
                                                  [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
                                                  [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
                                                  [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]
                                                  ]
         ];
    } else {
        [NSLayoutConstraint activateConstraints:@[
                                                  [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                                  [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                                  [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
                                                  [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
                                                  ]
         ];
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"CeilViewTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CeilViewTableViewCell"];
    
    self.tableView.tableFooterView = [UIView new];
    NSString *str = @"sdd";
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contacts.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CeilViewTableViewCell *ceil = (CeilViewTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"CeilViewTableViewCell" forIndexPath:indexPath];
    Contact *contact = [self.contacts objectAtIndex:indexPath.row];
    if(ceil == nil) {
        ceil = (CeilViewTableViewCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ContactTableViewCell"];
        
    }
     ceil.contactName.text = [NSString stringWithFormat:@"%@ %@", contact.firstName, contact.lastName];
    return ceil;
}

-(void)getArrOfContacts{
    CNContactStore *store = [[CNContactStore alloc] init];
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted == YES) {
            //keys with fetching properties
            NSArray *keys = @[CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey,CNContactImageDataAvailableKey,CNContactThumbnailImageDataKey ];
            CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
            NSError *error;
            BOOL success = [store enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * __nonnull contact, BOOL * __nonnull stop) {
                if (error) {
                    NSLog(@"error fetching contacts %@", error);
                } else {
                    Contact *newContact = [[Contact alloc] init];
                    newContact.firstName = contact.givenName;
                    newContact.lastName = contact.familyName;
                    if(contact.imageDataAvailable){
                    UIImage *img = [[UIImage alloc] initWithData:contact.imageData];
                    newContact.image = img;
                    }
                    else
                    {
                        UIImage *img = [UIImage imageNamed:@"NoPhoto"];
                        newContact.image = img;
                    }
                    for (CNLabeledValue *val in contact.phoneNumbers){
                        NSString *phone = [val.value stringValue];
                        if([phone length]>0){
                            [newContact.phones addObject:phone];
                        }
                    }
                    
                    [self.contacts addObject:newContact];
                    
                }
            }];
        }
        
    
    }];
}
@end

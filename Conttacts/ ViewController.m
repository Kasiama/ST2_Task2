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
#import "HeaderCell2.h"
#import <Contacts/Contacts.h>

NSString * const cellReuseId = @"cellReuseId";
NSString * const sectionHeaderReuseId = @"sectionHeaderReuseId";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,DemoHeaderViewListener2>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *contacts;
@property (strong, nonatomic) NSMutableArray *arrOfSections;
@property (strong, nonatomic) NSMutableArray *expanded;
@property (strong, nonatomic) NSMutableDictionary *dictionary;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _contacts = [[NSMutableArray alloc] init];
    [self getArrOfContacts];
    self.tableView = [UITableView new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CeilViewTableViewCell"];
    [self.tableView registerClass:[HeaderCell2 class] forHeaderFooterViewReuseIdentifier:sectionHeaderReuseId];
    
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
    UINib *nibb = [UINib nibWithNibName:@"CeilViewTableViewCell" bundle:nil];
    [self.tableView registerNib:nibb forCellReuseIdentifier:@"CeilViewTableViewCell"];
   
    
    _arrOfSections = [[NSMutableArray alloc] init];
    _arrOfSections = [self getArrOfSections];
    
    self.expanded = [NSMutableArray array];
    for(NSInteger i=0; i< self.arrOfSections.count; i++){
        [self.expanded addObject:@NO];
    }
    
    _dictionary = [NSMutableDictionary new];
    for(NSString *key in _arrOfSections ){
        for(Contact *value in self.contacts){
            if([key isEqualToString:[value.lastName substringToIndex:1]]){
                if ([_dictionary objectForKey:key] == nil )
                {
                 [_dictionary setObject:[NSMutableArray new] forKey:key];
                    [[_dictionary objectForKey:key] addObject:value];
                }
    
                else
                [[_dictionary objectForKey:key] addObject:value];
            }
                else if([key isEqualToString:@"#"] &&
([value.lastName characterAtIndex:0]<65
 || ([value.lastName characterAtIndex:0]<97  && [value.lastName characterAtIndex:0]>90)
 || ([value.lastName characterAtIndex:0]<1040  && [value.lastName characterAtIndex:0]>122)
 || ([value.lastName characterAtIndex:0]>1103)))
            {
                if ([_dictionary objectForKey:@"#"] == nil )
                {
                    [_dictionary setObject:[NSMutableArray new] forKey:@"#"];
                    [[_dictionary objectForKey:@"#"] addObject:value];
                }
                
                else
                    [[_dictionary objectForKey:@"#"] addObject:value];
            }
            
        }
    }
    
    
   
    
}
-(NSMutableArray*)getArrOfSections{
    NSMutableSet *setEnglish = [[NSMutableSet alloc] init];
    NSMutableSet *setRussian = [[NSMutableSet alloc] init];
    Boolean is = NO;
    for(Contact *con in self.contacts){
        NSString *let = [con.lastName substringToIndex:1];
        int a = [let characterAtIndex:0];
        if((a>=65 && a<=90) || (a>=97 && a <=122) )
        {
              //65-90 97-122 1072-1103 1040 -1071
        [setEnglish addObject:let];
        }
       else if  (a>=1040 && a<=1103)
        {
            [setRussian addObject: let];
        }
        else is = YES;
        
    
    }
    NSMutableArray *arrEnglish = [[NSMutableArray alloc] initWithArray:[setEnglish allObjects]];
    NSMutableArray *arrRussian= [[NSMutableArray alloc] initWithArray:[setRussian allObjects]];
     [arrEnglish sortUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        int a = [str1 characterAtIndex:0];
        int b = [str2 characterAtIndex:0];
         return a>b;
    }];
    [arrRussian sortUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        int a = [str1 characterAtIndex:0];
        int b = [str2 characterAtIndex:0];
        return a>b;
    }];
    
    NSArray *newArray=arrRussian?[arrRussian arrayByAddingObjectsFromArray:arrEnglish]:[[NSArray alloc] initWithArray:arrEnglish];
    NSMutableArray *answ=[[NSMutableArray alloc] initWithArray:newArray];
    if (is)
        [answ addObject:@"#"];
    return answ;
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



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _arrOfSections.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSNumber *state  = self.expanded[section];
   if ([state boolValue])
    {
        return 0;
    }
   else{
       NSString *sectionTitle = [self.arrOfSections objectAtIndex:section];
       NSArray *sectionContacts = [self.dictionary objectForKey:sectionTitle];
       return [sectionContacts count];
   };
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HeaderCell2 *headerCell = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionHeaderReuseId];
    NSString *letter = [self.arrOfSections objectAtIndex:section];
    headerCell.sectionLetter.text = letter;
    NSString *numberOfContacts = [NSString stringWithFormat:@"контактов: %ld", (long)[[self.dictionary objectForKey:letter]count]];
     headerCell.contactsLabel.text = numberOfContacts;
    headerCell.expanded = [self.expanded[section] boolValue];
    headerCell.arrowImg.image = [UIImage imageNamed:@"arrow_up"];
   headerCell.section = section;
    headerCell.listener = self;
    return headerCell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CeilViewTableViewCell *ceil = (CeilViewTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"CeilViewTableViewCell" forIndexPath:indexPath];
    
    
   NSArray *sectionContacts = [self.dictionary objectForKey:[self.arrOfSections objectAtIndex:indexPath.section]];
    Contact *contact = [sectionContacts objectAtIndex:indexPath.row];
     ceil.contactName.text = [NSString stringWithFormat:@"%@ %@", contact.firstName, contact.lastName];
    return ceil;
}

//demoheaderview
- (void)didTapOnHeader:(HeaderCell2 *)header{
    BOOL state = [self.expanded[header.section] boolValue];
    self.expanded[header.section] = @(!state);
    header.expanded = !state;
    if (state) {
        NSMutableArray *paths = [NSMutableArray array];
        NSInteger a = [[self.dictionary valueForKey:[self.arrOfSections objectAtIndex:header.section]]count ];
        for (NSInteger i =0; i<a; i++) {
            NSIndexPath *path =[NSIndexPath indexPathForRow:i inSection:header.section];
            [paths addObject:path];
        }
    
        [self.tableView insertRowsAtIndexPaths:paths  withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else{
        NSMutableArray *paths = [NSMutableArray array];
        NSInteger a = [[self.dictionary valueForKey:[self.arrOfSections objectAtIndex:header.section]]count ];
        for (NSInteger i =0; i<a; i++) {
            NSIndexPath *path =[NSIndexPath indexPathForRow:i inSection:header.section];
            [paths addObject:path];
        }
        [self.tableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    
    
}

@end


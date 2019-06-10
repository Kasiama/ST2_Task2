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
#import "ViewController2.h"
#import <Contacts/Contacts.h>

NSString * const cellReuseId = @"cellReuseId";
NSString * const sectionHeaderReuseId = @"sectionHeaderReuseId";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,DemoHeaderViewListener2,CeilViewTableViewCellDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *contacts;
@property (strong, nonatomic) NSMutableArray *arrOfSections;
@property (strong, nonatomic) NSMutableArray *expanded;
@property (strong, nonatomic) NSMutableDictionary *dictionary;

@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Контакты";
    self.tableView = [UITableView new];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.tableView registerClass:[HeaderCell2 class] forHeaderFooterViewReuseIdentifier:sectionHeaderReuseId];
     self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.tableView];
    //self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
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
    self.tableView.tableFooterView = [UIView new];
    UINib *nibb = [UINib nibWithNibName:@"CeilViewTableViewCell" bundle:nil];
    [self.tableView registerNib:nibb forCellReuseIdentifier:@"CeilViewTableViewCell"];
   
    
    
    _contacts = [[NSMutableArray alloc] init];
    _dictionary=[[NSMutableDictionary alloc] init];
    _arrOfSections = [[NSMutableArray alloc] init];
    self.expanded = [NSMutableArray array];
    [self getArrOfContacts];
}


-(void)sortRowsinSection{
    if (self.dictionary == nil)
        return;
    else{
        for(NSString *key in self.arrOfSections){
            NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:[self.dictionary objectForKey:key]];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"fulname" ascending:YES selector:@selector(caseInsensitiveCompare:)];
            NSMutableArray *a = [[NSMutableArray alloc] init];
            
            a=[arr sortedArrayUsingDescriptors:@[sort]];
            [self.dictionary removeObjectForKey:key];
            [self.dictionary setObject:a forKey:key];
           
        }
    }
}


-(void)showAccessDeniedScreen {
    self.tableView.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithRed:0.59 green:0.59 blue:0.59 alpha:1];
    UILabel *accessDeniedLabel = [UILabel new];
    UIFont *system17RegularFont = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    accessDeniedLabel.textColor = [UIColor blackColor];
    accessDeniedLabel.font = system17RegularFont;
    accessDeniedLabel.text = @"Доступ к списку контактов запрещен. Войдите в Settings и разрешите доступ";
    accessDeniedLabel.numberOfLines = 0;
    accessDeniedLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:accessDeniedLabel];
    accessDeniedLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[[accessDeniedLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [accessDeniedLabel.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
                                              [accessDeniedLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20],
                                              [self.view.trailingAnchor constraintEqualToAnchor:accessDeniedLabel.trailingAnchor constant:20]]];
}


-(NSMutableArray*)getArrOfSections{
    NSMutableSet *setEnglish = [[NSMutableSet alloc] init];
    NSMutableSet *setRussian = [[NSMutableSet alloc] init];
    Boolean is = NO;
    for(Contact *con in self.contacts){
         if([con.lastName isEqualToString:@""]){
            NSString *let = [con.firstName substringToIndex:1];
            let = [let uppercaseString];
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

        else{
        NSString *let = [con.lastName substringToIndex:1];
            let = [let uppercaseString];
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

-(NSMutableDictionary*)getDictionary{
    NSMutableDictionary *dictionary =[NSMutableDictionary new];
   for(NSString *key in _arrOfSections ) {
        for(Contact *value in self.contacts){
            if(![value.lastName isEqualToString:@""]) {
                if([key isEqualToString:[[value.lastName substringToIndex:1]uppercaseString]]){
                    if ([dictionary objectForKey:key] == nil )
                    {
                        [dictionary setObject:[NSMutableArray new] forKey:key];
                        [[dictionary objectForKey:key] addObject:value];
                    }
                    
                    else
                        [[dictionary objectForKey:key] addObject:value];
                }
                else if([key isEqualToString:@"#"] &&
                        ([value.lastName characterAtIndex:0]<65
                         || ([value.lastName characterAtIndex:0]<97  && [value.lastName characterAtIndex:0]>90)
                         || ([value.lastName characterAtIndex:0]<1040  && [value.lastName characterAtIndex:0]>122)
                         || ([value.lastName characterAtIndex:0]>1103)))
                {
                    if ([dictionary objectForKey:@"#"] == nil )
                    {
                        [dictionary setObject:[NSMutableArray new] forKey:@"#"];
                        [[dictionary objectForKey:@"#"] addObject:value];
                    }
                    
                    else
                        [[dictionary objectForKey:@"#"] addObject:value];
                }
                
            }
            else{
                if([key isEqualToString:[[value.firstName substringToIndex:1]uppercaseString]]){
                    if ([dictionary objectForKey:key] == nil )
                    {
                        [dictionary setObject:[NSMutableArray new] forKey:key];
                        [[dictionary objectForKey:key] addObject:value];
                    }

                    else
                        [[dictionary objectForKey:key] addObject:value];
                }
                else if([key isEqualToString:@"#"] &&
                        ([value.firstName characterAtIndex:0]<65
                         || ([value.firstName characterAtIndex:0]<97  && [value.firstName characterAtIndex:0]>90)
                         || ([value.firstName characterAtIndex:0]<1040  && [value.firstName characterAtIndex:0]>122)
                         || ([value.firstName characterAtIndex:0]>1103)))
                {
                    if ([dictionary objectForKey:@"#"] == nil )
                    {
                        [dictionary setObject:[NSMutableArray new] forKey:@"#"];
                        [[dictionary objectForKey:@"#"] addObject:value];
                    }

                    else
                        [[dictionary objectForKey:@"#"] addObject:value];
                }
            }
            
        
        }
    }
    
    return dictionary;
}
-(void)getArrOfContacts{
    CNContactStore *store = [[CNContactStore alloc] init];
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted == YES) {
             __weak __typeof__(self) weakSelf = self;
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
                   // newContact.fulname = @"dkdd";
                   newContact.fulname =  [NSString stringWithFormat:@"%@%@",newContact.lastName,newContact.firstName];
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
            self.arrOfSections = [[NSMutableArray alloc] init];
            self.arrOfSections = [self getArrOfSections];
            
            self.expanded = [NSMutableArray array];
            for(NSInteger i=0; i< self.arrOfSections.count; i++){
                [self.expanded addObject:@NO];
            }
            self.dictionary =[self getDictionary];
            [self sortRowsinSection];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
            });
        }
        else
        {
             __weak __typeof__(self) weakSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf showAccessDeniedScreen];
            });
            
        }
        
        
    }];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *sectionTitle = [self.arrOfSections objectAtIndex:indexPath.section];
    NSArray *section = [self.dictionary objectForKey:sectionTitle];
    Contact *contact = [section objectAtIndex:indexPath.row];
    
    NSMutableString *contactDetails = [NSMutableString stringWithString:@"Контакт"];
    if (contact.lastName.length != 0) {
        [contactDetails appendString:[NSString stringWithFormat:@" %@", contact.lastName]];
    }
    if (contact.firstName.length != 0) {
        [contactDetails appendString:[NSString stringWithFormat:@" %@", contact.firstName]];
    }
   
    if (contact.phones.count != 0) {
        [contactDetails appendString:[NSString stringWithFormat:@", номер телефона %@", contact.phones[0] ]];
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:contactDetails preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _arrOfSections.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
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
    headerCell.arrowImg.image = [UIImage imageNamed:@"arrow_down"];
   headerCell.section = section;
    headerCell.listener = self;
    return headerCell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CeilViewTableViewCell *ceil = (CeilViewTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"CeilViewTableViewCell" forIndexPath:indexPath];
    
    
   NSArray *sectionContacts = [self.dictionary objectForKey:[self.arrOfSections objectAtIndex:indexPath.section]];
    Contact *contact = [sectionContacts objectAtIndex:indexPath.row];
    ceil.cnt= contact;
    ceil.delegate = self;
     ceil.contactName.text = [NSString stringWithFormat:@"%@ %@", contact.lastName, contact.firstName];
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
//- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"Delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
//        NSString *sectionTitle = [self.arrOfSections objectAtIndex:indexPath.section];
//        [ [self.dictionary objectForKey:sectionTitle]removeObjectAtIndex:indexPath.row];
//        if([[self.dictionary objectForKey:sectionTitle] count ]==0)
//            [self.arrOfSections removeObject:sectionTitle];
//        
//        
//        [self.tableView reloadData];
//    }];
//    
//    UISwipeActionsConfiguration *configuraion = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction]];
//    configuraion.performsFirstActionWithFullSwipe = NO;
//    return configuraion;
//}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSString *sectionTitle = [self.arrOfSections objectAtIndex:indexPath.section];
        NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:[self.dictionary objectForKey:sectionTitle]];
        //[ [self.dictionary objectForKey:sectionTitle] removeObjectAtIndex:indexPath.row];
        [arr removeObjectAtIndex:indexPath.row];
        [self.dictionary removeObjectForKey:sectionTitle];
        [self.dictionary setObject:arr forKey:sectionTitle];
        if([[self.dictionary objectForKey:sectionTitle] count ]==0)
            [self.arrOfSections removeObject:sectionTitle];
        [self.tableView reloadData];
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    return @[deleteAction];
    
}
-(void)showInfoControllerWithContact:(Contact *)contact {
    ViewController2 *vc = [[ViewController2 alloc] initWithNibName:@"ViewController2" bundle:nil];
    vc.contact = contact;
    [self.navigationController pushViewController:vc animated:YES];
}
@end


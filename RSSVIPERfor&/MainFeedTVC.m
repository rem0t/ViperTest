//
//  MainFeedTVC.m
//  RSSVIPERfor&
//
//  Created by Vladislav Kalaev on 30.05.17.
//  Copyright © 2017 VLad. All rights reserved.
//

#import "MainFeedTVC.h"
#import "CastomTVC.h"
#import "DetailVC.h"
#import "UIImageView+AFNetworking.h"

@interface MainFeedTVC () {
    
  UIRefreshControl *refreshControl;
    NSArray *allData;
    
}

@end



@implementation MainFeedTVC

- (void)viewDidLoad {
    

    [super viewDidLoad];

    self.navigationItem.title = @"RSSforRambler&co";
    
    [self obtainData];
    
    [self addPullToRefreshRefreshTable];


    
}

-(void) addPullToRefreshRefreshTable {
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(obtainData) forControlEvents:(UIControlEventValueChanged)];
    [self.tableView addSubview:refreshControl];
    
}


- (void) obtainData {
    
    self.manager = [[NetworkManager alloc]init];
    
    
    [self.manager parseLentaMethod];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshTable)
                                                 name:@"MyNotification"
                                               object:nil];
}


- (void) refreshTable {
    
    [self.tableView reloadData];
    
    [refreshControl endRefreshing];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.manager.sortedArray count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CastomTVC *castomCell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    
    RSSItem *item = [self.manager.sortedArray objectAtIndex:indexPath.row];
   
    
    
// **** formating the string
    NSString *separatorString = @"/";
    NSString *myString = item.guid;
    NSString *newStr = [myString substringFromIndex:8];
    NSString *myNewString = [newStr componentsSeparatedByString:separatorString].firstObject;
    
    castomCell.sourceLable.text = myNewString;
// *** do another method for this?
    
    
    NSURL *imageURL = item.link;
    [castomCell.feedImage setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"noimage"]];
    
    castomCell.titleLable.text = item.title;
    
    
    
    return castomCell;
}




-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender { // send data to detailMVC
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath) {
        RSSItem *item = [self.manager.sortedArray objectAtIndex:indexPath.row];
        [segue.destinationViewController setDetail:item];
    
    }
    
}





-(void) missInternetConnetctionAler:(NSError*)error { //Alert for loss internet connetion
    
    
    [[[UIAlertView alloc] initWithTitle:error.localizedDescription
                                message:error.localizedRecoverySuggestion
                               delegate:nil
                      cancelButtonTitle:NSLocalizedString(@"OK", nil)
                      otherButtonTitles:nil, nil] show];

    
//    UIAlertController *alert = [UIAlertController
//                                alertControllerWithTitle:error.localizedDescription
//                                message:error.localizedRecoverySuggestion
//                                preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:NULL];
//    
//    [alert addAction:okAction];
//    
//    [self presentViewController:alert animated:true completion:NULL];

// Warning: Attempt to present <UIAlertController: 0x7aae8e00> on <MainFeedTVC: 0x79e82030> whose view is not in the window hierarchy!

    

}




@end

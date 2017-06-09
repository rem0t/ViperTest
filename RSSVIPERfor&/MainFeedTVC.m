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
    
    
    self.manager = [[NetworkManager alloc]init];

    
    [self.manager parseLentaMethod];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshTableEnd)
                                                 name:@"MyNotification"
                                               object:nil];

    
}


-(void) refreshTableBegin { // not work
    
    refreshControl = [[UIRefreshControl alloc]init];
    
    [refreshControl addTarget:self action:@selector(refreshTableEnd) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:refreshControl];
    
}


- (void) refreshTableEnd {
    

    [refreshControl endRefreshing];
    
    [self.tableView reloadData];

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
    
    return [self.manager.sortedArray count]+1;
    
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




@end

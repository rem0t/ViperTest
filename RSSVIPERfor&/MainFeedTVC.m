//
//  MainFeedTVC.m
//  RSSVIPERfor&
//
//  Created by Vladislav Kalaev on 30.05.17.
//  Copyright © 2017 VLad. All rights reserved.
//

#import "MainFeedTVC.h"
#import "CastomTVC.h"
#import "RSSParser.h"
#import "DetailVC.h"
#import "UIImageView+AFNetworking.h"

@interface MainFeedTVC () {
    
}

@end

@implementation MainFeedTVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"RSSforRambler&co";
    
    //http://www.gazeta.ru/export/rss/lenta.xml
    //http://lenta.ru/rss
    
    NSURL *urlLenta = [NSURL URLWithString:@"http://lenta.ru/rss"];
 //   NSURL *urlGazeta = [NSURL URLWithString:@"http://www.gazeta.ru/export/rss/lenta.xml"];

    NSURLRequest *requestLenta = [[NSURLRequest alloc]initWithURL:urlLenta];
  //  NSURLRequest *requestGazeta = [[NSURLRequest alloc]initWithURL:urlGazeta];

    
    [RSSParser parseRSSFeedForRequest:requestLenta success:^(NSArray *feedItems) {
        
        _dataLenta = feedItems;
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
   
//    [RSSParser parseRSSFeedForRequest:requestGazeta success:^(NSArray *feedItems) {
//        
//        _dataGazeta = feedItems;
//
//        
//    } failure:^(NSError *error) {
//        
//    }];
    
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
    
    return [self.dataLenta count] ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CastomTVC *castomCell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    RSSItem *item = [_dataLenta objectAtIndex:indexPath.row];
    
    castomCell.titleLable.text = item.title;
    castomCell.sourceLable.text = item.author;
    NSURL *imageURL = [item link];
    [castomCell.feedImage setImageWithURL:imageURL];
  
    return castomCell;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath) {
        RSSItem *item = [_dataLenta objectAtIndex:indexPath.row];
        [segue.destinationViewController setDetail:item];
    
        
    }
    
}






@end

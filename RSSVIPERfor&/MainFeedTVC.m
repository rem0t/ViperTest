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

    NSURLRequest *requestLenta = [[NSURLRequest alloc]initWithURL:urlLenta];

    
    [RSSParser parseRSSFeedForRequest:requestLenta success:^(NSArray *feedItems) {
        
        _dataLenta = feedItems;

        [self testMethod];
        
    } failure:^(NSError *error) {
        
    }];
   
//    [RSSParser parseRSSFeedForRequest:requestGazeta success:^(NSArray *feedItems) {
//        
//        _dataGazeta = feedItems;
//
//
//        [_allData addObjectsFromArray: _dataGazeta];
//        
//        [self.tableView reloadData];
//
//
//    } failure:^(NSError *error) {
//        
//    }];
//    
//
    

    
    
}

-(void)testMethod{
    
    NSURL *urlGazeta = [NSURL URLWithString:@"http://www.gazeta.ru/export/rss/lenta.xml"];
    NSURLRequest *requestGazeta = [[NSURLRequest alloc]initWithURL:urlGazeta];

    
    
    [RSSParser parseRSSFeedForRequest:requestGazeta success:^(NSArray *feedItems) {
    
            _dataGazeta = feedItems;
    
    
        self.allData = [_dataGazeta arrayByAddingObjectsFromArray:_dataLenta];

    
            [self.tableView reloadData];
    
    
        } failure:^(NSError *error) {
            
        }];
        
    
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
    
    return [self.allData count] ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CastomTVC *castomCell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    RSSItem *item = [_allData objectAtIndex:indexPath.row];
    
    castomCell.titleLable.text = item.title;
    
// **** formating the string
    
    NSString *separatorString = @"/";
    NSString *myString = item.guid;
    NSString *newStr = [myString substringFromIndex:8];
    NSString *myNewString = [newStr componentsSeparatedByString:separatorString].firstObject;
    
    castomCell.sourceLable.text = myNewString;

    
// *** do another method for this?
    
    
    
    NSURL *imageURL = item.link;
    
  
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
        RSSItem *item = [_allData objectAtIndex:indexPath.row];
        [segue.destinationViewController setDetail:item];
    
    }
    
}




@end

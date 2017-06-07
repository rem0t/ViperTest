//
//  MainFeedTVC.h
//  RSSVIPERfor&
//
//  Created by Vladislav Kalaev on 30.05.17.
//  Copyright © 2017 VLad. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainFeedTVC : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) IBOutlet UITableView *tableView;


@property (strong,nonatomic) NSArray *dataLenta;
@property (strong,nonatomic) NSArray *dataGazeta;
@property (strong,nonatomic) NSArray *allData;




@end

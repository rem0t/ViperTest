//
//  NetworkManager.m
//  RSSVIPERfor&
//
//  Created by Vladislav Kalaev on 09.06.17.
//  Copyright © 2017 VLad. All rights reserved.
//

#import "NetworkManager.h"
#import "RSSParser.h"
#import "MainFeedTVC.h"

@interface NetworkManager() { 
    
    
}

@end


@implementation NetworkManager




#pragma mark - Parser methods



-(void) parseLentaMethod {
    
    NSURL *urlLenta = [NSURL URLWithString:@"http://lenta.ru/rss"];
    
    NSURLRequest *requestLenta = [[NSURLRequest alloc]initWithURL:urlLenta];
    
    
    [RSSParser parseRSSFeedForRequest:requestLenta success:^(NSArray *feedItems) {
        
        _dataLenta = feedItems;
        
        [self parseGazetaMethod];
        
    } failure:^(NSError *error) {
       
        
        static dispatch_once_t onceToken; 
        dispatch_once(&onceToken, ^{
            
            MainFeedTVC *foraAlert = [[MainFeedTVC alloc]init];
            
            [foraAlert missInternetConnetctionAler:(NSError*)error];
        
            
        });

        
                
    }];
}



-(void) parseGazetaMethod {
    
    NSURL *urlGazeta = [NSURL URLWithString:@"https://www.gazeta.ru/export/rss/first.xml"];
    
    NSURLRequest *requestGazeta = [[NSURLRequest alloc]initWithURL:urlGazeta];
    
    
    [RSSParser parseRSSFeedForRequest:requestGazeta success:^(NSArray *feedItems) {
        
        _dataGazeta = feedItems;
        
        _allData = [_dataGazeta arrayByAddingObjectsFromArray:_dataLenta];
        
        [self feedSortedArray];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}


-(void) feedSortedArray {
    
self.sortedArray = [[NSMutableArray alloc]initWithArray:_allData];
    
NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"pubDate" ascending:FALSE];
[_sortedArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
[[NSNotificationCenter defaultCenter] postNotificationName:@"MyNotification" object:nil];


    
}




@end

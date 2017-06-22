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
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.sortedArray = [[NSMutableArray alloc]initWithArray:_allData];
        
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"pubDate" ascending:FALSE];
        [_sortedArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MyNotification" object:nil];
        
    });
    
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//    });
//    nw_socket_get_input_frames recvmsg(fd 14, 1024 bytes): [54] Connection reset by peer
//    2017-06-22 17:06:14.483558 RSSVIPERfor&[8923:561316] [] nw_endpoint_handler_add_write_request [3.1.2 81.19.72.0:443 failed socket-flow (satisfied)] cannot accept write requests
//    2017-06-22 17:06:14.492783 RSSVIPERfor&[8923:561258] [] __tcp_connection_write_eof_block_invoke Write close callback received error: [22] Invalid argument

    
    
}




@end

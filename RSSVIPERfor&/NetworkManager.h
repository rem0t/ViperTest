//
//  NetworkManager.h
//  RSSVIPERfor&
//
//  Created by Vladislav Kalaev on 09.06.17.
//  Copyright © 2017 VLad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject


@property (strong,nonatomic) NSArray *dataLenta;
@property (strong,nonatomic) NSArray *dataGazeta;
@property (strong,nonatomic) NSArray *allData;
@property (strong,nonatomic) NSMutableArray *sortedArray;

-(void) parseLentaMethod;

@end

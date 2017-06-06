//
//  DetailVC.m
//  RSSVIPERfor&
//
//  Created by Vladislav Kalaev on 01.06.17.
//  Copyright © 2017 VLad. All rights reserved.
//

#import "DetailVC.h"
#import "UIImageView+AFNetworking.h"


@interface DetailVC ()


@end


@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setDetail:(RSSItem *)detail {
    
    _detail = detail;
    
}


-(void)reloadData {
    
    if(!_detail){
        return;
    }
    
            //imageView
    
    self.titleLabel.text = _detail.title;
    self.textView.text = _detail.itemDescription;
    
    NSURL *imageURL = [_detail link];
    [self.imageView setImageWithURL:imageURL];

    
}



@end

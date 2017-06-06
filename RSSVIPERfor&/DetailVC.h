//
//  DetailVC.h
//  RSSVIPERfor&
//
//  Created by Vladislav Kalaev on 01.06.17.
//  Copyright © 2017 VLad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSItem.h"

@interface DetailVC : UIViewController


@property (strong, nonatomic)  RSSItem* detail;


@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end

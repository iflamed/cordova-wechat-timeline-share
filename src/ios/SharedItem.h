//
//  SharedItem.h
//  xingjiang
//
//  Created by 吴德明 on 16/7/14.
//  Copyright © 2016年 吴德明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface SharedItem : NSObject<UIActivityItemSource>

-(instancetype)initWithData:(UIImage*)img andFile:(NSURL*)file;

@property (nonatomic, strong) UIImage *img;
@property (nonatomic, strong) NSURL *path;

@end

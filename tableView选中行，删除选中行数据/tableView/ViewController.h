//
//  ViewController.h
//  tableView
//
//  Created by MAX on 16/5/4.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIToolbar *cancelBtn;

@property (weak, nonatomic) IBOutlet UITableView *tv;

@property (strong,nonatomic) NSMutableArray *dataArr;

@property (strong,nonatomic) NSMutableArray *deleArr;
@end


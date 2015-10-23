//
//  ViewController.m
//  AddressDemo
//
//  Created by saifing_82 on 15/10/23.
//  Copyright © 2015年 JamesGu. All rights reserved.
//

#import "ViewController.h"
#import "AddressBookManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [AddressBookManager getAddressBookWithComplete:^(NSDictionary *addressBookDic) {
        NSLog(@"您有%lu条通讯录",(unsigned long)addressBookDic.count);
    } errorHandler:^(NSString *errorMessage) {
        NSLog(@"%@",errorMessage);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

//
//  AddressBookManager.h
//  AddressDemo
//
//  Created by saifing_82 on 15/10/23.
//  Copyright © 2015年 JamesGu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressBookManager : NSObject

typedef void(^CompleteHandler)(NSDictionary *addressBookDic);
typedef void(^ErrorHandler)(NSString *errorMessage);

+ (void)getAddressBookWithComplete:(CompleteHandler)completeHandler errorHandler:(ErrorHandler)errorHandler;
@end

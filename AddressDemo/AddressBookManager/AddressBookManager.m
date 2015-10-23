//
//  AddressBookManager.m
//  AddressDemo
//
//  Created by saifing_82 on 15/10/23.
//  Copyright © 2015年 JamesGu. All rights reserved.
//

#import "AddressBookManager.h"
#import <AddressBook/AddressBook.h>

@implementation AddressBookManager

+ (void)getAddressBookWithComplete:(CompleteHandler)completeHandler errorHandler:(ErrorHandler)errorHandler{
    if (&ABAddressBookRequestAccessWithCompletion != NULL) {    //检查是否是iOS6
        ABAddressBookRef abRef = ABAddressBookCreateWithOptions(NULL, NULL);
        if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
            //如果该应用从未申请过权限，申请权限
            ABAddressBookRequestAccessWithCompletion(abRef, ^(bool granted, CFErrorRef error) {
                //根据granted参数判断用户是否同意授予权限
                if (granted) {
                    completeHandler([self addressInfo]);
                }else{
                    errorHandler(@"您已拒绝本应用获取您的通讯录,您可以在设置-隐私-通讯录中开启本软件的访问权限");
                }
            });
        } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
            //如果权限已经被授予
            //查询所有，这里我们可以用来进行下一步操作
            completeHandler([self addressInfo]);
        } else {
            errorHandler(@"无法获取到您的通讯录，请在设置-隐私-通讯录中开启本软件的访问权限");
        }
        if(abRef){
            CFRelease(abRef);
        }
    }
}

+ (NSDictionary *)addressInfo{
    //查询所有，这里我们可以用来进行下一步操作
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    NSMutableDictionary *peopleDic = [NSMutableDictionary dictionary];
    //获取联系人电话
    CFArrayRef allPerson = ABAddressBookCopyArrayOfAllPeople(addressBook);//取全部联系人
    for(int i = 0; i < CFArrayGetCount(allPerson); i++)
    {
        ABRecordRef person = CFArrayGetValueAtIndex(allPerson, i);
        //读取firstname
        NSString *first = (__bridge_transfer  NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        if (first==nil) {
            first = @"";
        }
        NSString *last = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
        if (last == nil) {
            last = @"";
        }
        NSMutableString *name = [last mutableCopy];
        [name appendString:first];
        ABMultiValueRef tmlphone =  ABRecordCopyValue(person, kABPersonPhoneProperty);
        NSArray * Array = CFBridgingRelease(ABMultiValueCopyArrayOfAllValues(tmlphone));
        //读取电话多值
        for(int index = 0; index< [Array count]; index++){
            NSString *telphone = (NSString*)[Array objectAtIndex:index];
            if (name && name.length > 0 && telphone && telphone.length>0) {
                [peopleDic setObject:name forKey:telphone];
            }
        }
        CFRelease(tmlphone);
    }
    CFRelease(allPerson);
    CFRelease(addressBook);
    return peopleDic;
}

@end

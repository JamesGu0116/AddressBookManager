# AddressBookManager
Get iOS address book .

>How to use？
```objective-c
    [AddressBookManager getAddressBookWithComplete:^(NSDictionary *addressBookDic) {
        NSLog(@"您有%lu条通讯录",(unsigned long)addressBookDic.count);
    } errorHandler:^(NSString *errorMessage) {
        NSLog(@"%@",errorMessage);
    }];
```

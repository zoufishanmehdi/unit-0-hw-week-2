//
//  main.m
//  CaesarCipher
//
//  Created by Michael Kavouras on 6/21/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

//we want to know if two distinct looking ciphers correspond to the same input message. Write a method called codeBreaker, which accepts two cipher strings as paramaters and returns a boolean value which tells us whether they are actually the same input message encoded using two different offsets. hint: the maximum offset is 25


#import <Foundation/Foundation.h>

@interface CaesarCipher : NSObject

- (NSString *)encode:(NSString *)string offset:(int)offset;
- (NSString *)decode:(NSString *)string offset:(int)offset;

- (BOOL) checkSameString:(NSString *)decode withString:(NSString *)otherString;

@end


@implementation CaesarCipher {
    NSString *_encode;
    NSString *_decode;
}

- (NSString *)encode:(NSString *)string offset:(int)offset {
    if (offset > 25) {
        NSAssert(offset < 26, @"offset is out of range. 1 - 25");
    }
    NSString *str = [string lowercaseString];
    unsigned long count = [string length];
    unichar result[count];
    unichar buffer[count];
    [str getCharacters:buffer range:NSMakeRange(0, count)];
    
    char allchars[] = "abcdefghijklmnopqrstuvwxyz";

    for (int i = 0; i < count; i++) {
        if (buffer[i] == ' ' || ispunct(buffer[i])) {
            result[i] = buffer[i];
            continue;
        }
        
        char *e = strchr(allchars, buffer[i]);
        int idx= (int)(e - allchars);
        int new_idx = (idx + offset) % strlen(allchars);

        result[i] = allchars[new_idx];
    }

    return [NSString stringWithCharacters:result length:count];
}

- (NSString *)decode:(NSString *)string offset:(int)offset {
    return [self encode:string offset: (26 - offset)];
}


- (BOOL) checkSameString:(NSString *)decode withString:(NSString *)otherString {
    
    for (int i = 0; i < 26; i++) {
        NSString *encoded = [self encode:decode offset:i];
        BOOL equal = [encoded isEqualToString:otherString];
        if (equal) {
            return YES;
        }
    }
    
    return NO;
    
}
    
@end

    

int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
        CaesarCipher *cipher = [[CaesarCipher alloc] init];
      
        NSString *phrase1 = @"okmg";
        NSString *phrase2 = @"tprl";
        
        BOOL stringsAreSame = [cipher checkSameString:phrase1 withString:phrase2];
        NSLog(@"%d", stringsAreSame);
        
        
    }
}

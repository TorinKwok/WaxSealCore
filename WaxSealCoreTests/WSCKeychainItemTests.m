///:
/*****************************************************************************
 **                                                                         **
 **                               .======.                                  **
 **                               | INRI |                                  **
 **                               |      |                                  **
 **                               |      |                                  **
 **                      .========'      '========.                         **
 **                      |   _      xxxx      _   |                         **
 **                      |  /_;-.__ / _\  _.-;_\  |                         **
 **                      |     `-._`'`_/'`.-'     |                         **
 **                      '========.`\   /`========'                         **
 **                               | |  / |                                  **
 **                               |/-.(  |                                  **
 **                               |\_._\ |                                  **
 **                               | \ \`;|                                  **
 **                               |  > |/|                                  **
 **                               | / // |                                  **
 **                               | |//  |                                  **
 **                               | \(\  |                                  **
 **                               |  ``  |                                  **
 **                               |      |                                  **
 **                               |      |                                  **
 **                               |      |                                  **
 **                               |      |                                  **
 **                   \\    _  _\\| \//  |//_   _ \// _                     **
 **                  ^ `^`^ ^`` `^ ^` ``^^`  `^^` `^ `^                     **
 **                                                                         **
 **                       Copyright (c) 2015 Tong G.                        **
 **                          ALL RIGHTS RESERVED.                           **
 **                                                                         **
 ****************************************************************************/

#import <XCTest/XCTest.h>

#import "WSCKeychain.h"
#import "WSCApplicationPassword.h"
#import "WSCInternetPassword.h"
#import "WSCKeychainItem.h"
#import "NSURL+WSCKeychainURL.h"
#import "WSCKeychainError.h"
#import "WSCKeychainManager.h"

// --------------------------------------------------------
#pragma mark Interface of WSCKeychainItemTests case
// --------------------------------------------------------
@interface WSCKeychainItemTests : XCTestCase
@end

// --------------------------------------------------------
#pragma mark Implementation of WSCKeychainItemTests case
// --------------------------------------------------------
@implementation WSCKeychainItemTests

- ( void ) setUp
    {
    // TODO: Put setup code here. This method is called before the invocation of each test method in the class.
    }

- ( void ) tearDown
    {
    // TODO: Put teardown code here. This method is called after the invocation of each test method in the class.
    }

- ( void ) testSetCreationDate
    {
    NSError* error = nil;

    WSCKeychain* commonRandomKeychain = _WSCRandomKeychain();

    // ----------------------------------------------------------
    // Test Case 0
    // ----------------------------------------------------------
    WSCApplicationPassword* applicationPassword_testCase0 =
        [ commonRandomKeychain addApplicationPasswordWithServiceName: @"WaxSealCore: testSetCreationDate"
                                                         accountName: @"testSetCreationDate Test Case 0"
                                                            password: @"waxsealcore"
                                                               error: &error ];

    NSLog( @"Before modifying applicationPassword_testCase0: %@", [ applicationPassword_testCase0 creationDate ] );
    NSDate* newDate0_testCase0 = [ NSDate dateWithString: @"2018-12-20 10:45:32 +0800" ];
    [ applicationPassword_testCase0 setCreationDate: newDate0_testCase0 ];
//    XCTAssertEqualObjects( newDate0_testCase0, applicationPassword_testCase0.creationDate );
//    XCTAssertEqualObjects( [ newDate0_testCase0 descriptionWithCalendarFormat: nil timeZone: [ NSTimeZone localTimeZone ] locale: nil ]
//                         , applicationPassword_testCase0.creationDate.description
//                         );

    NSLog( @"After modifying applicationPassword_testCase0: %@", [ applicationPassword_testCase0 creationDate ] );
    NSDate* newDate1_testCase0 = [ NSDate distantFuture ];
    [ applicationPassword_testCase0 setCreationDate: newDate1_testCase0 ];
//    XCTAssertEqualObjects( newDate1_testCase0, applicationPassword_testCase0.creationDate );
//    XCTAssertEqualObjects( [ newDate1_testCase0 descriptionWithCalendarFormat: nil timeZone: [ NSTimeZone localTimeZone ] locale: nil ]
//                         , applicationPassword_testCase0.creationDate.description
//                         );

    NSLog( @"Modified again applicationPassword_testCase0: %@", [ applicationPassword_testCase0 creationDate ] );
    NSDate* newDate2_testCase0 = [ NSDate distantPast ];
    [ applicationPassword_testCase0 setCreationDate: newDate2_testCase0 ];
//    XCTAssertEqualObjects( newDate2_testCase0, applicationPassword_testCase0.creationDate );
//    XCTAssertEqualObjects( [ newDate2_testCase0 descriptionWithCalendarFormat: nil timeZone: [ NSTimeZone localTimeZone ] locale: nil ]
//                         , applicationPassword_testCase0.creationDate.description
//                         );

    NSLog( @"Modified again applicationPassword_testCase0: %@", [ applicationPassword_testCase0 creationDate ] );

    if ( applicationPassword_testCase0 )
        SecKeychainItemDelete( applicationPassword_testCase0.secKeychainItem );

    // ----------------------------------------------------------
    // Test Case 1
    // ----------------------------------------------------------
    WSCInternetPassword* internetPassword_testCase1 =
        [ commonRandomKeychain addInternetPasswordWithServerName: @"www.waxsealcore.org"
                                                 URLRelativePath: @"testSetCreationDate/test/case/0"
                                                     accountName: @"waxsealcore"
                                                        protocol: WSCInternetProtocolTypeHTTPS
                                                        password: @"waxsealcore"
                                                           error: &error ];

    NSLog( @"Before modifying internetPassword_testCase1: %@", [ internetPassword_testCase1 creationDate ] );
    [ internetPassword_testCase1 setCreationDate: [ NSDate date ] ];
    NSLog( @"After modifying internetPassword_testCase1: %@", [ internetPassword_testCase1 creationDate ] );

    // -----------------------------------------------------------------------------------------------
    // Negative Test Case 0: The keychain item: internetPassword_testCase1 has been already deleted
    // -----------------------------------------------------------------------------------------------
    if ( internetPassword_testCase1 )
        SecKeychainItemDelete( internetPassword_testCase1.secKeychainItem );

    NSLog( @"Before modifying internetPassword_testCase1: %@", [ internetPassword_testCase1 creationDate ] );
    [ internetPassword_testCase1 setCreationDate: [ NSDate dateWithNaturalLanguageString: @"1998-2-8 21:23:19 +0300" ] ];
    NSLog( @"Before modifying internetPassword_testCase1: %@", [ internetPassword_testCase1 creationDate ] );

    // -----------------------------------------------------------------------------------------------
    // Negative Test Case 1: The keychain: randomKeychain has been already deleted
    // -----------------------------------------------------------------------------------------------
    [ [ WSCKeychainManager defaultManager ] deleteKeychain: commonRandomKeychain
                                                     error: nil ];

    NSLog( @"Before modifying internetPassword_testCase1: %@", [ internetPassword_testCase1 creationDate ] );
    [ internetPassword_testCase1 setCreationDate: [ NSDate dateWithNaturalLanguageString: @"1998-2-8 21:23:19 +0300" ] ];
    NSLog( @"Before modifying internetPassword_testCase1: %@", [ internetPassword_testCase1 creationDate ] );
    }

- ( void ) testCreationDate
    {
    NSError* error = nil;

    // ----------------------------------------------------------
    // Test Case 0
    // ----------------------------------------------------------
    WSCApplicationPassword* applicationPassword_testCase0 =
        [ [ WSCKeychain login ] addApplicationPasswordWithServiceName: @"WaxSealCore"
                                                          accountName: @"Test Case 0"
                                                             password: @"waxsealcore"
                                                                error: &error ];
    XCTAssertNotNil( applicationPassword_testCase0.creationDate);
    NSLog( @"Creation Date: %@", applicationPassword_testCase0.creationDate );
    SecKeychainItemDelete( applicationPassword_testCase0.secKeychainItem );

    sleep( 2 );

    // ----------------------------------------------------------
    // Test Case 1
    // ----------------------------------------------------------
    WSCInternetPassword* internetPassword_testCase1 =
        [ [ WSCKeychain login ] addInternetPasswordWithServerName: @"www.waxsealcore.org"
                                                  URLRelativePath: @"NSTongG"
                                                      accountName: @"Tong Guo"
                                                         protocol: WSCInternetProtocolTypeHTTPS
                                                         password: @"waxsealcore"
                                                            error: &error ];
    XCTAssertNotNil( internetPassword_testCase1.creationDate);
    NSLog( @"Creation Date: %@", internetPassword_testCase1.creationDate );
    SecKeychainItemDelete( internetPassword_testCase1.secKeychainItem );

    // ----------------------------------------------------------
    // Negative Test Case 0
    // ----------------------------------------------------------
    WSCKeychain* randomKeychain_negativeTestCase0 = _WSCRandomKeychain();
    XCTAssertNotNil( randomKeychain_negativeTestCase0 );
    XCTAssertTrue( randomKeychain_negativeTestCase0.isValid );

    WSCKeychainItem* keychainItem_negativeTest0 =
        [ randomKeychain_negativeTestCase0 addInternetPasswordWithServerName: @"www.waxsealcore.org"
                                                             URLRelativePath: @"NSTongG"
                                                                 accountName: @"Tong Guo"
                                                                    protocol: WSCInternetProtocolTypeHTTPS
                                                                    password: @"waxsealcore"
                                                                       error: &error ];

    XCTAssertNotNil( keychainItem_negativeTest0.creationDate );
    XCTAssertTrue( keychainItem_negativeTest0.isValid );

    [ [ WSCKeychainManager defaultManager ] deleteKeychain: randomKeychain_negativeTestCase0
                                                     error: &error ];

    XCTAssertFalse( keychainItem_negativeTest0.isValid );
    XCTAssertFalse( randomKeychain_negativeTestCase0.isValid );
    XCTAssertNil( error );
    _WSCPrintNSErrorForUnitTest( error );

    XCTAssertNil( keychainItem_negativeTest0.creationDate );
    }

- ( void ) testIsValidProperty
    {
    // Test in testCreationDate test case.
    }

- ( void ) testItemClassProperty
    {
    NSError* error = nil;

    // ----------------------------------------------------------
    // Test Case 0
    // ----------------------------------------------------------
    WSCApplicationPassword* applicationPassword_testCase0 =
        [ [ WSCKeychain login ] addApplicationPasswordWithServiceName: @"WaxSealCore"
                                                          accountName: @"Test Case 0"
                                                             password: @"waxsealcore"
                                                                error: &error ];
    XCTAssertNotNil( applicationPassword_testCase0 );
    XCTAssertEqual( applicationPassword_testCase0.itemClass, WSCKeychainItemClassApplicationPasswordItem );
    XCTAssertNil( error );
    _WSCPrintNSErrorForUnitTest( error );
    if ( applicationPassword_testCase0 )
        SecKeychainItemDelete( applicationPassword_testCase0.secKeychainItem );

    // ----------------------------------------------------------
    // Test Case 1
    // ----------------------------------------------------------
    WSCInternetPassword* internetPassword_testCase1 =
        [ [ WSCKeychain login ] addInternetPasswordWithServerName: @"www.waxsealcore.org"
                                                  URLRelativePath: @"testCase1"
                                                      accountName: @"Test Case 1"
                                                         protocol: WSCInternetProtocolTypeHTTPS
                                                         password: @"waxsealcore"
                                                            error: &error ];

    XCTAssertNotNil( internetPassword_testCase1 );
    XCTAssertEqual( internetPassword_testCase1.itemClass, WSCKeychainItemClassInternetPasswordItem );
    XCTAssertNil( error );
    _WSCPrintNSErrorForUnitTest( error );
    if ( internetPassword_testCase1 )
        SecKeychainItemDelete( internetPassword_testCase1.secKeychainItem );

    // TODO: Waiting for more positive and negative test case
    }

@end // WSCKeychainItemTests test case

//////////////////////////////////////////////////////////////////////////////

/*****************************************************************************
 **                                                                         **
 **                                                                         **
 **      █████▒█    ██  ▄████▄   ██ ▄█▀       ██████╗ ██╗   ██╗ ██████╗     **
 **    ▓██   ▒ ██  ▓██▒▒██▀ ▀█   ██▄█▒        ██╔══██╗██║   ██║██╔════╝     **
 **    ▒████ ░▓██  ▒██░▒▓█    ▄ ▓███▄░        ██████╔╝██║   ██║██║  ███╗    **
 **    ░▓█▒  ░▓▓█  ░██░▒▓▓▄ ▄██▒▓██ █▄        ██╔══██╗██║   ██║██║   ██║    **
 **    ░▒█░   ▒▒█████▓ ▒ ▓███▀ ░▒██▒ █▄       ██████╔╝╚██████╔╝╚██████╔╝    **
 **     ▒ ░   ░▒▓▒ ▒ ▒ ░ ░▒ ▒  ░▒ ▒▒ ▓▒       ╚═════╝  ╚═════╝  ╚═════╝     **
 **     ░     ░░▒░ ░ ░   ░  ▒   ░ ░▒ ▒░                                     **
 **     ░ ░    ░░░ ░ ░ ░        ░ ░░ ░                                      **
 **              ░     ░ ░      ░  ░                                        **
 **                    ░                                                    **
 **                                                                         **
 ****************************************************************************/
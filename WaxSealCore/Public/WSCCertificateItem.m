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

#import <openssl/x509.h>
#import <openssl/objects.h>
#import <openssl/asn1.h>

#import "WSCCertificateItem.h"

#import "_WSCCertificateItemPrivate.h"

@implementation WSCCertificateItem

@dynamic commonName;
@dynamic issuerName;

@dynamic secCertificateItem;

#pragma mark Certificate Attributes

/* The common name of the subject of a certificate.
 */
- ( NSString* ) commonName
    {
    NSError* error = nil;
    OSStatus resultCode = errSecSuccess;

    NSString* cocoaCommonName = nil;
    CFStringRef secCommonName = NULL;
    if ( ( resultCode = SecCertificateCopyCommonName( self.secCertificateItem, &secCommonName ) ) == errSecSuccess )
        {
        if ( secCommonName )
            {
            cocoaCommonName = [ [ ( __bridge NSString* )secCommonName copy ] autorelease ];
            CFRelease( secCommonName );
            }
        else
            cocoaCommonName = @"";
        }
    else
        {
        _WSCFillErrorParamWithSecErrorCode( resultCode, &error );
        _WSCPrintNSErrorForLog( error );
        }

    return cocoaCommonName;
    }

/* The issuer name of a certificate.
 */
- ( NSString* ) issuerName
    {
    return _WSCSecCertificateGetIssuerName( self.secCertificateItem );
    }

#pragma mark Certificate, Key, and Trust Services Bridge

/* The reference of the `SecCertificate` opaque object, which wrapped by `WSCCertificateItem` object. (read-only)
 */
- ( SecCertificateRef ) secCertificateItem
    {
    return ( SecCertificateRef )( self->_secKeychainItem );
    }

@end // WSCCertificateItem class

//static NSString* _WSCSecCertificateGetStringValue( SecCertificateRef _SecCertificateRef
//                                                 , 

NSString* _WSCSecCertificateGetIssuerName( SecCertificateRef _SecCertificateRef )
    {
    NSData* certificateDERRepresentation = ( __bridge NSData* )SecCertificateCopyData( _SecCertificateRef );
    unsigned char const* DERRepresentationDataBytes = ( unsigned char const* )[ certificateDERRepresentation bytes ];
    X509* X509Certificate = d2i_X509( NULL, &DERRepresentationDataBytes, [ certificateDERRepresentation length ] );

    NSString* issuer = nil;
    if ( X509Certificate != NULL )
        {
        X509_NAME* issuerX509Name = X509_get_issuer_name( X509Certificate );

        if (issuerX509Name != NULL)
            {
            int nid = OBJ_txt2nid( "O" ); // organization
            int index = X509_NAME_get_index_by_NID( issuerX509Name, nid, -1 );

            X509_NAME_ENTRY* issuerNameEntry = X509_NAME_get_entry( issuerX509Name, index );

            if ( issuerNameEntry )
                {
                ASN1_STRING* issuerNameASN1 = X509_NAME_ENTRY_get_data( issuerNameEntry );

                if ( issuerNameASN1 != NULL )
                    {
                    unsigned char* issuerName = ASN1_STRING_data( issuerNameASN1 );
                    issuer = [ NSString stringWithUTF8String: ( char* )issuerName ];
                    }
                }
            }
        }

    return issuer;
    }

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
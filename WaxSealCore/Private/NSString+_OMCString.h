/*──────────────────────────────────────────────────────────────────────────────┐
│               _    _      _                            _                      │  
│              | |  | |    | |                          | |                     │██
│              | |  | | ___| | ___ ___  _ __ ___   ___  | |_ ___                │██
│              | |/\| |/ _ \ |/ __/ _ \| '_ ` _ \ / _ \ | __/ _ \               │██
│              \  /\  /  __/ | (_| (_) | | | | | |  __/ | || (_) |              │██
│               \/  \/ \___|_|\___\___/|_| |_| |_|\___|  \__\___/               │██
│                                                                               │██
│                                                                               │██
│          _    _            _____            _ _____                _          │██
│         | |  | |          /  ___|          | /  __ \              | |         │██
│         | |  | | __ ___  _\ `--.  ___  __ _| | /  \/ ___  _ __ ___| |         │██
│         | |/\| |/ _` \ \/ /`--. \/ _ \/ _` | | |    / _ \| '__/ _ \ |         │██
│         \  /\  / (_| |>  </\__/ /  __/ (_| | | \__/\ (_) | | |  __/_|         │██
│          \/  \/ \__,_/_/\_\____/ \___|\__,_|_|\____/\___/|_|  \___(_)         │██
│                                                                               │██
│                                                                               │██
│                                                                               │██
│                          Copyright (c) 2015 Tong Guo                          │██
│                                                                               │██
│                              ALL RIGHTS RESERVED.                             │██
│                                                                               │██
└───────────────────────────────────────────────────────────────────────────────┘██
  █████████████████████████████████████████████████████████████████████████████████
  ███████████████████████████████████████████████████████████████████████████████*/

#define COMPARE_WITH_CASE_INSENSITIVE( _Lhs, _Rhs )                                 \
    ( [ _Lhs compare: _Rhs options: NSCaseInsensitiveSearch ] == NSOrderedSame )    \

// NSString + OMCCalculation
@interface NSString ( _OMCString )

- ( BOOL ) contains: ( NSString* )_SubString;

- ( BOOL ) endingAs: ( NSString* )_String;

@end // NSString + _OMCString

//////////////////////////////////////////////////////////////////////////////

/*****************************************************************************
 **                                                                         **
 **      _________                                      _______             **
 **     |___   ___|                                   / ______ \            **
 **         | |     _______   _______   _______      | /      |_|           **
 **         | |    ||     || ||     || ||     ||     | |    _ __            **
 **         | |    ||     || ||     || ||     ||     | |   |__  \           **
 **         | |    ||     || ||     || ||     ||     | \_ _ __| |  _        **
 **         |_|    ||_____|| ||     || ||_____||      \________/  |_|       **
 **                                           ||                            **
 **                                    ||_____||                            **
 **                                                                         **
 ****************************************************************************/
///:~
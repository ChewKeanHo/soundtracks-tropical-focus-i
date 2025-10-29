#!/bin/sh
# Copyright 2024 (Holloway) Chew, Kean Ho <hello@hollowaykeanho.com>
# Copyright 2023 (Holloway) Chew, Kean Ho <hollowaykeanho@gmail.com>
#
#
# Licensed under (Holloway) Chew, Kean Ho's Liberal License (the 'License').
# You must comply with the license to use the content. Get the License at:
#
# https://doi.org/10.5281/zenodo.13770769
#
# You MUST ensure any interaction with the content STRICTLY COMPLIES with
# the permissions and limitations set forth in the license.




# import required libraries
. "${LIBS_HESTIA}/HestiaKERNEL/Init.sh" 2> /dev/null
command -v Hestia_Import > /dev/null
if [ $? -ne 0 ]; then
        1>&2 printf -- "%s" "\
E: Missing 'HestiaKERNEL/Init.sh' - Hestia_Import function.
E: Unable to Proceed.
E: Bailing Out...

"
        exit 1
fi

Hestia_Import "\
HestiaKERNEL/HestiaSIGNALS/Codes.sh
HestiaKERNEL/HestiaUNICODES/Is-Unicode.sh
"
if [ $? -ne 0 ]; then
        exit 1
fi




HestiaUNICODES_Has() {
        #____content_unicode="$1"
        #____char_unicode="$2"


        # validate input
        if [ $(HestiaUNICODES_Is_Unicode "$1") -ne $HestiaSIGNALS_OK ]; then
                printf -- "%s" "$HestiaSIGNALS_ENTITY_EMPTY"
                return $HestiaSIGNALS_ENTITY_EMPTY
        fi

        if [ $(HestiaUNICODES_Is_Unicode "$2") -ne $HestiaSIGNALS_OK ]; then
                printf -- "%s" "$HestiaSIGNALS_DATA_EMPTY"
                return $HestiaSIGNALS_DATA_EMPTY
        fi


        # execute
        ____content_unicode="$1"
        ____char_unicode="$2"
        while [ ! "$____content_unicode" = "" ]; do
                # get current character
                ____current="${____content_unicode%%, *}"
                ____content_unicode="${____content_unicode#"$____current"}"
                if [ "${____content_unicode%"${____content_unicode#?}"}" = "," ]; then
                        ____content_unicode="${____content_unicode#, }"
                fi

                # get target character
                ____char="${____char_unicode%%, *}"
                ____char_unicode="${____char_unicode#"$____char"}"
                if [ "${____char_unicode%"${____char_unicode#?}"}" = "," ]; then
                        ____char_unicode="${____char_unicode#, }"
                fi

                # FAIL - reset ____char_unicode
                if [ ! "$____current" = "$____char" ]; then
                        ____char_unicode="$2"
                        continue
                fi

                # PASS - fully matched
                if [ "$____current" = "$____char" ] && [ "$____char_unicode" = "" ]; then
                        unset ____current ____char ____content_unicode ____char_unicode
                        printf -- "%d" "$HestiaSIGNALS_OK"
                        return $HestiaSIGNALS_OK
                fi
        done
        unset ____current ____char ____content_unicode ____char_unicode


        # report status
        printf -- "%d" "$HestiaSIGNALS_DATA_MISMATCHED"
        return $HestiaSIGNALS_DATA_MISMATCHED
}




# report import status
return 0

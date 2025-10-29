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
HestiaKERNEL/HestiaUNICODES/Codes.sh
"
if [ $? -ne 0 ]; then
        exit 1
fi




HestiaOS_Get_Encoder_String() {
        # execute
        case "${LANG##*.}" in
        "UTF-8")
                printf -- "%b" "$HestiaUNICODES_UTF8"
                return $HestiaSIGNALS_OK
                ;;
        "UTF-16")
                printf -- "%b" "$HestiaUNICODES_UTF16BE"
                return $HestiaSIGNALS_OK
                ;;
        "UTF-32")
                printf -- "%b" "$HestiaUNICODES_UTF32BE"
                return $HestiaSIGNALS_OK
                ;;
        *)
                ;;
        esac

        case "${LC_ALL##*.}" in
        "UTF-8")
                printf -- "%b" "$HestiaUNICODES_UTF8"
                return $HestiaSIGNALS_OK
                ;;
        "UTF-16")
                printf -- "%b" "$HestiaUNICODES_UTF16BE"
                return $HestiaSIGNALS_OK
                ;;
        "UTF-32")
                printf -- "%b" "$HestiaUNICODES_UTF32BE"
                return $HestiaSIGNALS_OK
                ;;
        *)
                printf -- "%b" "$HestiaUNICODES_UTF_UNKNOWN"
                return $HestiaSIGNALS_OK
                ;;
        esac
}




# report import status
return 0

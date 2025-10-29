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
"
if [ $? -ne 0 ]; then
        exit 1
fi




HestiaFS_List_Block_Devices() {
        # execute
        if [ -d "/sys/class/block" ]; then
                ____list=""
                for ____device in "/sys/class/block/"*; do
                        if [ ! -e "$____device" ]; then
                                continue
                        fi

                        if [ -e "${____device}/partition" ]; then
                                continue
                        fi

                        ____device="${____device##*/}"
                        case "$____device" in
                        dm-*|loop*|ram*|sr*)
                                continue
                                ;;
                        *)
                                ____device="/dev/${____device}"
                                if [ ! -e "$____device" ]; then
                                        continue
                                fi

                                ;;
                        esac

                        ____list="${____list}${____device}\n"
                done
                unset ____device

                # output results
                printf -- "%b" "$____list"
                if [ "$____list" = "" ]; then
                        unset ____list
                        return $HestiaSIGNALS_BAD_EXEC
                fi

                # report status
                return $HestiaSIGNALS_OK
        fi


        # report status
        printf -- "%s" ""
        return $HestiaSIGNALS_UNSUPPORTED
}




# report import status
return 0

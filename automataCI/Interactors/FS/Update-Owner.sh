#!/bin/sh
# Copyright 2025 (Holloway) Chew, Kean Ho <hello@hollowaykeanho.com>
#
#
# Licensed under (Holloway) Chew, Kean Ho's Proprietary License (the 'License').
# You must comply with the license to use the content. Get the License at:
#
# https://doi.org/10.5281/zenodo.13767361
#
# DO NOT SOURCE, USE, READ, MODIFY, REPRODUCE, DISTRIBUTE, RE-DISTRIBUTE,
# REVERSE ENGINEER, OR ANY OTHER ACTIONS WITH ANY PART OF THE CONTENT WITHOUT
# WRITTEN AND RATIFIED CONSENT from the copyright owners, unless the license
# explicitly allowing it.




Interactors_FS_Update_Owner() {
        #____path_target="$1"
        #____owner_digits="$2"
        #____group_digits="$3"


        # execute
        HestiaFS_Update_Owner "$1" "$2" "$3"
        if [ $? -ne $HestiaSIGNALS_OK ]; then
                return 1
        fi


        # report status
        return 0
}




# report import status
return 0

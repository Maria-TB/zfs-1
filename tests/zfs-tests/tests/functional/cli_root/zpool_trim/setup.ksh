#!/bin/ksh -p
#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License (the "License").
# You may not use this file except in compliance with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END
#

#
# Copyright (c) 2016 by Delphix. All rights reserved.
# Copyright (c) 2019 by Lawrence Livermore National Security, LLC.
#

. $STF_SUITE/include/libtest.shlib

verify_runnable "global"

DISK1=${DISKS%% *}

typeset -i max_discard=0
if is_linux; then
	if [[ -b $DEV_RDSKDIR/$DISK1 ]]; then
		max_discard=$(lsblk -Dbn $DEV_RDSKDIR/$DISK1 | awk '{ print $4; exit }')
	fi
fi

if is_osx; then
	max_discard=1
fi

if test $max_discard -eq 0; then
	log_unsupported "DISKS do not support discard (TRIM/UNMAP)"
fi

log_pass

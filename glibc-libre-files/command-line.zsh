#
# Copyright © 2025 Barry Schwartz
#
# This program is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License, as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received copies of the GNU General Public License
# along with this program. If not, see
# <https:#www.gnu.org/licenses/>.
#

function print_usage
{
    printf "Usage: ${program_name} BRANCH_OR_TAG\n"
    printf "       ${program_name} -- BRANCH_OR_TAG\n"
    printf "       ${program_name}\n"
    printf "       ${program_name} -r REVISION\n"
    printf "       ${program_name} --revision REVISION\n"
    printf "       ${program_name} -h\n"
    printf "       ${program_name} --help\n"
    printf "\n"
    printf "The first and second form check out by branch or\n"
    printf "tag. The third form updates an existing repository’s\n"
    printf "current branch. The fourth and fifth forms check\n"
    printf "out a particular commit, given its hash. The -h\n"
    printf "and --help options print this message.\n"
}

branch=
revision=
if [[ "${1}" = "-h" ]] || [[ "${1}" = "--help" ]]; then
   print_usage
   exit 0
elif [[ 3 -le $# ]]; then
    print_usage
    exit 1
elif [[ $# = 1 ]]; then
    branch="${1:?branch or tag not specified}"
elif [[ $# = 0 ]]; then
    :
elif [[ "${1}" = "--" ]]; then
    branch="${2:?branch or tag not specified}"
elif [[ "${1}" = "-r" ]] || [[ "${1}" = "--revision" ]] ; then
    revision="${2:?revision not specified}"
else
    print_usage
    exit 1
fi

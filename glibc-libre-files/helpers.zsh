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

local_repo="/var/tmp/glibc-libre/nixpkgs"
nixpkgs_url="https://github.com/NixOS/nixpkgs.git"

function stamp
{
    date +%Y.%m.%d.%H.%M.%S
}

function want_repo_pull
{
    test -z "${branch}${revision}"
}

function local_repo_specifier
{
    if [[ -n "${branch}" ]]; then
        printf "--branch=%s" "${branch}"
    else
        printf "--revision=%s" "${revision}"
    fi
}

function clone_the_local_repo
{
    local dirnm=`dirname "${local_repo}"`
    local basnm=`basename "${local_repo}"`
    local spec=`local_repo_specifier`

    mkdir -p "${dirnm}"
    (cd "${dirnm}" &&
         git clone --depth=1 "${spec}" "${nixpkgs_url}" "${basnm}")
}

function update_the_local_repo
{
    (cd "${local_repo}" && git pull --depth=1)
}

function require_the_local_repo
{
    printf "Local repository at %s\n" "${local_repo}"
    if ! want_repo_pull; then
        rm -R -f "${local_repo}"
        clone_the_local_repo
    elif [[ -d "${local_repo}" ]]; then
        update_the_local_repo
    else
        print_usage
        exit 1
    fi
}

function awk_edit
{
    nawk "${1}" < "${2}" > "${2}".tmp && mv "${2}"{.tmp,}
}

/*
    This file is part of RIBS2.0 (Robust Infrastructure for Backend Systems).
    RIBS is an infrastructure for building great SaaS applications (but not
    limited to).

    Copyright (C) 2012 Adap.tv, Inc.

    RIBS is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation, version 2.1 of the License.

    RIBS is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with RIBS.  If not, see <http://www.gnu.org/licenses/>.
*/

#ifndef _MYSQL_COMMON__H_
#define _MYSQL_COMMON__H_

#include "ribs_defs.h"

struct mysql_login_info {
    const char *host;
    const char *user;
    const char *pass;
    const char *db;
    unsigned int port;
};

size_t ribs_mysql_get_storage_size(int type, size_t length);
const char *ribs_mysql_get_type_name(int type);
void ribs_mysql_mask_db_pass(char *str);
int ribs_mysql_parse_db_conn_str(char *str, struct mysql_login_info *info);

#endif // _MYSQL_COMMON__H_

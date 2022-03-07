/*********************************************************************
 * Copyright (C) 2017-2022 Xilinx, Inc.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin St, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 *
 ********************************************************************/

#include "video_cfg.h"
#include <QString>
struct v_source {
    vlib_dev_type src;
    const char *short_name;
};
static struct v_source vsrc_tbl[] = {

{HDMI_1, "HDMI-Rx"},
{CSI, "MIPI"},
{TPG_1, "TPG"},
};
int sources_count(){
    return ARRAY_SIZE(vsrc_tbl);
}
const char * get_name_of_source_at(int index){
    return vsrc_tbl[index].short_name;
}
int get_by_name(const char *name) {
    for (unsigned int i = 0; i < ARRAY_SIZE(vsrc_tbl); i++) {
        if ((QString :: compare(QString(name), QString(vsrc_tbl[i].short_name), Qt::CaseInsensitive)) == 0) {
            return vsrc_tbl[i].src;
        }
    }
    return 0;
}

/*********************************************************************
 * Copyright (C) 2017-2022 Xilinx, Inc.
 * Copyright (C) 2022-2024 Advanced Micro Devices, Inc.
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

#include "dirop.h"
#include <QDebug>

QVariantList DirOp:: listDirectory(QString fileType){

    currentDir.setFilter(QDir :: Dirs | QDir::Files);
    QFileInfoList list = currentDir.entryInfoList();

    if(fileType != ""){
        currentDir.setNameFilters(QStringList()<<fileType);
        list = currentDir.entryInfoList();
    }

    QVariantList qfileList;
    for(int i = 0; i < list.size(); i++){

        QVariantMap map;
        map.insert("itemName", list.at(i).fileName());
        map.insert("itemType", list.at(i).isDir()? QVariant(true):false);

        qfileList.append(map);
    }
    return qfileList;
}

QVariantList DirOp:: previousClick(){
    currentDir.cdUp();
    return listDirectory("");
}
QVariantList DirOp ::changeFolder(QString dir){
    currentDir.cd(dir);
    return listDirectory("");
}

QString DirOp :: getFilePath(){
    return currentDir.absolutePath();
}

QVariantList DirOp ::applyTypeFilter(QString fileType){
    return listDirectory(fileType);
}

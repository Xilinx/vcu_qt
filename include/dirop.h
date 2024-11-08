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

#ifndef DIROP_H
#define DIROP_H
#include <QObject>
#include <QDir>
#include <QQuickItem>

class DirOp : public QObject
{
    Q_OBJECT
public:
    QDir currentDir;
    QQuickItem *ctx;

public slots :
    QVariantList listDirectory(QString);
    QVariantList previousClick();
    QVariantList changeFolder(QString);
    QVariantList applyTypeFilter(QString);
    QString getFilePath();
};

#endif // DIROP_H

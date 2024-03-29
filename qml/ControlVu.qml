/*********************************************************************
 * Copyright (C) 2017-2022 Xilinx, Inc.
 * Copyright (C) 2022-2023 Advanced Micro Devices, Inc.
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

/*
 * This file defines video QT application Drop down scroll view custom component.
 */

import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.0
import QtQuick.Layouts 1.0

Rectangle{
    property alias listModel: repeateListControl
    property int selecteItem: 0
    property var delgate: this
    height: repeateListControl.count
    anchors.topMargin: 0
    anchors.leftMargin: 0
    id: ctrlVu

    Behavior on height{
        NumberAnimation {
            duration: 0
            easing.type: Easing.Linear
        }
    }
    ColumnLayout{
        spacing: 0
        Repeater{
            id: repeateListControl
            Rectangle{
                Text {
                    text: modelData.shortName
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                }
                width: ctrlVu.width
                height: 20
                color: selecteItem === index ? root.cellHighlightColor : root.cellColor

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onClicked:{

                        for(var i = 0; i< repeateListControl.count; i++){
                            repeateListControl.itemAt(i).color = root.cellColor
                        }
                        parent.color = root.cellHighlightColor
                        delgate.clicked(index)
                    }
                }
            }
        }
    }
    function resetSource(index){
        for(var i = 0; i< repeateListControl.count; i++){
            if(i === index){
                repeateListControl.itemAt(i).color = root.cellHighlightColor
            }
            else{
                repeateListControl.itemAt(i).color = root.cellColor
            }
        }
    }
}

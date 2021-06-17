/*********************************************************************
 * Copyright (C) 2017-2021 Xilinx, Inc.
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
    property alias listModel: repeateListOutput
    property int selecteItem: 0
    property var delgate: this

    height: repeateListOutput.count
    anchors.topMargin: 0
    anchors.leftMargin: 0
    id: outputVu

    Behavior on height{
        NumberAnimation {
            duration: 0
            easing.type: Easing.Linear
        }
    }
    ColumnLayout{
        spacing: 0
        Repeater{
            id: repeateListOutput
            Rectangle{
                Text {
                    text: modelData.shortName
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                }
                width: outputVu.width
                height: 20
                color: selecteItem === index ? root.cellHighlightColor : root.cellColor

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onClicked:{

                        for(var i = 0; i< repeateListOutput.count; i++){
                            repeateListOutput.itemAt(i).color = root.cellColor
                        }
                        parent.color = root.cellHighlightColor
                        delgate.clicked(index)
                    }
                }
            }
        }
    }
    function resetSource(index){
        for(var i = 0; i< repeateListOutput.count; i++){
            if(i === index){
                repeateListOutput.itemAt(i).color = root.cellHighlightColor
            }
            else{
                repeateListOutput.itemAt(i).color = root.cellColor
            }
        }
    }
}

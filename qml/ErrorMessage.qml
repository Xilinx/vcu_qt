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
 * This file defines video QT application Error message custom component.
 */

import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.0
import QtQuick.Layouts 1.0

Rectangle{
    property var messageText: ""
    property var errorName: ""
    property alias message: okMouseArea

    color: "#09ffffff"
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
    }
    visible: messageText.length
    Rectangle{
        anchors.centerIn: parent
        id: errorHolderPopup
        color: root.barColors
        width: 500
        height: 150
        border.color: root.borderColors
        border.width: root.boarderWidths
        Rectangle{
            anchors.top: parent.top
            width: parent.width
            height: 30
            color: root.barTitleColorsPut
            id: baseErrorPopupHeader
            Label{
                text: errorName
                anchors.leftMargin: 16
                anchors.left: parent.left
                font.pixelSize: 16
                font.bold: true
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Rectangle{
            anchors.top: baseErrorPopupHeader.bottom
            width: parent.width
            height: parent.height - baseErrorPopupHeader.height
            color: "#ffffff"
            Rectangle{
                anchors.left: parent.left
                anchors.leftMargin: 20 * 1
                width: parent.width - 40
                anchors.top: parent.top
                anchors.topMargin: 20 * 1
                color: "transparent"
                height: parent.height - (40 * 1)
                Text {
                    anchors.left: parent.left
                    id: errorMessageLbl
                    text: messageText
                    font.pointSize: 13 * 1
                    width: parent.width - 20
                    height: parent.height - 20
                    anchors.top: parent.top
                    wrapMode: Text.WordWrap

                }

                Rectangle{
                    width: 60
                    height: 20
                    anchors.top: parent.top
                    anchors.topMargin: 60 * 1
                    anchors.right: parent.right
                    anchors.rightMargin: 20 * 1
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: "#f0f0f0"
                        }

                        GradientStop {
                            position: 1
                            color: "#505050"
                        }
                    }

                    MouseArea{
                        id: okMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                    }
                    Text {
                        color: "black"
                        anchors.centerIn: parent
                        anchors.leftMargin: 5
                        text:"OK"
                        font.pixelSize: 13 * 1

                    }
                }
            }
        }
    }
}

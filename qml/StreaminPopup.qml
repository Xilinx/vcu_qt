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

import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
Rectangle{
    id: streamInPopupDlg
    anchors.fill: parent
    color: "transparent"
    MouseArea{
        anchors.fill: parent
        onClicked: quertyKeyPad.visible = false
    }
    property var tempVideoInput: configuration.videoInput
    property var uriTextString: uriText.text
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        border.color: "gray"
        border.width: 1
        radius: 10
        width: 470
        height: 450
        Label{
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 5
            text: "Stream-In Settings"
            width: parent.width - 40
            height: 20
        }
        Rectangle{
            anchors.top: parent.top
            anchors.topMargin: 30
            width: parent.width
            height: 1
            color: "gray"
        }
        Button{
            id:okButton
            anchors.right: parent.right
            anchors.rightMargin: 70
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            width: 70
            height: 20
            text: "Ok"
            style: ButtonStyle{
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 25
                    border.width: control.activeFocus ? 2 : 1
                    border.color: "#888"
                    radius: 4
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: (root.play && root.invertColor && (root.sinkType === 1)) ? "red" : (control.pressed ? "#ccc" : "#eee") }
                        GradientStop { position: 1 ; color: (root.play && !root.invertColor && (root.sinkType === 1)) ? "red" : (control.pressed ? "#aaa" : "#ccc") }
                    }
                }
            }
            onClicked: {
                settingsArray[settingsIndex].uri = uriText.text
                streamInPopupDlg.visible = false
                quertyKeyPad.visible = false
            }
        }
        Button {
            id: cancelButton
            anchors{
                right: okButton.left
                rightMargin: 50
                bottom: parent.bottom
                bottomMargin: 20
            }
            width: 80
            height: 22
            text: qsTr("Cancel")
            style: ButtonStyle{
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 25
                    border.width: control.activeFocus ? 2 : 1
                    border.color: "#888"
                    radius: 4
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: (root.play && root.invertColor && (root.sinkType === 1)) ? "red" : (control.pressed ? "#ccc" : "#eee") }
                        GradientStop { position: 1 ; color: (root.play && !root.invertColor && (root.sinkType === 1)) ? "red" : (control.pressed ? "#aaa" : "#ccc") }
                    }
                }
            }
            onClicked:{
                uriText.text = settingsArray[settingsIndex].uri
                quertyKeyPad.visible = false
                streamInPopupDlg.visible = false
                ipSetingsPopup.repeaterModel = root.numSrc
            }
        }
        Label{
            id: uriLbl
            anchors{
                left:  parent.left
                leftMargin: 50
                top: parent.top
                topMargin: 150
            }
            width: 50
            height: 25
            verticalAlignment: Text.AlignVCenter
            text: "Uri"
        }
        TextField{
            id: uriText
            anchors{
                left:  uriLbl.right
                leftMargin: 1
                top: parent.top
                topMargin: 150
            }
            width: 280
            height: 25
            verticalAlignment: Text.AlignVCenter
            enabled: true
            onTextChanged: {
                presetChangeStatus = true
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    quertyKeyPad.visible =  !quertyKeyPad.visible
                    quertyKeyPad.textToEdit = uriText
                }
            }
        }
    }
}

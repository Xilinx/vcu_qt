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
import QtQuick 2.0
Rectangle{
    width: parent.width-6
    height: parent.height-110
    color: "transparent"
    property bool validHostIp: true
    property bool validPortNumber: true
    property alias tmpHostIP: hostIpTxt.text
    property alias tmpPort: portTxt.text
    MouseArea{
        anchors.fill: parent
        onClicked: keyPad.visible = false
    }

    Column{
        anchors.top: parent.top
        anchors.topMargin: 10
        spacing: 10
        height: 300
        width: parent.width
        Rectangle{
            width: parent.width
            height: 25
            color: "transparent"

            Label{
                id: sinkLbl
                anchors{
                    left:  parent.left
                    leftMargin: 10
                    top: parent.top
                }
                width: 140
                height: 25
                verticalAlignment: Text.AlignVCenter
                text: "SINK: "
            }
            TextField{
                id: sinkTxt
                anchors{
                    left: sinkLbl.right
                    leftMargin: 5
                    top: parent.top
                }
                width: 125
                height: 25
                text: "PS Ethernet"
                enabled: !root.raw
                MouseArea{
                    anchors.fill: parent
                    onClicked: {

                    }
                }
            }

            Button {
                anchors{
                    left: sinkTxt.right
                    leftMargin: -2
                    top: parent.top
                }
                width: sinkTxt.height
                height: sinkTxt.height
                Image{
                    anchors.fill: parent
                    source: "qrc:///images/downArrow.png"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {

                    }
                }
            }
        }

        Rectangle{
            width: parent.width
            height: 25
            color: "transparent"

            Label{
                id: hostIpLbl
                anchors{
                    left:  parent.left
                    leftMargin: 10
                    top: parent.top
                }
                width: 140
                height: 25
                verticalAlignment: Text.AlignVCenter
                text: "Host IP: "
            }
            TextField{
                id: hostIpTxt
                anchors{
                    left:  hostIpLbl.right
                    leftMargin: 5
                    top: parent.top
                }
                width: 150
                height: 25
                verticalAlignment: Text.AlignVCenter
                enabled: !root.raw
                onTextChanged: {
                    presetChangeStatus = true
                    validHostIp = controller.validateHostIp(hostIpTxt.text)
                    getErrorMsg()
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        keyPad.requireDot = true
                        keyPad.visible =  !keyPad.visible
                        keyPad.textToEdit = hostIpTxt
                        keyPad.anchors.topMargin = 140
                    }
                }
            }
        }

        Rectangle{
            width: parent.width
            height: 25
            color: "transparent"

            Label{
                id: ipLbl
                anchors{
                    left:  parent.left
                    leftMargin: 10
                    top: parent.top
                }
                width: 140
                height: 25
                verticalAlignment: Text.AlignVCenter
                text: "IP: "
            }
            Label{
                id: ipTxt
                anchors{
                    left:  ipLbl.right
                    leftMargin: 5
                    top: parent.top
                }
                width: 150
                height: 25
                text: root.isStreamUp ? root.ipAddress : "Not Connected"
                verticalAlignment: Text.AlignVCenter
                enabled: !root.raw
                MouseArea{
                    anchors.fill: parent
                    onClicked: {

                    }
                }
            }
        }

        Rectangle{
            width: parent.width
            height: 25
            color: "transparent"

            Label{
                id: portLbl
                anchors{
                    left:  parent.left
                    leftMargin: 10
                    top: parent.top
                }
                width: 140
                height: 25
                verticalAlignment: Text.AlignVCenter
                text: "Port: "
            }
            TextField{
                id: portTxt
                anchors{
                    left:  portLbl.right
                    leftMargin: 5
                    top: parent.top
                }
                width: 150
                height: 25
                verticalAlignment: Text.AlignVCenter
                enabled: !root.raw
                onTextChanged: {
                    presetChangeStatus = true
                    if(portTxt.text.length <= 0){
                        validPortNumber = false
                    }else{
                        validPortNumber = true
                    }
                    getErrorMsg()
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        keyPad.requireDot = false
                        keyPad.visible =  !keyPad.visible
                        keyPad.textToEdit = portTxt
                        keyPad.anchors.topMargin = 210
                    }
                }
            }
        }
    }
    function getErrorMsg(){
        validation = validHostIp && validPortNumber
        if(!validHostIp){
            errorLbl.text = "Invalid Host Ip"
        }
        if(!validPortNumber){
            errorLbl.text = "Invalid Port Number"
        }
    }
}

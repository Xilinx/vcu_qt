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

import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
Rectangle{
    width: parent.width-6
    height: parent.height-110
    color: "transparent"

    property alias audGrp: audioEnableGroup
    property alias formatGrp: format.text
    property alias samplingGrp: samplingRate.text
    property alias tmpvolumeLevel: volumeLevelSlider.value
    property alias audioChannelGrp: audioChannel.text


    MouseArea{
        anchors.fill: parent
        onClicked: keyPad.visible = false
    }
    Label {
        id: audioEnableLbl
        anchors.topMargin: 10
        anchors{
            left: parent.left
            leftMargin: 10
            top: parent.top
        }
        width: 140
        height: 25
        verticalAlignment: Text.AlignVCenter
        text: qsTr("Enable Audio: ")
    }
    Row{
        id:audioRows
        anchors.topMargin: 10
        anchors{
            left: audioEnableLbl.right
            leftMargin: 5
            top: parent.top
        }
        height: 25
        spacing: 20
        ExclusiveGroup{
            id: audioEnableGroup
        }

        RadioButton{
            id: audioEnable
            text: "True"
            exclusiveGroup: audioEnableGroup
            width: 80
            height: parent.height
            objectName: "1"
            onCheckedChanged: {
                if(checked){
                    presetChangeStatus = true
                }
            }
        }

        RadioButton{
            id: audioDisable
            width: 80
            height: parent.height
            text: "False"
            checked: true
            exclusiveGroup: audioEnableGroup
            objectName: "0"
            onCheckedChanged: {
                if(checked){
                    presetChangeStatus = false
                }
            }
        }
    }
    Label{
        id: sourceLbl
        anchors.top: audioEnableLbl.bottom
        anchors.topMargin: 10
        anchors{
            left:  parent.left
            leftMargin: 10
            top: parent.top
        }
        width: 140
        height: 25
        verticalAlignment: Text.AlignVCenter
        text: "Source: "
    }
    Rectangle{
        id:sourceCheckbox
        width: 110
        height: 25
        color:"gray"
        border.color: "black"
        border.width: 1
        anchors.top:audioRows.bottom
        anchors.topMargin: 10
        property var showList: false
        radius: 2
        anchors{
            left:sourceLbl.right
            leftMargin: 5
        }

        MouseArea{
            anchors.fill: parent
            enabled: audioEnable.checked
            onClicked: {
                sourceOutputRectangle.visible = !sourceOutputRectangle.visible
                sourceCheckbox.showList = !sourceCheckbox.showList
                renderOutputRectangle.visible =false

            }

        }
        Label{
            id: outputLbl
            anchors.left: parent.left
            anchors.leftMargin: 10
            height: parent.height
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: audioSourceList[root.outputSelect].shortName
        }
        Image{
            anchors.right: parent.right
            anchors.rightMargin: 5
            width: parent.height
            height: parent.height
            source: sourceCheckbox.showList ? "qrc:///images/upArrow.png" : "qrc:///images/downArrow.png"
        }
    }
    Label{
        id: renderLbl
        anchors.top:sourceLbl.bottom
        anchors.topMargin: 10
        anchors{
            left:  parent.left
            leftMargin: 10
            top: parent.top
        }
        width: 140
        height: 25
        verticalAlignment: Text.AlignVCenter
        text: "Render: "
    }
    Rectangle{
        id:renderCheckbox
        width: 110
        height: 25
        color:"gray"
        border.color: "black"
        border.width: 1
        anchors.top:sourceCheckbox.bottom
        property var showList: false
        anchors.topMargin: 10
        radius: 2
        anchors{
            left:renderLbl.right
            leftMargin: 5
        }

        MouseArea{
            anchors.fill: parent
            enabled: audioEnable.checked
            onClicked: {
                renderOutputRectangle.visible = !renderOutputRectangle.visible
                renderCheckbox.showList = !renderCheckbox.showList
                sourceOutputRectangle.visible = false

            }

        }
        Label{
            id: renderOutputLbl
            anchors.left: parent.left
            anchors.leftMargin: 10
            height: parent.height
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: audioRenderList[root.outputSelect].shortName
        }
        Image{
            anchors.right: parent.right
            anchors.rightMargin: 5
            width: parent.height
            height: parent.height
            source: renderCheckbox.showList ? "qrc:///images/upArrow.png" : "qrc:///images/downArrow.png"
        }
    }
    Label{
        id: formatLbl
        anchors.topMargin: 10
        anchors.top:renderLbl.bottom
        anchors{
            left:  parent.left
            leftMargin: 10
            top: parent.top
        }
        width: 140
        height: 25
        verticalAlignment: Text.AlignVCenter
        text: "Format: "
    }
    Row{
        id:formatCheckBox
        anchors.topMargin: 10
        anchors.top: renderCheckbox.bottom
        anchors{
            left:  formatLbl.right
            leftMargin: 5
            top: parent.top
        }
        height: 25
        spacing: 20
        ExclusiveGroup{
            id: formatGroup
        }
        RadioButton{
            id: format
            width: 80
            text: "S24_32LE"
            exclusiveGroup: formatGroup
            checked: true
            onCheckedChanged: {
                if(checked){
                    presetChangeStatus = true
                }
            }
        }
    }
    Label{
        id: audioChannelLbl
        anchors.topMargin: 10
        anchors.top: formatLbl.bottom
        anchors{
            left:  parent.left
            leftMargin: 10
            top: parent.top
        }
        width: 140
        height: 25
        verticalAlignment: Text.AlignVCenter
        text: "Channel: "
    }
    Row{
        id:audioChannelCheckBox
        anchors.topMargin: 10
        anchors.top: formatCheckBox.bottom
        anchors{
            left:  audioChannelLbl.right
            leftMargin: 5
            top: parent.top
        }
        height: 25
        spacing: 20
        ExclusiveGroup{
            id: audioChannelGroup
        }
        RadioButton{
            id: audioChannel
            width: 80
            text: "2"
            exclusiveGroup: formatGroup
            checked: true
            onCheckedChanged: {
                if(checked){
                    presetChangeStatus = true
                }
            }
        }
    }
    Label{
        id: samplingRateLbl
        anchors.top:audioChannelLbl.bottom
        anchors.topMargin: 10
        anchors{
            left:  parent.left
            leftMargin: 10
            top: parent.top
        }
        width: 140
        height: 25
        verticalAlignment: Text.AlignVCenter
        text: "Sampling Rate:"
    }
    Row{
        id:samplingRateCheckBox
        anchors.top:audioChannelCheckBox.bottom
        anchors.topMargin:10
        anchors{
            left:  samplingRateLbl.right
            leftMargin: 5
            top: parent.top
        }
        height: 25
        spacing: 20
        ExclusiveGroup{
            id: samplingrateGroup
        }
        RadioButton{
            id: samplingRate
            width: 80
            text: "48000"
            checked: true
            exclusiveGroup: samplingrateGroup
            onCheckedChanged: {
                if(checked){
                    presetChangeStatus = true
                }
            }
        }
    }
    Label {
        id: volumeLbl
        anchors.top:samplingRateLbl.bottom
        anchors.topMargin:10
        width: 140
        height: 25
        anchors{
            left:  parent.left
            leftMargin: 10
            top: parent.top
        }
        text: qsTr("Volume: ")
        verticalAlignment: Text.AlignVCenter
    }
    Rectangle{
        width: 50
        height: 25
        id: volumeTxtRect
        anchors.top:samplingRateCheckBox.bottom
        anchors.topMargin: 10
        anchors{
            left:  volumeLevelSlider.right
            leftMargin: 10
            top: volumeLbl.top
        }
        Label{
            width: parent.width-4
            height: parent.height-4
            id: volumeTxt
            enabled: !settingsArray[settingsIndex].raw
            anchors{
                left:  parent.left
                leftMargin: 2
                top: parent.top
                topMargin: 2
            }
            text: qsTr(volumeLevelSlider.value.toString())
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            onTextChanged: {
                presetChangeStatus = true
            }
        }
    }
    Slider {
        id: volumeLevelSlider
        anchors.top:samplingRateCheckBox.bottom
        anchors.topMargin: 10
        anchors{
            left: volumeLbl.right
            leftMargin: 6
            top: parent.top
        }
        enabled: audioEnable.checked
        maximumValue: 10.0
        minimumValue: 0
        style: sliderstyle
        stepSize: 0.5
        updateValueWhileDragging: true
    }

    Rectangle{
        id: sourceOutputRectangle
        width: sourceCheckbox.width
        height: 60
        visible: false
        anchors.left: sourceCheckbox.left
        border.color: root.borderColors
        border.width: root.boarderWidths
        clip: true
        color: root.barColors
        anchors.top: sourceCheckbox.bottom
        OptionsScrollVu{
            id: outputSourceList
            anchors.fill: parent
            visible: true
            listModel.model: audioSourceList
            selecteItem: root.sourceSelect
            delgate: this
            width: parent.width
            function clicked(indexval){
                sourceOutputRectangle.visible = false
                sourceCheckbox.showList = false
                root.sourceSelect = indexval
                presetChangeStatus = true
                outputLbl.text = audioSourceList[indexval].shortName
            }
        }
    }
    Rectangle{
        id: renderOutputRectangle
        width: renderCheckbox.width
        height: 60
        visible: false
        anchors.left: renderCheckbox.left
        border.color: root.borderColors
        border.width: root.boarderWidths
        clip: true
        color: root.barColors
        anchors.top: renderCheckbox.bottom
        OptionsScrollVu{
            id: outputRenderList
            anchors.fill: parent
            listModel.model: audioRenderList
            selecteItem: root.renderSelect
            delgate: this
            width: parent.width
            function clicked(indexval){
                renderOutputRectangle.visible = false
                renderCheckbox.showList = false
                presetChangeStatus = true
                root.renderSelect = indexval
                renderOutputLbl.text = audioRenderList[indexval].shortName
            }
        }
    }


    Component {
        id: sliderstyle
        SliderStyle {
            handle: Rectangle {
                anchors.centerIn: parent
                color: "white"
                border.color: "gray"
                antialiasing: true
                border.width: 1
                implicitWidth: 10
                implicitHeight: 24
                radius: 5
            }
            groove: Item {
                implicitHeight: 5
                implicitWidth: 150
                Rectangle {
                    height: 5
                    width: parent.width
                    color: "gray"
                    radius: 5
                }
            }
        }
    }
}

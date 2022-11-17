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
    anchors.fill: parent
    color: "transparent"
    property var repeaterModel: root.numSrc
    property alias presetDropDown: presetList
    MouseArea{
        anchors.fill: parent
        onClicked: {

        }
    }
    onVisibleChanged: {
        if(visible){
            repeaterModel = root.numSrc
        }else{
            repeaterModel = 0
        }
    }

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 1000
        height: (root.numSrc * 30)+60
        border.color: "gray"
        border.width: 1
        radius: 10

        Label{
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 5
            text: "Input Settings"
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
            anchors.right: parent.right
            anchors.rightMargin: 22
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
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
                inputRectangle.visible = false
                codecRectangle.visible = false
                controlRectangle.visible = false
                ipSetingsPopup.visible = false
            }
        }

        Column{
            anchors.top: parent.top
            anchors.topMargin: 30
            width: parent.width - 20
            anchors.left: parent.left
            anchors.leftMargin: 10
            spacing: 5

            Repeater{
                id: ipSettingrepeater
                model: repeaterModel
                Rectangle{
                    property var codecNm: (root.outputSelect == 0) ? codecList[settingsArray[index].codecSelect].shortName : ((root.outputSelect == 3) ? "NA" : "Enc")
                    property var presetNm: controlList[settingsArray[index].presetSelect].shortName
                    id: rec1
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.topMargin: 1
                    width: parent.width
                    height: 25
                    color: "transparent"
                    Row{
                        width: parent.width
                        height: 22
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 10
                        Rectangle{
                            width: 195
                            height: parent.height
                            color: "transparent"
                            Label{
                                anchors.left: parent.left
                                width: 60
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                                text: "<b>Input</b>" + (index + 1) + "<b>: </b>"
                            }
                            Rectangle{
                                id: inputSrcLst
                                anchors.right: parent.right
                                width: 135
                                height: parent.height
                                color: root.play ? "lightGray" : "gray"
                                property var showList: false
                                property var browseSrc: false
                                enabled: !root.play
                                border.color: "black"
                                border.width: 1
                                radius: 2
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        fileList.visible = false
                                        streaminPopupdlg.visible = false
                                        inputRectangle.visible = !inputRectangle.visible
                                        inputSrcLst.showList = !inputSrcLst.showList
                                        codecRectangle.visible = false
                                        codecLst.showList = false
                                        controlRectangle.visible = false
                                        scdOutputRectangle.visible = false
                                        controlLst.showList = false
                                        outputRectangle.visible = false
                                        outputLst.showList = false
                                        inputRectangle.y = (56 + (index * 30))
                                        settingsIndex = index
                                    }
                                }
                                Label{
                                    id: srcNameLbl
                                    anchors.left: parent.left
                                    anchors.leftMargin: 10
                                    height: parent.height
                                    color: "white"
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    text: videoSourceList[settingsArray[index].videoInput].shortName
                                }
                                Image{
                                    anchors.right: parent.right
                                    anchors.rightMargin: 5
                                    width: parent.height
                                    height: parent.height
                                    source: ((settingsIndex == index) && inputRectangle.visible) ? "qrc:///images/upArrow.png" : "qrc:///images/downArrow.png"
                                }
                            }
                        }

                        Rectangle{
                            width: 205
                            height: parent.height
                            color: "transparent"
                            Label{
                                anchors.left: parent.left
                                width: 65
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                                text: "<b>Codec: </b>"
                            }
                            Rectangle{
                                id: codecLst
                                anchors.right: parent.right
                                width: 140
                                height: parent.height
                                color: (root.outputSelect != 0) ? "lightGray" : ((settingsArray[index].videoInput === 3 || settingsArray[index].videoInput === 4) || root.play) ? "lightGray" : "gray"
                                enabled: (root.outputSelect != 0 || settingsArray[index].videoInput === 3 || settingsArray[index].videoInput === 4) ? false : true
                                property var showList: false
                                property var browseSrc: false
                                border.color: "black"
                                border.width: 1
                                radius: 2
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        fileList.visible = false
                                        streaminPopupdlg.visible = false
                                        codecRectangle.visible = !codecRectangle.visible
                                        codecLst.showList = !codecLst.showList
                                        inputRectangle.visible = false
                                        inputSrcLst.showList = false
                                        controlRectangle.visible = false
                                        scdOutputRectangle.visible = false
                                        controlLst.showList = false
                                        outputRectangle.visible = false
                                        outputLst.showList = false
                                        codecRectangle.y = (56 + (index * 30))
                                        settingsIndex = index
                                    }
                                }
                                Label{
                                    id: codecNameLbl
                                    anchors.left: parent.left
                                    anchors.leftMargin: 10
                                    height: parent.height
                                    color: "white"
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    text: ((settingsArray[index].videoInput === 3) || (settingsArray[index].videoInput === 4) || (root.outputSelect == 3) || (root.outputSelect == 4)) ? "NA" : rec1.codecNm
                                }
                                Image{
                                    anchors.right: parent.right
                                    anchors.rightMargin: 5
                                    width: parent.height
                                    height: parent.height
                                    source: ((settingsIndex == index) && codecRectangle.visible) ? "qrc:///images/upArrow.png" : "qrc:///images/downArrow.png"
                                }
                            }
                        }

                        Rectangle{
                            height: parent.height
                            width: 220
                            color: "transparent"
                            Label{
                                id: presetL
                                anchors{
                                    left: parent.left
                                    leftMargin: 10
                                    top: parent.top
                                }
                                width: 60
                                height: 25
                                verticalAlignment: Text.AlignVCenter
                                text: "<b>Preset: </b>"
                            }
                            Rectangle{
                                id: controlLst
                                anchors.left: presetL.right
                                width: 150
                                height: parent.height
                                color: ((settingsArray[index].videoInput === 3) || (settingsArray[index].videoInput === 4) || settingsArray[index].raw) ? "lightGray" : "gray"
                                enabled: (settingsArray[index].videoInput === 3 || settingsArray[index].videoInput === 4 || settingsArray[settingsIndex].raw) ? false : !root.play
                                property var showList: false
                                border.color: "black"
                                border.width: 1
                                radius: 2
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        fileList.visible = false
                                        streaminPopupdlg.visible = false
                                        controlRectangle.visible = !controlRectangle.visible
                                        controlLst.showList = !controlLst.showList
                                        inputRectangle.visible = false
                                        inputSrcLst.showList = false
                                        codecRectangle.visible = false
                                        scdOutputRectangle.visible = false
                                        codecLst.showList = false
                                        outputRectangle.visible = false
                                        outputLst.showList = false
                                        controlRectangle.y = (56 + (index * 30))
                                        settingsIndex = index

                                    }
                                }
                                Label{
                                    id: presetLbl
                                    anchors.left: parent.left
                                    anchors.leftMargin: 10
                                    height: parent.height
                                    color: "white"
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    text: ((settingsArray[index].videoInput === 3) || (settingsArray[index].videoInput === 4) || (settingsArray[index].raw)) ? "NA" : rec1.presetNm
                                }
                                Image{
                                    anchors.right: parent.right
                                    anchors.rightMargin: 5
                                    width: parent.height
                                    height: parent.height
                                    source: ((settingsIndex == index) && controlRectangle.visible) ? "qrc:///images/upArrow.png" : "qrc:///images/downArrow.png"
                                }
                            }

                        }
                        Rectangle{
                            height:parent.height
                            width:235
                            color: "transparent"
                            Label{
                                id:scdL
                                anchors{
                                    left:parent.left
                                    leftMargin:10
                                    top: parent.top
                                }
                                width:60
                                height:25
                                verticalAlignment:Text.AlignHCenter
                                text:"<b>SCD:</b>"
                                }
                            Rectangle{
                                id: scdlistparams
                                anchors.left: scdL.right
                                width: 150
                                height: parent.height
                                color:"gray"
                                property var showList: false
                                border.color: "black"
                                border.width: 1
                                radius: 2
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        fileList.visible = false
                                        streaminPopupdlg.visible = false
                                        controlRectangle.visible = false
                                        scdlistparams.showList = !scdlistparams.showList
                                        scdOutputRectangle.visible = !scdOutputRectangle.visible
                                        inputRectangle.visible = false
                                        inputSrcLst.showList = false
                                        codecRectangle.visible = false
                                        codecLst.showList = false
                                        outputRectangle.visible = false
                                        outputLst.showList = false
                                        scdOutputRectangle.y = (56 + (index * 30))
                                        settingsIndex = index

                                    }
                                }
                                Label{
                                    id: scdLbl
                                    anchors.left: parent.left
                                    anchors.leftMargin: 10
                                    height: parent.height
                                    color: "white"
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    text:scdList[root.scd].shortName
                                }
                                Image{
                                    anchors.right: parent.right
                                    anchors.rightMargin: 5
                                    width: parent.height
                                    height: parent.height
                                    source: ((settingsIndex == index) && scdOutputRectangle.visible) ? "qrc:///images/upArrow.png" : "qrc:///images/downArrow.png"
                                }
                            }
                            }

                        Button{
                            id: controlBtn
                            width: 70
                            height: parent.height
                            text: "Settings"
                            enabled: (videoSourceList[settingsArray[settingsIndex].videoInput].shortName === "TPG" && settingsArray[settingsIndex].raw === true) ? false :true
                            style: ButtonStyle{
                                background: Rectangle {
                                    implicitWidth: 100
                                    implicitHeight: 25
                                    border.width: controlBtn.activeFocus ? 2 : 1
                                    border.color: "#888"
                                    radius: 4
                                    gradient: Gradient {
                                        GradientStop { position: 0 ; color: controlBtn.down ? "#ccc" : "#eee" }
                                        GradientStop { position: 1 ; color: controlBtn.down ? "#aaa" : "#ccc" }
                                    }
                                }
                            }
                            onClicked: {
                                settingsIndex = index
                                fileList.visible = false
                                streaminPopupdlg.visible = false
                                encoderDecoderPanel.visible = !encoderDecoderPanel.visible
                                inputRectangle.visible = false
                                inputSrcLst.showList = false
                                codecRectangle.visible = false
                                codecLst.showList = false
                                controlRectangle.visible = false
                                controlLst.showList = false
                                outputRectangle.visible = false
                                outputLst.showList = false
                                presetChangeStatus = false

                            }
                        }
                    }

                    Rectangle{
                        anchors.left: parent.left
                        anchors.leftMargin: -10
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        anchors.top: parent.bottom
                        anchors.topMargin: 2
                        height: 1
                        color: "gray"
                    }
                }
            }
        }

        Rectangle{
            id: inputRectangle
            width: 135
            anchors.left: parent.left
            anchors.leftMargin: 80
            height: ((root.outputSelect == 0) && (root.numSrc == 1)) ? 100 : 60
            visible: false
            border.color: root.borderColors
            border.width: root.boarderWidths

            clip: true
            color: root.barColors
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onExited: {

                }
            }

            OptionsScrollVu{
                id: videoSrcOptionsSV
                anchors.fill: parent
                listModel.model: videoSourceList
                selecteItem: configuration.videoInput
                delgate: this
                width: parent.width
                function clicked(indexval){
                    inputRectangle.visible = false
                    switch (indexval){
                    case 0:
                    case 1:
                    case 2:
                        settingsArray[settingsIndex].src = 0
                        settingsArray[settingsIndex].deviceType = videoSourceList[indexval].shortName
                        break;
                    case 3:
                        fileList.tmpVideoInput = settingsArray[settingsIndex].videoInput
                        fileList.visible = true
                        break;
                    case 4:
                        streaminPopupdlg.tempVideoInput = settingsArray[settingsIndex].videoInput
                        settingsArray[settingsIndex].src = 2
                        streaminPopupdlg.uriTextString = ""
                        streaminPopupdlg.visible = true
                        break;
                    }
                    repeaterModel = 0
                    splitScreenGrid.numberInstance = 0
                    settingsArray[settingsIndex].videoInput = indexval
                    repeaterModel = root.numSrc
                    splitScreenGrid.numberInstance = (root.outputSelect == 3) ? (2 * root.numSrc) : root.numSrc
                }
            }
        }

        Rectangle{
            id: codecRectangle
            width: 140
            anchors.left: parent.left
            anchors.leftMargin: 290
            height: 40
            visible: false
            border.color: root.borderColors
            border.width: root.boarderWidths

            clip: true
            color: root.barColors
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onExited: {

                }
            }
            CodecDropDown{
                id: codecListV
                anchors.fill: parent
                listModel.model: codecList
                selecteItem: settingsArray[settingsIndex].codecSelect
                delgate: this
                width: parent.width
                function clicked(indexval){
                    codecRectangle.visible = false
                    ipSettingrepeater.itemAt(settingsIndex).codecNm = codecList[indexval].shortName
                    settingsArray[settingsIndex].codecSelect = indexval
                    if(indexval === 1){
                        settingsArray[settingsIndex].raw = true
                    }else{
                        settingsArray[settingsIndex].raw = false
                    }
                    repeaterModel = 0
                    repeaterModel = root.numSrc
                }
            }
        }

        Rectangle{
            id: controlRectangle
            anchors{
                left: parent.left
                leftMargin: 510
            }
            width: 150
            height: 140
            visible: false
            border.color: root.borderColors
            border.width: root.boarderWidths
            clip: true
            color: root.barColors

            ControlVu{
                id: presetList
                anchors.fill: parent
                listModel.model: controlList
                selecteItem: settingsArray[settingsIndex].presetSelect
                delgate: this
                width: parent.width
                function clicked(indexval){
                    controlRectangle.visible = false
                    settingsArray[settingsIndex].presetSelect = indexval
                    root.presetSelect = indexval
                    root.setPresets(indexval)
                    ipSettingrepeater.itemAt(settingsIndex).presetNm = controlList[indexval].shortName
                    presetList.resetSource(root.presetSelect)
                    if(indexval === 6){
                        settingsArray[settingsIndex].raw = false
                        encoderDecoderPanel.visible = true
                    }else{
                        settingsArray[settingsIndex].raw = false
                        encoderDecoderPanel.tmpPresetSel = indexval
                    }
                    repeaterModel = 0
                    repeaterModel = root.numSrc
                }
            }
        }
        Rectangle{
            id: scdOutputRectangle
            anchors{
                left: parent.left
                leftMargin: 740
            }
            width: 150
            height: 40
            visible: false
            border.color: root.borderColors
            border.width: root.boarderWidths
            clip: true
            color: root.barColors
            OptionsScrollVu{
                id: outputScdList
                anchors.fill: parent
                listModel.model: scdList
                selecteItem: root.scd
                delgate: this
                width: parent.width
                function clicked(indexval){
                    scdOutputRectangle.visible = false
                    root.scd = indexval
                    settingsArray[settingsIndex].scd =indexval

                }
            }

        }
    }
}

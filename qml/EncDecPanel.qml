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
    id: settingsPanel
    anchors.fill: parent
    color: "transparent"

    MouseArea{
        anchors.fill: parent
        onClicked: {

        }
    }
    property bool validation: true
    property var tmpPresetSel: 5
    property var selectTabAtIndex: [
        {   "tab1ULvisible" : false,
            "tab2ULvisible" : true,
            "tab3ULvisible" : true,
            "tab4ULvisible" : true,
            "tab1color" : "transparent",
            "tab2color" : "lightgray",
            "tab3color" : "lightgray",
            "tab4color" : "lightgray",
            "encParamTabVvisible" : true,
            "fileTabVvisible" : false,
            "streamOutTabVvisible" : false,
            "audioSettingsTabVvisible" : false,
            "keyPadvisible" : false
        },

        {   "tab1ULvisible" : true,
            "tab2ULvisible" : false,
            "tab3ULvisible" : true,
            "tab4ULvisible" : true,
            "tab1color" : "lightgray",
            "tab2color" : "transparent",
            "tab3color" : "lightgray",
            "tab4color" : "lightgray",
            "fileTabVvisible" : true,
            "encParamTabVvisible" : false,
            "streamOutTabVvisible" : false,
            "audioSettingsTabVvisible" : false,
            "keyPadvisible" : false
        },
        {   "tab1ULvisible" : true,
            "tab2ULvisible" : true,
            "tab3ULvisible" : false,
            "tab4ULvisible" : true,
            "tab1color" : "lightgray",
            "tab2color" : "lightgray",
            "tab3color" : "transparent",
            "tab4color" : "lightgray",
            "streamOutTabVvisible" : true,
            "fileTabVvisible" : false,
            "encParamTabVvisible" : false,
            "audioSettingsTabVvisible" : false,
            "keyPadvisible" : false
        },
        {   "tab1ULvisible" : true,
            "tab2ULvisible" : true,
            "tab3ULvisible" : true,
            "tab4ULvisible" : false,
            "tab1color" : "lightgray",
            "tab2color" : "lightgray",
            "tab3color" : "lightgray",
            "tab4color" : "transparent",
            "audioSettingsTabVvisible" : true,
            "streamOutTabVvisible" : false,
            "fileTabVvisible" : false,
            "encParamTabVvisible" : false,
            "keyPadvisible" : false
        }
    ]

    Rectangle {
        anchors{
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        onVisibleChanged: {
            if(encoderDecoderPanel.visible){
                validation = true
                createTemp()
                encParamTabV.setPresetValues()
                switch(root.sinkType){
                case 0:
                    tabSelect(selectTabAtIndex[2])
                    tab1.enabled = true
                    tab2.enabled = false
                    tab3.enabled = true
                    tab4.enabled = videoSourceList[settingsArray[settingsIndex].videoInput].shortName === "HDMI-Rx" ? true : false
                    break
                case 1:
                    tabSelect(selectTabAtIndex[1])
                    tab1.enabled = true
                    tab2.enabled = true
                    tab3.enabled = false
                    tab4.enabled = (videoSourceList[settingsArray[settingsIndex].videoInput].shortName === "HDMI-Rx"|| videoSourceList[settingsArray[settingsIndex].videoInput].shortName === "MIPI") ? true : false
                    break
                case 2:
                    if(settingsArray[settingsIndex].src === 1 || settingsArray[settingsIndex].src === 2 ||settingsArray[settingsIndex].raw === true){
                        tabSelect(selectTabAtIndex[3])
                    }
                    else{
                        tabSelect(selectTabAtIndex[0])
                    }
                    tab1.enabled = (settingsArray[settingsIndex].src === 1 || settingsArray[settingsIndex].src === 2 || settingsArray[settingsIndex].raw === true) ? false : true
                    tab2.enabled = false
                    tab3.enabled = false
                    tab4.enabled = (videoSourceList[settingsArray[settingsIndex].videoInput].shortName === "HDMI-Rx"  || videoSourceList[settingsArray[settingsIndex].videoInput].shortName === "MIPI"||settingsArray[settingsIndex].src === 1 || settingsArray[settingsIndex].src === 2) ? true : false
                    break

                }
            }
        }

        width: 600
        height: 558
        color: "#ffffff"
        border.color: "gray"
        border.width: 2
        radius: 5

        MouseArea{
            anchors.fill: parent
            onClicked: {

            }
        }
        Label{
            anchors{
                left: parent.left
                leftMargin: 10
                topMargin: 10
                top: parent.top
            }
            text: "Settings"
            font.bold: true
            font.pointSize: 13
            width: parent.width
            height: 30
            id: header
        }

        Rectangle{
            anchors{
                left: parent.left
                right: parent.right
                top: header.bottom
            }
            height: 2
            color: "black"
        }

        Row{
            id: tabRow
            anchors{
                left: parent.left
                leftMargin: 2
                right: parent.right
                rightMargin: 2
                top: header.bottom
                topMargin: 2
            }
            width: parent.width-5
            height: 25
            Rectangle{
                id: tab1
                height: parent.height
                width: parent.width/4
                color: "transparent"
                border.color: "black"
                border.width: 1
                Label{
                    anchors.fill: parent
                    text: "Encoder Parameter"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                Rectangle{
                    id: tab1UL
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 1
                    height: 1
                    width: parent.width
                    color: "black"
                    visible: false
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(validation === true){
                            tabSelect(selectTabAtIndex[0])
                        }
                    }
                }
            }
            Rectangle{
                id: tab2
                height: parent.height
                width: parent.width/4
                color: "lightgray"
                border.color: "black"
                border.width: 1
                Label{
                    anchors.fill: parent
                    text: "Record"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                Rectangle{
                    id: tab2UL
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 1
                    height: 1
                    width: parent.width
                    color: "black"
                    visible: true
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(validation === true){
                            tabSelect(selectTabAtIndex[1])
                        }
                    }
                }
            }
            Rectangle{
                id: tab3
                height: parent.height
                width: parent.width/4
                color: "lightgray"
                border.color: "black"
                border.width: 1

                Label{
                    anchors.fill: parent
                    text: "Stream Out"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                Rectangle{
                    id: tab3UL
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 1
                    height: 1
                    width: parent.width
                    color: "black"
                    visible: true
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(validation === true){
                            tabSelect(selectTabAtIndex[2])
                        }
                    }
                }
            }
            Rectangle{
                id: tab4
                height: parent.height
                width: parent.width/4
                color: "lightgray"
                border.color: "black"
                border.width: 1

                Label{
                    anchors.fill: parent
                    text: "Audio Settings"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                Rectangle{
                    id: tab4UL
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 1
                    height: 1
                    width: parent.width
                    color: "black"
                    visible: true
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(validation === true){
                            tabSelect(selectTabAtIndex[3])
                        }
                    }
                }
            }
        }
        EncParamTab{
            id: encParamTabV
            visible: true
            anchors{
                left: parent.left
                leftMargin: 3
                top: tabRow.bottom
                topMargin: -1
            }
        }
        FileTab{
            id: fileTabV
            visible: false
            anchors{
                left: parent.left
                leftMargin: 3
                top: tabRow.bottom
                topMargin: -1
            }
        }
        StreamOutTab{
            id: streamOutTabV
            visible: false
            anchors{
                left: parent.left
                leftMargin: 3
                top: tabRow.bottom
                topMargin: -1
            }
        }
        AudioSettingsTab{
            id: audioSettingsTabV
            visible: false
            anchors{
                left: parent.left
                leftMargin: 3
                top: tabRow.bottom
                topMargin: -1
            }
        }
        NumberKeyPad{
            id: keyPad
            anchors.left: parent.left
            anchors.leftMargin: 160
            anchors.top: parent.top
        }

        Button {
            id: okButton
            anchors{
                right: parent.right
                rightMargin: 10
                bottom: parent.bottom
                bottomMargin: 10
            }
            width: 80
            height: 30
            text: qsTr("Ok")
            enabled: validation
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    keyPad.visible = false
                    encoderDecoderPanel.visible = false
                    saveChanges()
                }
            }
        }

        Button {
            id: cancelButton
            anchors{
                right: okButton.left
                rightMargin: 20
                bottom: parent.bottom
                bottomMargin: 10
            }
            width: 80
            height: 30
            text: qsTr("Cancel")
            onClicked:{
                keyPad.visible = false
                encoderDecoderPanel.visible = false
            }
        }
        Label{
            id: errorLbl
            anchors{
                left: parent.left
                leftMargin: 10
                right: cancelButton.left
                rightMargin: 20
                bottom: parent.bottom
                bottomMargin: 10
            }
            height: 30
            text: ""
            color: "red"
            visible: !validation
        }
    }
    function tabSelect(selectedTab){
        tab1UL.visible = selectedTab.tab1ULvisible
        tab2UL.visible = selectedTab.tab2ULvisible
        tab3UL.visible = selectedTab.tab3ULvisible
        tab4UL.visible = selectedTab.tab4ULvisible
        tab1.color = selectedTab.tab1color
        tab2.color = selectedTab.tab2color
        tab3.color = selectedTab.tab3color
        tab4.color = selectedTab.tab4color
        encParamTabV.visible = selectedTab.encParamTabVvisible
        fileTabV.visible = selectedTab.fileTabVvisible
        streamOutTabV.visible = selectedTab.streamOutTabVvisible
        audioSettingsTabV.visible = selectedTab.audioSettingsTabVvisible
        keyPad.visible = selectedTab.keyPadvisible
    }
    function createTemp(){
        encParamTabV.tmpBitrate = settingsArray[settingsIndex].bitrate
        encParamTabV.tmpBframe = settingsArray[settingsIndex].bFrame
        encParamTabV.tmpGopLength = settingsArray[settingsIndex].gopLength
        encParamTabV.tmpsliceCount = settingsArray[settingsIndex].sliceCount
        streamOutTabV.tmpHostIP = settingsArray[settingsIndex].hostIP
        fileTabV.tmpFileDuration = settingsArray[settingsIndex].fileDuration
        streamOutTabV.tmpPort = settingsArray[settingsIndex].port
        tmpPresetSel = settingsArray[settingsIndex].presetSelect
        fileTabV.currentMedia = settingsArray[settingsIndex].selectedMedia
        fileTabV.opFileName = videoSourceList[settingsArray[settingsIndex].videoInput].shortName + (((settingsArray[settingsIndex].encoderType === "2") ? "_H265" : "_H264") + "_rec_TimeStamp.ts")
        audioSettingsTabV.tmpvolumeLevel = settingsArray[settingsIndex].volumeLevel
    }
    function saveChanges(){
        if(presetChangeStatus == true){
            ipSetingsPopup.repeaterModel = 0
            settingsArray[settingsIndex].bFrame = encParamTabV.tmpBframe
            settingsArray[settingsIndex].gopLength = encParamTabV.tmpGopLength
            settingsArray[settingsIndex].bitrate = encParamTabV.tmpBitrate
            settingsArray[settingsIndex].encoderType = encParamTabV.encGrp.current.objectName
            settingsArray[settingsIndex].profile = encParamTabV.profileGrp.current.objectName
            settingsArray[settingsIndex].qpMode = encParamTabV.qpGrp.current.objectName
            settingsArray[settingsIndex].rateControl = encParamTabV.ratecontrolGrp.current.objectName
            settingsArray[settingsIndex].l2Cache = encParamTabV.l2cacheGrp.current.objectName
            settingsArray[settingsIndex].latencyMode = encParamTabV.latencyModeGrp.current.objectName
            settingsArray[settingsIndex].lowBandwidth = encParamTabV.lowbandwidthGrp.current.objectName
            settingsArray[settingsIndex].fillerData = encParamTabV.fillerDataGrp.current.objectName
            settingsArray[settingsIndex].gopMode = encParamTabV.gopmodeGrp.current.objectName
            settingsArray[settingsIndex].sliceCount = encParamTabV.tmpsliceCount
            settingsArray[settingsIndex].hostIP = streamOutTabV.tmpHostIP
            settingsArray[settingsIndex].fileDuration = fileTabV.tmpFileDuration
            settingsArray[settingsIndex].port = streamOutTabV.tmpPort
            settingsArray[settingsIndex].bitrateUnit = encParamTabV.bitrateUnitGrp.current.objectName
            settingsArray[settingsIndex].selectedMedia = fileTabV.currentMedia
            settingsArray[settingsIndex].audioEnable= audioSettingsTabV.audGrp.current.objectName
            settingsArray[settingsIndex].audioFormat = audioSettingsTabV.formatGrp
            settingsArray[settingsIndex].samplingRate = audioSettingsTabV.samplingGrp
            settingsArray[settingsIndex].volumeLevel = audioSettingsTabV.tmpvolumeLevel
            settingsArray[settingsIndex].audioChannel = audioSettingsTabV.audioChannelGrp
            settingsArray[settingsIndex].renderSelect = root.renderSelect
            settingsArray[settingsIndex].sourceSelect = root.sourceSelect
            settingsArray[settingsIndex].presetSelect = tmpPresetSel
            ipSetingsPopup.presetDropDown.resetSource(tmpPresetSel)
            ipSetingsPopup.repeaterModel = root.numSrc
        }
        else{
            settingsArray[settingsIndex].audioEnable= audioSettingsTabV.audGrp.current.objectName
        }
    }
}

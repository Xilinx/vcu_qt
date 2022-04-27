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

import QtQuick 2.0

Item {
    property bool play: false
    property bool errorFound: false

    property var errorMessageText: ""
    property var errorNameText: ""
    property var barColors: "#1FF7F7F0"
    property var barTitleColorsPut: "#F0AAAAAA"
    property var cellColor: "#FFEEEEEE"
    property var cellHighlightColor: "#FFAAAAAA"
    property var borderColors: "#F0AAAAAA"
    property int boarderWidths: 1

    property var videoResolution: (rootWidth === 3840 &&  rootHeight === 2160) ? "4kp" : "1080p"
    property var fpsValue: 0

    property var videoInput: 2
    property var codecSelect: 0
    property var presetSelect: 5
    property var outputSelect: 0
    property var plotDisplay: true

    property var bitrate: "60"
    property var bitrateUnit: "1"
    property var fileBitrate: "NA"
    property var bFrame: 0
    property var gopLength: 60
    property var encoderType: "2"
    property var profile: "1"
    property var qpMode: "2"
    property var rateControl: "2"
    property var l2Cache: "1"
    property var latencyMode: "0"
    property var lowBandwidth: "0"
    property var fillerData: "1"
    property var gopMode: "0"
    property var sliceCount: "8"
    property var ipAddress: "Not Connected"
    property bool isStreamUp: false
    property var hostIP: "192.168.25.89"
    property var port: "5004"
    property var fileDuration: 1

    property var format : 0
    property int numSrc : 1
    property var raw : false
    property var src : 0
    property var deviceType : "TPG"
    property var uri : ""
    property var sinkType: 2
    property var outputFileName: ""
    property var selectedMedia: "card"
    property var outputDirName: "vcu_records"

    property var audioFormat: "S24_32LE"
    property var audioEnable: false
    property var samplingRate: "48000"
    property var volumeLevel: "2.0"
    property var audioChannel: "2"
    property var sourceSelect: "0"
    property var renderSelect: "0"
    property var scd: "0"
}

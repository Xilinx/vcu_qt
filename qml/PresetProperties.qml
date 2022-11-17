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

import QtQuick 2.0

Item {

    property int lowBitRate: 10
    property int mediumBitRate: 30
    property int highBitRate: 60

    property var presetStruct: [
        {"name":"AVC Low", "bitrate":lowBitRate, "bFrame":0, "encoderType":"1", "gopLength":60,
            "bitrateUnit":"1", "profile":"2", "qpMode":"2", "rateControl":"2", "l2Cache":"1", "sliceCount":8, "lowBandwidth":"0", "fillerData": "1", "gopMode": "0", "latencyMode": "0"},
        {"name":"AVC Medium", "bitrate":mediumBitRate, "bFrame":0, "encoderType":"1", "gopLength":60,
            "bitrateUnit":"1", "profile":"2", "qpMode":"2", "rateControl":"2", "l2Cache":"1", "sliceCount":8, "lowBandwidth":"0", "fillerData": "1", "gopMode": "0", "latencyMode": "0"},
        {"name":"AVC High", "bitrate":highBitRate, "bFrame":0, "encoderType":"1", "gopLength":60,
            "bitrateUnit":"1", "profile":"2", "qpMode":"2", "rateControl":"2", "l2Cache":"1", "sliceCount":8, "lowBandwidth":"0", "fillerData": "1","gopMode": "0", "latencyMode": "0"},
        {"name":"HEVC Low", "bitrate":lowBitRate, "bFrame":0, "encoderType":"2", "gopLength":60,
            "bitrateUnit":"1", "profile":"1", "qpMode":"2", "rateControl":"2", "l2Cache":"1", "sliceCount":8, "lowBandwidth":"0", "fillerData": "1","gopMode": "0", "latencyMode": "0"},
        {"name":"HEVC Medium", "bitrate":mediumBitRate, "bFrame":0, "encoderType":"2", "gopLength":60,
            "bitrateUnit":"1", "profile":"1", "qpMode":"2", "rateControl":"2", "l2Cache":"1", "sliceCount":8, "lowBandwidth":"0", "fillerData": "1", "gopMode": "0", "latencyMode": "0"},
        {"name":"HEVC High", "bitrate":highBitRate, "bFrame":0, "encoderType":"2","gopLength":60,
            "bitrateUnit":"1", "profile":"1", "qpMode":"2", "rateControl":"2", "l2Cache":"1", "sliceCount":8, "lowBandwidth":"0", "fillerData": "1", "gopMode": "0", "latencyMode": "0"},
        {"name":"Custom", "bitrate":settingsArray[settingsIndex].bitrate, "bFrame":settingsArray[settingsIndex].bFrame, "encoderType":settingsArray[settingsIndex].encoderType, "gopLength":settingsArray[settingsIndex].gopLength,
            "bitrateUnit":settingsArray[settingsIndex].bitrateUnit, "profile":settingsArray[settingsIndex].profile, "qpMode":settingsArray[settingsIndex].qpMode, "rateControl":settingsArray[settingsIndex].rateControl, "l2Cache":settingsArray[settingsIndex].l2Cache, "sliceCount":settingsArray[settingsIndex].sliceCount, "lowBandwidth":settingsArray[settingsIndex].lowBandwidth,  "fillerData":settingsArray[settingsIndex].fillerData, "gopMode":settingsArray[settingsIndex].gopMode, "latencyMode":settingsArray[settingsIndex].latencyMode}
    ]
}

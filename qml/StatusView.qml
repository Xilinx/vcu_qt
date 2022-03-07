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
    height: (((root.outputSelect == 3) ? (root.numSrc * 2) : root.numSrc) * 23)
    width: 615
    color: "lightGray"

    Column{
        anchors{
            left: parent.left
            leftMargin: 10
            top: parent.top
        }
        spacing: 3
        Repeater{
            model: ((root.outputSelect == 3) ? (root.numSrc * 2) : root.numSrc)
            Rectangle{
                width: 625
                height: 20
                color: "transparent"
                Row{
                    id: stausRow
                    spacing: 10

                    Label{
                        text: "<b>Source: </b>" + "Src " + index
                    }
                    Rectangle{
                        width: 2
                        height: 20
                        color: "darkGray"
                    }
                    Label{
                        text: "<b>Resolution: </b>" + root.videoResolution
                    }
                    Rectangle{
                        width: 2
                        height: 20
                        color: "darkGray"
                    }
                    Label{
                        text: "<b>Format: </b>" + root.format
                    }
                    Rectangle{
                        width: 2
                        height: 20
                        color: "darkGray"
                    }
                    Label{
                        text: "<b>FPS: </b>" + root.fpsValue
                    }
                    Rectangle{
                        width: 2
                        height: 20
                        color: "darkGray"
                    }
                    Label{
                        text: "<b>Encoder: </b>" + (((settingsArray[index] && (settingsArray[index].src === "uridecodebin")) || root.raw) ? "NA" : ((settingsArray[index] && (1 === settingsArray[index].enc_enum)) ? "AVC" : "HEVC"))
                    }
                    Rectangle{
                        width: 2
                        height: 20
                        color: "darkGray"
                    }
                    Label{
                        text:  "<b>Bitrate: </b>" + ((root.raw || ((root.src === "uridecodebin") && !root.play))? "NA" : (((root.src === "uridecodebin") && root.play) ? root.fileBitrate : ((root.bitrate.length === 0) ? "0": root.bitrate) + ((root.src === "uridecodebin") ? "" : ((root.bitrateUnit === "1") ? "Mbps" : "Kbps"))))
                    }
                }

            }
        }
    }

}

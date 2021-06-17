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

import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4


Rectangle{
    width: 60 + (((root.outputSelect == 3) ? (root.numSrc * 2) : root.numSrc) * 30)
    height: (((root.outputSelect == 3) ? (root.numSrc * 2) : root.numSrc) * 20) + 50

    Label{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        height: 20
        text: "Quadrant"
    }
    Row{
        anchors.left: parent.left
        anchors.leftMargin: 60
        anchors.top: parent.top
        anchors.topMargin: 20
        height: 20
        Repeater{
            model: ((root.outputSelect == 3) ? (root.numSrc * 2) : root.numSrc)
            Label{
                width: 30
                text: (index + 1)
            }
        }
    }

    Column{
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 40

        Rectangle{
            id: rawSrc
            height: (matrixVu.height - 50)/2
            width: parent.width
            color: "red"
            Column{
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: parent.width
                Repeater{
                    id: columnRepeater0
                    model: root.numSrc

                    Rectangle{
                        property var c1ind: index
                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: 20 + root.numSrc
                        Label{
                            anchors.left: parent.left
                            id: inputNm
                            width: 50
                            text: ("Input " + (index + 1))
                        }
                        Row{
                            anchors.left: inputNm.right
                            anchors.leftMargin: 10
                            Repeater{
                                model: ((root.outputSelect == 3) ? (root.numSrc * 2) : root.numSrc)
                                RadioButton{
                                    width: 30
                                    objectName: "1"
                                    enabled: false
                                }
                            }
                        }
                    }
                }

            }
        }
        Rectangle{
            id: processedSrc
            height: (matrixVu.height - 50)/2
            width: parent.width
            color: "green"
            visible: (root.outputSelect == 3)
            Column{
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: parent.width
                Repeater{
                    id: columnRepeater1
                    model: root.numSrc

                    Rectangle{
                        property var c2ind: index
                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: 20 + root.numSrc
                        Label{
                            anchors.left: parent.left
                            id: inputNm1
                            width: 50
                            text: ("Input " + (index + 1))
                        }
                        Row{
                            anchors.left: inputNm1.right
                            anchors.leftMargin: 10
                            Repeater{
                                model: ((root.outputSelect == 3) ? (root.numSrc * 2) : root.numSrc)
                                RadioButton{
                                    width: 30
                                    objectName: "1"
                                    enabled: false
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

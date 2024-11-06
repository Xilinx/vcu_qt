/*********************************************************************
 * Copyright (C) 2017-2022 Xilinx, Inc.
 * Copyright (C) 2022-2024 Advanced Micro Devices, Inc.
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
 * This file defines GUI helper functions.
 */

#ifndef MAINCONTROLLER_H
#define MAINCONTROLLER_H

#include <QObject>
#include <QQuickItem>
#include <pthread.h>
#include "CPUStat.h"
#include <QtCharts/QAbstractSeries>
#include <QtCharts/QXYSeries>
#include <QTimer>
#include "vgst_lib.h"
#include "perfapm.h"
#include "video_cfg.h"

#include "video.h"
#include "vlib_audio.h"
QT_CHARTS_USE_NAMESPACE

#define ROOT_FILE_PATH "/media/card"
#define BYTE_TO_GBIT (8 / 1000000000.0)
#define RECORD_DIR "vcu_records"
#define BIT_TO_MBIT(value) (value/1000000.0)
#define BIT_TO_KBIT(value) (value/1000.0)
#define IPV4_MIN_LENGTH 7
#define IPV4_MAX_LENGTH 15
#define NUMBER_OF_SOURCE 1
#define MBPS_MULTIPLIER 1000
#define KBPS_MULTIPLIER 1
#define DEMO_BITRATE_LENGTH  2
#define DEMO_ENCTYPE_LENGTH  2
#define DEMO_INPUTSRC_LENGTH 2
#define DEMO_BITRATE_MAX_LENGTH  3
#define DEMO_ENCTYPE_MAX_LENGTH  2
#define DEMO_INPUTSRC_MAX_LENGTH 3
#define DEMO_TIME_INTERVAL  10000
#define DEVICE_TYPE  3

class maincontroller : public QObject
{
    Q_OBJECT
    enum CpuData{
        Cpu,
        NCpuData
    };
    CPUStat *cpuStat;

    QVector<qreal> cpuList;

    enum MemData{
        videoSrc,
        filter,
        NMemData
    };
    QVector<qreal> videoSrcList;
    QVector<qreal> filterList;

    QObject * rootobject;

    int isRaw = 1;
    int demoBitRateAry[3];
    int demoEncTypeAry[2];
    int demoBitrate = 0;
    int demoEncoderType = 0;
    int demoIpSource = 0;
    bool demoModeRunning = false;
    int demoAudioEnable = 0;
    QTimer* demoTimer;
    QString demoVsrcTbl[3];
    QString demoBitrateString;


    vgst_enc_params encoderParam[NUMBER_OF_SOURCE];
    vgst_ip_params inputParam[NUMBER_OF_SOURCE];
    vgst_op_params outputParam[NUMBER_OF_SOURCE];
    vgst_aud_params audioParam[NUMBER_OF_SOURCE];
    QVariantList fpsArray;
    QVariantList bitrateArray;

public:
    void rootUIObj(QObject * item);
    bool  validDigit(char *);
    bool isValidIp(char *);
    bool updateBitrate[NUMBER_OF_SOURCE] = {false};
    vgst_cmn_params commonParam;


public slots:
    void inits();
    void closeall();
    bool errorPopup(int);
    void updatecpu(QAbstractSeries *cpu);
    void updateThroughput(QAbstractSeries *videoSrc, QAbstractSeries *accelerator);
    void start_pipeline();
    void stop_pipeline();
    void updateFileBitrate();
    void updateFPS();
    void pollEvent();
    void getLocalIpAddress();
    void uninitAll();
    void freeMemory();
    bool validateHostIp(QString);
    void createStorageDir(QString);
    void getSourceData(int, QVariantList,int, int);
    void getCommonParam(int, int, int);
    void demoModeCall(int,int);
    void videoSrcLoop();
    void stopDemoMode();
    void runDemoMode();
    void demoPollEvent();
    void getVideoType();
    void getPosition();
    void getDuration();
};

#endif // MAINCONTROLLER_H

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

#include <qstringlist.h>
#include <qfile.h>
#include <qtextstream.h>
#include "CPUStat.h"
#include <qdebug.h>

CPUStat::CPUStat() : cpuname("cpu ")
{
    validCpu = lookUp(procValues);
}

CPUStat::CPUStat(const QString &name)
{
    cpuname = name;
    validCpu = lookUp(procValues);
}

QTime CPUStat::upTime() const
{
    QTime t;
    for ( int i = 0; i < NValues; i++ )
        t = t.addSecs(int(procValues[i] / 100));

    return t;
}

void CPUStat::statistic(double &data)
{
    double values[NValues];
    double user, system;

    if(validCpu)
    {
        lookUp(values);

        double userDelta = values[User] + values[Nice]
                - procValues[User] - procValues[Nice];
        double systemDelta = values[System] - procValues[System];

        double totalDelta = 0;
        for ( int i = 0; i < NValues; i++ )
            totalDelta += values[i] - procValues[i];

        user = userDelta / totalDelta * 100.0;
        system = systemDelta / totalDelta * 100.0;
        data = user + system;

        for ( int j = 0; j < NValues; j++ )
            procValues[j] = values[j];
    }
}

bool CPUStat::lookUp(double values[NValues]) const
{
    bool ret = false;
    QFile file("/proc/stat");
    if ( !file.open(QIODevice::ReadOnly) )
    {
        static double dummyValues[][NValues] =
        {
            { 103726, 0, 23484, 819556 },
            { 103783, 0, 23489, 819604 },
            { 103798, 0, 23490, 819688 },
            { 103820, 0, 23490, 819766 },
            { 103840, 0, 23493, 819843 },
            { 103875, 0, 23499, 819902 },
            { 103917, 0, 23504, 819955 },
            { 103950, 0, 23508, 820018 },
            { 103987, 0, 23510, 820079 },
            { 104020, 0, 23513, 820143 },
            { 104058, 0, 23514, 820204 },
            { 104099, 0, 23520, 820257 },
            { 104121, 0, 23525, 820330 },
            { 104159, 0, 23530, 820387 },
            { 104176, 0, 23534, 820466 },
            { 104215, 0, 23538, 820523 },
            { 104245, 0, 23541, 820590 },
            { 104267, 0, 23545, 820664 },
            { 104311, 0, 23555, 820710 },
            { 104355, 0, 23565, 820756 },
            { 104367, 0, 23567, 820842 },
            { 104383, 0, 23572, 820921 },
            { 104396, 0, 23577, 821003 },
            { 104413, 0, 23579, 821084 },
            { 104446, 0, 23588, 821142 },
            { 104521, 0, 23594, 821161 },
            { 104611, 0, 23604, 821161 },
            { 104708, 0, 23607, 821161 },
            { 104804, 0, 23611, 821161 },
            { 104895, 0, 23620, 821161 },
            { 104993, 0, 23622, 821161 },
            { 105089, 0, 23626, 821161 },
            { 105185, 0, 23630, 821161 },
            { 105281, 0, 23634, 821161 },
            { 105379, 0, 23636, 821161 },
            { 105472, 0, 23643, 821161 },
            { 105569, 0, 23646, 821161 },
            { 105666, 0, 23649, 821161 },
            { 105763, 0, 23652, 821161 },
            { 105828, 0, 23661, 821187 },
            { 105904, 0, 23666, 821206 },
            { 105999, 0, 23671, 821206 },
            { 106094, 0, 23676, 821206 },
            { 106184, 0, 23686, 821206 },
            { 106273, 0, 23692, 821211 },
            { 106306, 0, 23700, 821270 },
            { 106341, 0, 23703, 821332 },
            { 106392, 0, 23709, 821375 },
            { 106423, 0, 23715, 821438 },
            { 106472, 0, 23721, 821483 },
            { 106531, 0, 23727, 821517 },
            { 106562, 0, 23732, 821582 },
            { 106597, 0, 23736, 821643 },
            { 106633, 0, 23737, 821706 },
            { 106666, 0, 23742, 821768 },
            { 106697, 0, 23744, 821835 },
            { 106730, 0, 23748, 821898 },
            { 106765, 0, 23751, 821960 },
            { 106799, 0, 23754, 822023 },
            { 106831, 0, 23758, 822087 },
            { 106862, 0, 23761, 822153 },
            { 106899, 0, 23763, 822214 },
            { 106932, 0, 23766, 822278 },
            { 106965, 0, 23768, 822343 },
            { 107009, 0, 23771, 822396 },
            { 107040, 0, 23775, 822461 },
            { 107092, 0, 23780, 822504 },
            { 107143, 0, 23787, 822546 },
            { 107200, 0, 23795, 822581 },
            { 107250, 0, 23803, 822623 },
            { 107277, 0, 23810, 822689 },
            { 107286, 0, 23810, 822780 },
            { 107313, 0, 23817, 822846 },
            { 107325, 0, 23818, 822933 },
            { 107332, 0, 23818, 823026 },
            { 107344, 0, 23821, 823111 },
            { 107357, 0, 23821, 823198 },
            { 107368, 0, 23823, 823284 },
            { 107375, 0, 23824, 823377 },
            { 107386, 0, 23825, 823465 },
            { 107396, 0, 23826, 823554 },
            { 107422, 0, 23830, 823624 },
            { 107434, 0, 23831, 823711 },
            { 107456, 0, 23835, 823785 },
            { 107468, 0, 23838, 823870 },
            { 107487, 0, 23840, 823949 },
            { 107515, 0, 23843, 824018 },
            { 107528, 0, 23846, 824102 },
            { 107535, 0, 23851, 824190 },
            { 107548, 0, 23853, 824275 },
            { 107562, 0, 23857, 824357 },
            { 107656, 0, 23863, 824357 },
            { 107751, 0, 23868, 824357 },
            { 107849, 0, 23870, 824357 },
            { 107944, 0, 23875, 824357 },
            { 108043, 0, 23876, 824357 },
            { 108137, 0, 23882, 824357 },
            { 108230, 0, 23889, 824357 },
            { 108317, 0, 23902, 824357 },
            { 108412, 0, 23907, 824357 },
            { 108511, 0, 23908, 824357 },
            { 108608, 0, 23911, 824357 },
            { 108704, 0, 23915, 824357 },
            { 108801, 0, 23918, 824357 },
            { 108891, 0, 23928, 824357 },
            { 108987, 0, 23932, 824357 },
            { 109072, 0, 23943, 824361 },
            { 109079, 0, 23943, 824454 },
            { 109086, 0, 23944, 824546 },
            { 109098, 0, 23950, 824628 },
            { 109108, 0, 23955, 824713 },
            { 109115, 0, 23957, 824804 },
            { 109122, 0, 23958, 824896 },
            { 109132, 0, 23959, 824985 },
            { 109142, 0, 23961, 825073 },
            { 109146, 0, 23962, 825168 },
            { 109153, 0, 23964, 825259 },
            { 109162, 0, 23966, 825348 },
            { 109168, 0, 23969, 825439 },
            { 109176, 0, 23971, 825529 },
            { 109185, 0, 23974, 825617 },
            { 109193, 0, 23977, 825706 },
            { 109198, 0, 23978, 825800 },
            { 109206, 0, 23978, 825892 },
            { 109212, 0, 23981, 825983 },
            { 109219, 0, 23981, 826076 },
            { 109225, 0, 23981, 826170 },
            { 109232, 0, 23984, 826260 },
            { 109242, 0, 23984, 826350 },
            { 109255, 0, 23986, 826435 },
            { 109268, 0, 23987, 826521 },
            { 109283, 0, 23990, 826603 },
            { 109288, 0, 23991, 826697 },
            { 109295, 0, 23993, 826788 },
            { 109308, 0, 23994, 826874 },
            { 109322, 0, 24009, 826945 },
            { 109328, 0, 24011, 827037 },
            { 109338, 0, 24012, 827126 },
            { 109347, 0, 24012, 827217 },
            { 109354, 0, 24017, 827305 },
            { 109367, 0, 24017, 827392 },
            { 109371, 0, 24019, 827486 },
        };
        static int counter = 0;

        for ( int i = 0; i < NValues; i++ )
            values[i] = dummyValues[counter][i];

        counter = (counter + 1)
                % (sizeof(dummyValues) / sizeof(dummyValues[0]));
        ret = true;
    }
    else
    {
        QTextStream textStream(&file);
        do {
            QString line = textStream.readLine();
            line = line.trimmed();
            if ( line.startsWith(cpuname) )
            {
                const QStringList valueList =
                        line.split(" ",  QString::SkipEmptyParts);
                if ( valueList.count() >= 5 )
                {
                    for ( int i = 0; i < NValues; i++ )
                        values[i] = valueList[i+1].toDouble();
                }
                ret = true;
                break;
            }
        } while(!textStream.atEnd());
    }

    return ret;
}

#!/usr/bin/env bash
## Author:SuperManito
## Modified:2021-3-21

##############################  作  者  昵  称  （必填）  ##############################
# 使用空格隔开
author_list="sltalex"
##############################  作  者  脚  本  地  址  URL  （必填）  ##############################
# 例如：https://raw.sevencdn.com/whyour/hundun/master/quanx/jx_nc.js
# 1.从作者库中随意挑选一个脚本地址，每个作者的地址添加一个即可，无须重复添加
# 2.将地址最后的 “脚本名称+后缀” 剪切到下一个变量里（my_scripts_list_xxx）
## 目前使用本人收集的脚本库项目用于代替 CDN 加速
scripts_base_url_1=https://github.com/sltalex/jmycoded/blob/master/

## 添加更多脚本地址URL示例：scripts_base_url_3=https://raw.sevencdn.com/whyour/hundun/master/quanx/

##############################  作  者  脚  本  名  称  （必填）  ##############################
# 将相应作者的脚本填写到以下变量中
my_scripts_list_1="jd_zooElecsport.js"
my_scripts_list_2="jd_zjb.js"
my_scripts_list_3="jd_tyt.js"
my_scripts_list_4="jd_superBrand.js"
my_scripts_list_5="jd_SplitRedPacket.js"
my_scripts_list_6="jd_qqxing.js"
my_scripts_list_7="jd_hwsx.js"
my_scripts_list_8="jd_europeancup.js"
my_scripts_list_9="jd_ddo_pk.js"
my_scripts_list_10="jd_ddnc_farmpark.js"



## 由于CDN代理无法实时更新文件内容，目前使用本人的脚本收集库以解决不能访问 Github 的问题

##############################  随  机  函  数  ##############################
rand() {
    min=$1
    max=$(($2 - $min + 1))
    num=$(cat /proc/sys/kernel/random/uuid | cksum | awk -F ' ' '{print $1}')
    echo $(($num % $max + $min))
}
cd ${ShellDir}
index=1
for author in $author_list; do
    echo -e "开始下载 $author 的活动脚本："
    echo -e ''
    # 下载my_scripts_list中的每个js文件，重命名增加前缀"作者昵称_"，增加后缀".new"
    eval scripts_list=\$my_scripts_list_${index}
    #echo $scripts_list
    eval url_list=\$scripts_base_url_${index}
    #echo $url_list
    for js in $scripts_list; do
    eval url=$url_list$js
    echo $url
    eval name=$js
    echo $name
    wget -q --no-check-certificate $url -O scripts/$name.new

    # 如果上一步下载没问题，才去掉后缀".new"，如果上一步下载有问题，就保留之前正常下载的版本
    # 随机添加个cron到crontab.list
    if [ $? -eq 0 ]; then
        mv -f scripts/$name.new scripts/$name
        echo -e "更新 $name 完成...\n"
        croname=$(echo "$name" | awk -F\. '{print $1}')
        script_date=$(cat scripts/$name | grep "http" | awk '{if($1~/^[0-59]/) print $1,$2,$3,$4,$5}' | sort | uniq | head -n 1)
        if [ -z "${script_date}" ]; then
        cron_min=$(rand 1 59)
        cron_hour=$(rand 7 9)
        [ $(grep -c "$croname" ${ListCron}) -eq 0 ] && sed -i "/hangup/a${cron_min} ${cron_hour} * * * bash jd $croname" ${ListCron}
        else
        [ $(grep -c "$croname" ${ListCron}) -eq 0 ] && sed -i "/hangup/a${script_date} bash jd $croname" ${ListCron}
        fi
    else
        [ -f scripts/$name.new ] && rm -f scripts/$name.new
        echo -e "更新 $name 失败，使用上一次正常的版本...\n"
    fi
    done
    index=$(($index + 1))
done

##############################  删  除  失  效  的  活  动  脚  本  ##############################
## 删除旧版本失效的活动示例： rm -rf ${ScriptsDir}/jd_test.js
#rm -rf ${ScriptsDir}/jd_axc.js
#rm -rf ${ScriptsDir}/jd_shakeBean.js
#rm -rf ${ScriptsDir}/jd_super5G.js
# rm -rf ${ScriptsDir}/jd_city_cash.js

##############################  修  正  定  时  任  务  ##############################
## 目前两个版本都做了软链接，但为了 Linux 旧版用户可以使用，继续将软链接更改为具体文件
## 注意两边修改内容区别在于中间内容"jd"、"${ShellDir}/jd.sh"
## 修正定时任务示例：sed -i "s|bash jd jd_test|bash ${ShellDir}/jd.sh test|g" ${ListCron}
##                 sed -i "s|bash jd jd_ceshi|bash ${ShellDir}/jd.sh ceshi|g" ${ListCron}
sed -i "s|bash jd jd_zooElecsport|bash ${ShellDir}/jd.sh jd_zooElecsport|g" ${ListCron}
sed -i "s|bash jd jd_zjb|bash ${ShellDir}/jd.sh jd_zjb|g" ${ListCron}
sed -i "s|bash jd jd_tyt|bash ${ShellDir}/jd.sh jd_tyt|g" ${ListCron}
sed -i "s|bash jd jd_superBrand|bash ${ShellDir}/jd.sh jd_superBrand|g" ${ListCron}
sed -i "s|bash jd jd_SplitRedPacket|bash ${ShellDir}/jd.sh jd_SplitRedPacket|g" ${ListCron}
sed -i "s|bash jd jd_qqxing|bash ${ShellDir}/jd.sh jd_qqxing|g" ${ListCron}
sed -i "s|bash jd jd_hwsx|bash ${ShellDir}/jd.sh jd_hwsx|g" ${ListCron}
sed -i "s|bash jd jd_europeancup|bash ${ShellDir}/jd.sh jd_europeancup|g" ${ListCron}
sed -i "s|bash jd jd_ddo_pk|bash ${ShellDir}/jd.sh jd_ddo_pk|g" ${ListCron}
sed -i "s|bash jd jd_ddnc_farmpark|bash ${ShellDir}/jd.sh jd_ddnc_farmpark|g" ${ListCron}
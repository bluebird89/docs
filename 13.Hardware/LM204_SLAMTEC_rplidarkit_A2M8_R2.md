作为一个传感器，将数据编码输出

[硬件参数手册](http://bucket.download.slamtec.com/a3bdd2bbf5a531748052cd554f817b4b6081ff47/LD208_SLAMTEC_rplidar_datasheet_A2M8_v1.0_cn.pdf)

[用户手册](http://117.143.109.160/cache/bucket.download.slamtec.com/7923ea8304fc3a9d954386b75cf25a3c5a977f9e/LM204_SLAMTEC_rplidarkit_usermanual_A2M4_v1.1_cn.pdf?ich_args2=142-22004412045827_553c04d1e752cf128be6807e6da47116_10001002_9c89642fd4c0f2d9923a518939a83798_891edb93dcdb9a56be64462bd3d39077)

[驱动](http://www.silabs.com/products/mcu/Pages/USBtoUARTBridgeVCPDrivers.aspx)

查看设备：

```
cd /dev/
ls -l tty*
tty.SLAB_USBtoUART
# 可以换USB接口，第一个
```

[SDK](rplidar_sdk_v1.5.7)

```
cd sdk
make
cd output/Darwin/Release
# 通过串口与RPLIDAR连接，将雷达扫描数据输出
ultra_simple tty.SLAB_USBtoUART
# 通过串口与RPLIDAR连接，输出设备序列号、固件版本与自身健康情况，随后两周的360度用柱状图显示
simple_grabber tty.SLAB_USBtoUART
```

[串口工具：收费](https://itunes.apple.com/cn/app/ ... /id1181734730?mt=12)

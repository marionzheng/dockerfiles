**Default workdir in this image is "/home/esp/project"**

## ESP8266 SoC bin build example

```bash
docker run --rm -it \
-v $HOME/Documents/project/test/SoC_ESP8266_32M_source/app:/home/esp/project \
ccr.ccs.tencentyun.com/aionnect/esp-toolchain-all-in-one /bin/sh /home/esp/project/gen_misc.sh
```

## ESP32 SoC EDP-IDF build example

```bash
docker run --rm -it \
--device /dev/cu.SLAB_USBtoUART:/dev/ttyUSB0 \
-v $HOME/Documents/project/test/esp-idf/examples/get-started/hello_world:/home/esp/project \
ccr.ccs.tencentyun.com/aionnect/esp-toolchain-all-in-one /bin/bash
```

> make menuconfig

> make flash monitor
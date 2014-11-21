
lgcron 是一个定时任务守护器。

用法：
```
    lua mycron.lua script [start_time] [repeated_time]

    script:		要执行的shell脚本（可以包含行内语法）
    start_time:  	0~24  从某一个小时开始，单位为小时
    repeated_time:	重复间隔时间，单位为秒
```

依赖：

1. [lua-ev](https://github.com/brimworks/lua-ev);
2. [bamboo-log](https://github.com/daogangtang/bamboo-log);
3. [luadaemon](https://github.com/smherwig/lua-daemon.git);
4. [lualoggin](luarocks install lualogging);



注意：本脚本用的时区是中国标准时间。


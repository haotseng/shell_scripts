Install wxWidgets 3.0.3 in Windows
==================================

### Target:

Build wxWidgets static Libs with unicode feature under windows environment.

### Steps:

1. Download wxWidgets 3.0.3 windows installer from  [wxWidgets website](https://github.com/wxWidgets/wxWidgets/releases/download/v3.0.3/wxMSW-3.0.3-Setup.exe)


2. Install it on **C:\wxWidgets-3.0.3** or **D:\wxWidgets-3.0.3**

3. Download MinGW32(with MSYS) or MingGW64(wih MSYS) from [MinGW website](http://www.mingw.org/)

4. Install MinGW32 & MSYS.

5. Run **msys.bat** in MSYS directory.

After that, execute below commands in MSYS console:

    $> cd /d/wxWidgets-3.0.3
    $> mingw32-make -j4 -f makefile.gcc BUILD=release UNICODE=1 SHARED=0 MONOLITHIC=1




### Refer

1. [Compiling wxWidgets with MinGW](https://wiki.wxwidgets.org/Compiling_wxWidgets_with_MinGW)
2. [Compiling wxWidgets with MSYS-MinGW](https://wiki.wxwidgets.org/Compiling_wxWidgets_with_MSYS-MinGW)
3. [WxWidgets Build Configurations](https://wiki.wxwidgets.org/WxWidgets_Build_Configurations)




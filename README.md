# Build 7-zip for Android

## 介绍

为了在 Android 平台上使用[rikyoz/bit7z](https://github.com/rikyoz/bit7z)对压缩文件操作，本项目使用 Android NDK 工具链编译 Android 平台可用的 7-zip 库(lib7z.so)

如果遇到问题请提 issue 向我反馈

## 使用方法

### 环境要求

操作系统：Linux

编译器：Android NDK(16.1.4479499)

构建工具：GNU Make

> Android NDK 版本必须为16.1.4479499，下载链接：[Android NDK 16.1.4479499](https://github.com/android/ndk/wiki/Unsupported-Downloads#ndk-16b-downloads)

### 设置环境变量

设置Android NDK 安装目录为`NDK` 

```
export NDK="path/to/android-ndk"
```

### 构建

可选的目标架构：

- arm64-v8a
- armeabi-v7a
- x86
- x86_64

使用以下命令以构建 7-zip：

```
cd <build_7zip_for_android folder>
chmod +x build.sh
./build.sh "<arch>"
```

例子：

```
cd build_7zip_for_android
chmod +x build.sh
./build.sh "arm64-v8a"
```

或者运行`build_all.sh`构建所有目标架构

```
cd <build_7zip_for_android folder>
chmod +x build_all.sh
./build_all.sh
```

目标将会输出在`<build_7zip_for_android folder>/build/<arch>`

## 参考资料

[peijunbo/7zip-android](https://github.com/peijunbo/7zip-android)

[Workaround for missing _mm256_set_m128i in GCC < 8](https://sourceforge.net/p/sevenzip/patches/420/)

以及很多作者制作的关于编译 7-zip 库的教程

## 许可证

[7-zip License](LICENSE-7zip)

[本仓库License](LICENSE)

## 鸣谢

[peijunbo/7zip-android](https://github.com/peijunbo/7zip-android)

[7-zip](https://7-zip.org/) 的作者 Igor Pavlov

和所有制作关于编译 7-zip 库的教程的作者

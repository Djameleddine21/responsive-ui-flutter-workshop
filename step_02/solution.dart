import 'package:flutter/material.dart';

void main() => runApp(const SampleApp());

class SampleApp extends StatelessWidget {
  const SampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: TestDeviceBreakpointsWidget()
      ),
    );
  }
}

enum DeviceBreakpoints {
  mobile,
  tablet,
  laptop,
  desktop,
  tv
}

// Utilities class
class Utils {
  
  static const int mobileMaxSize = 480;
  static const int tabletMaxSize = 768;
  static const int laptopMaxSize = 1024;
  static const int desktopMaxSize = 1200;
  
  static Map<DeviceBreakpoints, DeviceDescription> deviceTypes = {
    DeviceBreakpoints.mobile: DeviceDescription(
      icon: Icons.phone_iphone,
      label: "Mobile"
    ),
    DeviceBreakpoints.tablet: DeviceDescription(
      icon: Icons.tablet_mac,
      label: "Tablet"
    ),
    DeviceBreakpoints.laptop: DeviceDescription(
      icon: Icons.laptop_mac,
      label: "Laptop"
    ),
    DeviceBreakpoints.desktop: DeviceDescription(
      icon: Icons.desktop_windows,
      label: "Desktop"
    ),
    DeviceBreakpoints.tv: DeviceDescription(
      icon: Icons.tv,
      label: "Large TV"
    )
  };
  
  static DeviceBreakpoints getDeviceType(BuildContext context) {

    MediaQueryData data = MediaQuery.of(context);
    DeviceBreakpoints bk = DeviceBreakpoints.mobile;

    if (data.size.width > Utils.mobileMaxSize 
      && data.size.width <= Utils.tabletMaxSize) {
      bk = DeviceBreakpoints.tablet;
    }

    else if (data.size.width > Utils.tabletMaxSize 
      && data.size.width <= Utils.laptopMaxSize) {
      bk = DeviceBreakpoints.laptop;
    }

    else if (data.size.width > Utils.laptopMaxSize &&
            data.size.width <= Utils.desktopMaxSize) {
      bk = DeviceBreakpoints.desktop;
    }
    
    else if (data.size.width > Utils.desktopMaxSize) {
      bk = DeviceBreakpoints.tv;
    }

    return bk;
  }
}

class TestDeviceBreakpointsWidget extends StatelessWidget {

  const TestDeviceBreakpointsWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    MediaQueryData data = MediaQuery.of(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            const DeviceScreenIndicator(),
            Opacity(
              opacity: 0.25,
              child: HorizontalSizeIndicator(mediaQueryData: data)
            ),
            Opacity(
              opacity: 0.25,
              child: VerticalSizeIndicator(mediaQueryData: data)
            )
          ]
        )
      ),
    );
  }
}

class DeviceScreenIndicator extends StatelessWidget {
  
  const DeviceScreenIndicator({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    DeviceBreakpoints deviceBreakpoint = Utils.getDeviceType(context);
    DeviceDescription? deviceDesc = Utils.deviceTypes[deviceBreakpoint];

    IconData? icon = deviceDesc!.icon;
    String? label = deviceDesc.label;
    
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.all(50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.blueAccent, size: 70),
            const SizedBox(height: 20),
            Text(label!, 
              style: const TextStyle(color: Colors.blueAccent, fontSize: 20)
            )
          ]
        )
      )
    );
  }
}

class HorizontalSizeIndicator extends StatelessWidget {
  
  final MediaQueryData? mediaQueryData;

  const HorizontalSizeIndicator({ Key? key, this.mediaQueryData }): super(key: key);

  @override
  Widget build(BuildContext context) {
    
    var height = mediaQueryData!.size.height;
    var width = mediaQueryData!.size.width;

    return Stack(
      children: [
        Positioned(
          top: height / 2,
          left: -6,
          child: const Icon(
            Icons.west,
            color: Colors.green,
            size: 80
          )
        ),
        Positioned(
          top: height / 2,
          right: -6,
          child: const Icon(
            Icons.east,
            color: Colors.green,
            size: 80
          )
        ),
        Positioned(
          top: (height / 2) + 36,
          left: 0,
          right: 0,
          child: Container(
            height: 8,
            color: Colors.green,
            margin: const EdgeInsets.only(left: 12, right: 12)
          )
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 50, bottom: 30),
            child: Text('$width',
                        style: const TextStyle(fontSize: 60, color: Colors.green))
          )
        )
      ]
    );
  }
}

class VerticalSizeIndicator extends StatelessWidget {
  
  final MediaQueryData? mediaQueryData;

  const VerticalSizeIndicator({ Key? key, this.mediaQueryData }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var height = mediaQueryData!.size.height;
    
    return Stack(
      children: [
        const Positioned(
          top: -6,
          right: 24,
          child: Icon(
            Icons.north,
            color: Colors.red,
            size: 80
          ) 
        ),
        const Positioned(
          bottom: -6,
          right: 24,
          child: Icon(
            Icons.south,
            color: Colors.red,
            size: 80
          ) 
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 8,
            color: Colors.red,
            margin: const EdgeInsets.only(top: 12, bottom: 12, right: 60)
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Transform.rotate(
            angle: -1.55,
            child: Container(
              margin: const EdgeInsets.only(bottom: 30, right: 100),
              child: Text('$height', 
                          style: const TextStyle(fontSize: 60, color: Colors.red))
            )
          )
        )
      ]
    );
  }
}

class DeviceDescription {
  IconData? icon;
  String? label;
  
  DeviceDescription({ this.icon, this.label });
}

classdef MulberryBlocks < handle & matlab.System & matlab.system.mixin.Propagates
    
    properties (Hidden)
        Connection = 0;
        DeviceIsConnected = 0;
    end
    
    methods
        function connect(obj)
            if ~coder.target('Rtw')
                if obj.Connection == 0
                    deviceName = "Mulberry Tart";
                    avail = instrhwinfo('Bluetooth');
                    numberOfInRangeDevices = length(avail.RemoteNames);
                    for i = 1 : numberOfInRangeDevices
                        if avail.RemoteNames(i) == deviceName
                            deviceInfo = instrhwinfo('Bluetooth',deviceName);
                            deviceChannel = str2double(cell2mat(deviceInfo.Channels));
                            obj.Connection = Bluetooth(deviceName, deviceChannel);
                            break
                        end
                    end
                end
                if obj.DeviceIsConnected == 0
                    fopen(obj.Connection);
                    obj.DeviceIsConnected = 1;
                end
            end
        end
    end
    
end
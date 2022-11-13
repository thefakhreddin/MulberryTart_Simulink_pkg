classdef GSM_Sensor < MulberrySensor
    properties
        Port;
    end
    methods
        function sensor = DistanceSensorClass(p,c)
            sensor.Connection = c;
            sensor.Port = str2double(p);
        end
        
        function value = Value(sensor)
            value = sensor.lookForValues([sensor.ID.gsm sensor.Port]);
        end
    end
end
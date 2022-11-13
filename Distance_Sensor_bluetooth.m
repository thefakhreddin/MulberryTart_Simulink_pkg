classdef Distance_Sensor < matlab.System

    properties
        %         Port Port
        Port = 1
    end
    properties (Hidden,Access = protected,Constant)
        SectionHeadFlag = 1;
        disconnectedSensorFlag=-1;
        FlagMargin = 10;
    end
    properties (Hidden,Access = protected)
        lastDataAnalyzed=0;
        clk=0;
    end


    methods(Access = protected)
%         function setupImpl(obj)
%         end

        function Distance = stepImpl(obj,Feed)
%             Potentiometer=obj.lastDataAnalyzed;
%             buffer=transpose(Buffer);
%             if buffer(4)-obj.FlagMargin==obj.Port
%                 msb=uint32(buffer(5)-obj.FlagMargin);
%                 lsb=uint32(buffer(6)-obj.FlagMargin);
%                 msb=bitshift(msb,8);
%                 obj.lastDataAnalyzed=double(bitor(msb,lsb));
%             end
            
            Distance=obj.lastDataAnalyzed;
            buffer=transpose(Feed);
            [~,bufferLength]=size(buffer);
            for i=bufferLength-1:-1:1
                if buffer(i)==obj.SectionHeadFlag && buffer(i+1) > 10
                    sectionLength = buffer(i+1) - obj.FlagMargin;
                    if bufferLength-i-1 >= sectionLength
                        sensorId = buffer(i+2) - obj.FlagMargin;
                        sensorPort = buffer(i+3) - obj.FlagMargin;
                        if sensorId == hex2dec('01') && sensorPort == obj.Port
%                             sensorValus = buffer(i+4:i+sectionLength+1);
                            sensorValus = buffer(i+4:i+sectionLength+1) - obj.FlagMargin;
                            [~,sensorValusLength] = size(sensorValus);
                            for j=1:sensorValusLength
                                if sensorValus(j)<0
                                    sensorValus(j)=sensorValus(j)+255;
                                end
                            end
                            obj.lastDataAnalyzed=double(sensorValus(1));
                            break;
                        else
                            continue;
                        end
                    end
                elseif buffer(i)==obj.disconnectedSensorFlag && buffer(i+1) == obj.Port
                    obj.lastDataAnalyzed=-1;
                end
            end

        end
        
        
    end
end

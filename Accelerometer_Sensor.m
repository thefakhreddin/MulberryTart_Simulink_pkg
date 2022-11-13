classdef Accelerometer_Sensor < matlab.System

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
        lastDataAnalyzed1=0;
        lastDataAnalyzed2=0;
        lastDataAnalyzed3=0;
        clk=0;
    end


    methods(Access = protected)
%         function setupImpl(obj)
%         end

        function [X, Y, Z] = stepImpl(obj,Feed)
            
            X=obj.lastDataAnalyzed1;
            Y=obj.lastDataAnalyzed2;
            Z=obj.lastDataAnalyzed3;
            
            buffer=transpose(Feed);
            [~,bufferLength]=size(buffer);
            for i=bufferLength-1:-1:1
                if buffer(i)==obj.SectionHeadFlag && buffer(i+1) > 10
                    sectionLength = buffer(i+1) - obj.FlagMargin;
                    if bufferLength-i-1 >= sectionLength
                        sensorId = buffer(i+2) - obj.FlagMargin;
                        sensorPort = buffer(i+3) - obj.FlagMargin;
                        if sensorId == hex2dec('05') && sensorPort == obj.Port
%                             sensorValus = buffer(i+4:i+sectionLength+1);
                            sensorValus = buffer(i+4:i+sectionLength+1) - obj.FlagMargin;
                            [~,sensorValusLength] = size(sensorValus);
                            for j=1:sensorValusLength
                                if sensorValus(j)<0
                                    sensorValus(j)=sensorValus(j)+255;
                                end
                            end
                            msb1=uint32(sensorValus(1));
                            lsb1=uint32(sensorValus(2));
                            msb2=uint32(sensorValus(3));
                            lsb2=uint32(sensorValus(4));
                            msb3=uint32(sensorValus(5));
                            lsb3=uint32(sensorValus(6));
                            
                            msb1=bitshift(msb1,8);
                            msb2=bitshift(msb2,8);
                            msb3=bitshift(msb3,8);
                            
                            obj.lastDataAnalyzed1=double(bitor(msb1,lsb1));
                            obj.lastDataAnalyzed2=double(bitor(msb2,lsb2));
                            obj.lastDataAnalyzed3=double(bitor(msb3,lsb3));
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

classdef Button_Sensor < matlab.System

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
        lastDataAnalyzed4=0;
        clk=0;
    end


    methods(Access = protected)
%         function setupImpl(obj)
%         end

        function [A, B, C, D] = stepImpl(obj,Feed)
            
            A=obj.lastDataAnalyzed1;
            B=obj.lastDataAnalyzed2;
            C=obj.lastDataAnalyzed3;
            D=obj.lastDataAnalyzed4;
            
            buffer=transpose(Feed);
            [~,bufferLength]=size(buffer);
            for i=bufferLength-1:-1:1
                if buffer(i)==obj.SectionHeadFlag && buffer(i+1) > 10
                    sectionLength = buffer(i+1) - obj.FlagMargin;
                    if bufferLength-i-1 >= sectionLength
                        sensorId = buffer(i+2) - obj.FlagMargin;
                        sensorPort = buffer(i+3) - obj.FlagMargin;
                        if sensorId == hex2dec('09') && sensorPort == obj.Port
%                             sensorValus = buffer(i+4:i+sectionLength+1);
                            sensorValus = buffer(i+4:i+sectionLength+1) - obj.FlagMargin;
                            [~,sensorValusLength] = size(sensorValus);
                            for j=1:sensorValusLength
                                if sensorValus(j)<0
                                    sensorValus(j)=sensorValus(j)+255;
                                end
                            end
                            obj.lastDataAnalyzed1=double(sensorValus(1));
                            obj.lastDataAnalyzed2=double(sensorValus(2));
                            obj.lastDataAnalyzed3=double(sensorValus(3));
                            obj.lastDataAnalyzed4=double(sensorValus(4));
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

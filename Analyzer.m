classdef Analyzer < matlab.System
    
    methods(Access = protected)
        function dataOut = stepImpl(obj,control,rawData)
            [~,dataSize]=size(rawData);
            numberOfSections=0;
            for i=1:dataSize
                if rawData(i)==0
                    numberOfSections=numberOfSections+1;
                end
            end
%             muxControl = mode(control,numberOfSections)+1;
            dataOut=control;
            
        end
    end
end

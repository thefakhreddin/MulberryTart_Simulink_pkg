classdef DataAnalyzer < matlab.System
    
    properties (Hidden,Access = protected,Constant)
        falgMargine = 10;
    end
   
    
    methods (Access = protected)
        
        function serialData=stepImpl(~,rawData,control)
            
            dataSize=15;
            [~,rawDataWidth]=size(rawData);
            serialData=ones(1,dataSize);
            rawData=[rawData ones(1,dataSize-rawDataWidth)];
            numberOfSections=0;
            
            for i=1:dataSize
                if rawData(i)==0
                    numberOfSections=numberOfSections+1;
                end
            end
            
            muxControl = mod(control,numberOfSections)+1;
   
            j=0;
            for i=1:dataSize
                if rawData(i)==0
                    j=j+1;
                end
                if j==muxControl-1
                    for k=i+1:dataSize
                        serialData(k-i)=rawData(k-1);
                        if rawData(k)==0
                            break;
                        end
                    end
                    break;
                end
            end
            
            if serialData(1)==0
                serialData(1:end-1)=serialData(2:end);
                serialData(end)=1;
            end
            serialData=serialData-10;
            for i=1:dataSize
                if serialData(i)<0
                    serialData(i)=0;
                end
            end
        end

    end
end    
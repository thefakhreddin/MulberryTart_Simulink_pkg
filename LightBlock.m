classdef LightBlock < matlab.System ...
        & coder.ExternalDependency ...
        & matlab.system.mixin.Propagates ...    
        & matlab.system.mixin.CustomIcon
    
    properties (Hidden,Access = protected,Constant)
        id = string(hex2dec('05'));
        sampleTime = 1;
        falgMargine = 10;
    end
    
    properties(Nontunable)
%         LightNumber Light Number
        LightNumber = 1
    end
    
    methods (Static)
        function name = getDescriptiveName()
            name = 'Light Block';
        end
        
        function b = isSupportedContext(context)
            b = context.isCodeGenTarget('rtw');
        end
        
        function updateBuildInfo(buildInfo, context)
            if context.isCodeGenTarget('rtw')
                rootDir = fullfile(fileparts(mfilename('fullpath')),'src');
                buildInfo.addIncludePaths(rootDir);
                buildInfo.addIncludeFiles('motorBlock.h');
                buildInfo.addSourceFiles('motorBlock.cpp',rootDir);
            end
        end
        
    end
    
    methods
        function obj = LightBlock(varargin)
            coder.allowpcode('plain'); 
            setProperties(obj,nargin,varargin{:});
        end
    end
    
    methods (Access = protected)
        
        function icon = getIconImpl(~)
            % Define icon for System block
            icon = matlab.system.display.Icon('my_icon.jpg');
        end
        
        function num = getNumInputsImpl (~)
            num = 1;
        end
        
        function num = getNumOutputsImpl (~)
            num = 0;
        end
        
        function validateInputsImpl (~, u)
            if isempty(coder.target)
                validateattributes(u,{'double'},...
                    {'scalar'},'','u');
            end
        end
        
        function sts = getSampleTimeImpl(obj)
            sts = createSampleTime(obj,'Type','Discrete',...
                'SampleTime',obj.SampleTime);
        end
        
        function setupImpl(obj)
            if coder.target('Rtw')
                coder.cinclude('lightBlock.h');
                coder.ceval('lightInit', obj.LightNumber);
            end
        end
        
        function stepImpl(obj,Color)
            if coder.target('Rtw')
                coder.ceval('lightDrive', Color, obj.LightNumber); 
            end
        end
        
        function resetImpl(obj) %#ok<MANU>
        end

    end
    
end    
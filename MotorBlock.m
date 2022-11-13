classdef MotorBlock < matlab.System ...
        & coder.ExternalDependency ...
        & matlab.system.mixin.Propagates ...    
        & matlab.system.mixin.CustomIcon
    
    properties (Hidden,Access = protected,Constant)
        id = string(hex2dec('01'));
        sampleTime = 1;
        falgMargine = 10;
    end
    
    properties(Nontunable)
%         motorPort Motor Port
        motorPort = 1
    end
    
    methods (Static)
        function name = getDescriptiveName()
            name = 'Motor Block';
        end
        
        function b = isSupportedContext(context)
            b = context.isCodeGenTarget('rtw');
        end
        
        function updateBuildInfo(buildInfo, context)
            if context.isCodeGenTarget('rtw')
                rootDir = fullfile(fileparts(mfilename('fullpath')),'src');
                buildInfo.addIncludePaths(rootDir);
                buildInfo.addIncludeFiles('motorBlock.h');
                buildInfo.addIncludeFiles('mt_identifier.h');
                buildInfo.addIncludeFiles('mt_protocol.h');
                buildInfo.addSourceFiles('motorBlock.cpp',rootDir);
                buildInfo.addSourceFiles('mt_protocol.cpp',rootDir);
            end
        end
        
    end
    
    methods
        function obj = MotorBlock(varargin)
            coder.allowpcode('plain'); 
            setProperties(obj,nargin,varargin{:});
        end
    end
    
    methods (Access = protected)
        
        function icon = getIconImpl(~)
            % Define icon for System block
            icon = matlab.system.display.Icon('motor.png');
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
                coder.cinclude('motorBlock.h');
                coder.ceval('motorInit', obj.motorPort);
            end
        end
        
        function stepImpl(obj,Speed)
            if coder.target('Rtw')
                coder.ceval('motorDrive', floor(Speed), obj.motorPort); 
            end
        end
        
        function resetImpl(obj) %#ok<MANU>
        end

    end
    
end    
classdef Potentiometer_Sensor < realtime.internal.SourceSampleTime ...
        & coder.ExternalDependency ...
        & matlab.system.mixin.Propagates ...
        & matlab.system.mixin.CustomIcon
    
    properties(Nontunable)
        %         sensorPort Sensor Port
        sensorPort = 1
    end
    
    properties (Constant, Hidden)
        AvailablePin = 1:4;
    end
    
    methods
        % Constructor
        function obj = Potentiometer_Sensor(varargin)
            coder.allowpcode('plain');
            
            % Support name-value pair arguments when constructing the object.
            setProperties(obj,nargin,varargin{:});
        end
        
        function set.sensorPort(obj,value)
            coder.extrinsic('sprintf') % Do not generate code for sprintf
            validateattributes(value,...
                {'numeric'},...
                {'real', 'positive', 'integer','scalar'},...
                '', ...
                'sensorPort');
            assert(any(value == obj.AvailablePin), ...
                'Invalid value for Pin. Pin must be one of the following: %s', ...
                sprintf('%d ', obj.AvailablePin));
            obj.sensorPort = value;
        end
    end
    
    methods (Access=protected)
        function setupImpl(~)
            if coder.target('Rtw')
                coder.cinclude('potentiometerSensorBlock.h');
                coder.ceval('potentiometerSensorInit');
            end
        end
        
        function y = stepImpl(obj)
            y = 0;
            if coder.target('Rtw')
                y = coder.ceval('potentiometerSensorRead', obj.sensorPort);
            end
        end
        
        function releaseImpl(obj) %#ok<MANU>
        end
    end
    
    methods (Access=protected)
        function num = getNumInputsImpl(~)
            num = 0;
        end
        
        function num = getNumOutputsImpl(~)
            num = 1;
        end
        
        function flag = isOutputSizeLockedImpl(~,~)
            flag = true;
        end
        
        function varargout = isOutputFixedSizeImpl(~,~)
            varargout{1} = true;
        end
        
        function flag = isOutputComplexityLockedImpl(~,~)
            flag = true;
        end
        
        function varargout = isOutputComplexImpl(~)
            varargout{1} = false;
        end
        
        function varargout = getOutputSizeImpl(~)
            varargout{1} = [1,1];
        end
        
        function varargout = getOutputDataTypeImpl(~)
            varargout{1} = 'double';
        end
        
        function icon = getIconImpl(~)
            % Define icon for System block
            icon = matlab.system.display.Icon('sonar.png');
            end
    end
    
    methods (Static, Access=protected)
        function simMode = getSimulateUsingImpl(~)
            simMode = 'Interpreted execution';
        end
        
        function isVisible = showSimulateUsingImpl
            isVisible = false;
        end
    end
    
    methods (Static)
        function name = getDescriptiveName()
            name = 'Potentiometer Sensor';
        end
        
        function b = isSupportedContext(context)
            b = context.isCodeGenTarget('rtw');
        end
        
        function updateBuildInfo(buildInfo, context)
            if context.isCodeGenTarget('rtw')
                % Update buildInfo
                rootDir = fullfile(fileparts(mfilename('fullpath')),'src');
                buildInfo.addIncludePaths(rootDir);
                buildInfo.addIncludeFiles('potentiometerSensorBlock.h');
                buildInfo.addIncludeFiles('mt_identifier.h');
                buildInfo.addIncludeFiles('mt_protocol.h');
                buildInfo.addIncludeFiles('SPI_C.h');
                buildInfo.addSourceFiles('potentiometerSensorBlock.cpp',rootDir);
                buildInfo.addSourceFiles('mt_protocol.cpp',rootDir);
                buildInfo.addSourceFiles('SPI_C.cpp',rootDir);
            end
        end
    end
    
    
    
end
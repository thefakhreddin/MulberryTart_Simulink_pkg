classdef SensorAnalyzer < matlab.System
    properties
        %         portA Port A
        portA = 'none';
        %         portB Port B
        portB = 'none';
        %         portC Port C
        portC = 'none';
        %         portD Port D
        portD = 'none';
    end
    
    methods(Access = protected)
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
        end

        function y = stepImpl(obj,u)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            y = u;
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
        end
    end
end

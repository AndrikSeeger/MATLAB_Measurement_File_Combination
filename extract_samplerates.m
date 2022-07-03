function sample_rates = extract_samplerates(signal_names)
%EXTRACT_SAMPLERATES - Sampleraten in Sekunden aus den Signalnamen extrahieren
%
% Syntax:  sample_rates = extract_samplerates(signal_names)
%
% Inputs:
%    signal_names - Signalnamen als Cell-Array
%
% Outputs:
%    sample_rates - Sampleraten als Vektor
%
% Example: 
%    sample_rates = extract_samplerates({'test_Timestamp150_2', 'test_Timestamp300_1'})
%
% Other m-files required: none
% MAT-files required: none
% Subfunctions: none
%
% See also: combine_resample.m
% Author: 1319658
% June 2021; Last revision: 04-June-2021
%------------- BEGIN CODE --------------
    %Samplerates aus Namen extrahieren
    sample_rates = regexp(signal_names, '\w*_Timestamp(?<samplerate>\d+)(_d+)?', 'names'); 
    sample_rates = cellfun(@(x) x.samplerate, sample_rates, 'UniformOutput', false);
    sample_rates = cellfun(@str2num, sample_rates);
    sample_rates = sample_rates/1000; %Von Millisekunden in Sekunden umrechnen
end
%------------- END OF CODE --------------
function enginetime = clean_data(enginetime)
%CLEAN_DATA - Auf- und Abschalteffekte (Werte<=0) am Anfang und Ende des Signals entfernen
%
% Syntax:  enginetime = clean_data(enginetime)
%
% Inputs:
%    enginetime - Signal der Enginetime, welches aufbereitet werden soll als Vektor
%
% Outputs:
%    enginetime - Aufbereitetes Signal als Vektor
%
% Example: 
%    enginetime = clean_data([-9999, -9999, 1, 2, 3, -9999, 0, 0, -9999])
%
% Other m-files required: none
% MAT-files required: none
% Subfunctions: none
%
% See also: combine_resample.m
% Author: 1319658
% June 2021; Last revision: 04-June-2021
%------------- BEGIN CODE --------------
    diffs = diff(enginetime<=0);
    changing_points = find(diffs);
    if(~isempty(changing_points)) %Effekte gefunden
        leng_time = length(enginetime);
        new_indice = 0; %Indizes der Werte welche neu berechnet werden müssen
        accepted_indice = 0; %Indizes der Werte welche bereits stimmen
        if(length(changing_points)==1) %Auf- ODER Abschalteffekte        
            if(diffs(changing_points(1))>0) %Aufschalteffekte
                new_indice = 1:changing_points; 
                accepted_indice = changing_points+1:leng_time;
            else %Abschalteffekte 
                new_indice = changing_points+1:leng_time;
                accepted_indice = 1:changing_points;           
            end
        elseif(length(changing_points)==2) %Aufschalt- UND Abschalteffekte
            new_indice = [1:changing_points(1) changing_points(2)+1:leng_time];
            accepted_indice = changing_points(1)+1:changing_points(2);
        end
        enginetime(new_indice) = interp1(accepted_indice, enginetime(accepted_indice), new_indice, ...
                'linear', 'extrap'); %Extrapolieren und fehlende Werte berechnen    
    end
end
%------------- END OF CODE --------------
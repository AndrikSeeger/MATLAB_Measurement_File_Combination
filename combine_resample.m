function result = combine_resample(measurements, req_frequenz, progress_fig)  
%COMBINE_RESAMPLE - Zeit-kontinuierliche Kombination der Einzelmessungen zu einer 
%Gesamtmessung mit einer vorgegeben Abtastfrquenz
%
% Syntax:  result = combine_resample(measurements, req_frequenz, progress_fig)
%
% Inputs:
%    measurements - Einzelmessungen mit je allen Signalen als Cell-Array
%    req_frequenz - Einheitliche Frequenz auf die alle Signale geresampled werden als Double
%    progress_fig - uiprogressdlg-Figur um Fortschritt anzuzeigen
%
% Outputs:
%    result - Endergebnis mit allen zusammengefügten und geresampelten Signalen und dem neuen einheitlichen Zeitvektor
%
% Example: 
%    result = combine_resample({messung1, messung2, messung3, messung4}, 100, uiprogressdlg_fig)
%
% Other m-files required: clean_data.m, extract_samplerates.m
% MAT-files required: none
% Subfunctions: get_start, update_progress
%
% See also: clean_data.m, extract_samplerates.m
% Author: 1319658
% June 2021; Last revision: 04-June-2021
%------------- BEGIN CODE --------------
req_sample_rate = 1/req_frequenz; %Sampletime in Sekunden

%Enginetime für jede Messung sichern
enginetimes = cellfun(@(x) x.engine_timestamp_4_Timestamp1000_, measurements, 'UniformOutput', false);

%Feldnamen aller relevanter Signale sichern (nicht name)
fields = fieldnames(measurements{1}); 
fields = fields(~strcmp(fields, 'name')); 

%Init
signals = cell(length(fields), 1); 
min_time = 0; 

update_progress(progress_fig, 0.04, 'Signale anordnen und zusammenfügen');

%Auf- und Abschalteffekte entfernen durch Extrapolieren
enginetimes = cellfun(@(x) clean_data(x), enginetimes, 'UniformOutput', false);

for i = 1:length(enginetimes) 
    starttime = cellfun(@(x) get_start(x, min_time), enginetimes); 
    if(all(isnan(starttime))) %Keine passenden Folgemessungen -> Fertig
        break
    end
    first_vector_index = find(starttime == min(starttime),1); %Index des kleinsten Enginetime-Startwerts
    
    %Alle Signale der Messung zusammenhängen
    for j = 1:length(signals)
        signals{j} = [signals{j}; measurements{first_vector_index}.(fields{j})];
    end
        
    %Startzeit des nächsten Vektors muss über der Endzeit des aktuellen liegen
    min_time = enginetimes{first_vector_index}(end);
    
    %Löschen 
    enginetimes(first_vector_index) = []; 
    measurements(first_vector_index) = []; 
end

update_progress(progress_fig, 0.25, 'Signale resamplen');

%Gesamtzeit aus der zusammengesetzten Enginetime berechnen
endtime = length(signals{strcmp(fields, 'engine_timestamp_4_Timestamp1000_')})-1;

%Einheitlichen Zeitvektor mit der geforderten Frequenz erstellen
unified_time = 0:req_sample_rate:endtime; 
new_timestamp = ['_Timestamp' num2str(req_sample_rate*1000)];

sample_rates = extract_samplerates(fields);

%Resamplen und Endergebnis erstellen
for i = 1:length(signals)
    original_time = 0:sample_rates(i):unified_time(end); %Urspr. Zeitvektor des Signals
    %Neuer Signalname (neue Samplerate)
    new_field_name = strrep(fields{i}, ['_Timestamp' num2str(sample_rates(i)*1000)], new_timestamp); 
    %Resamplen und sichern
    result.(new_field_name) = interp1(original_time, signals{i}(1:length(original_time)), unified_time, 'linear'); 
end

update_progress(progress_fig, 0.65, 'Ergebnis sichern');

%Gemeinsamen Zeitvektor sichern
name_time = ['unified_time' new_timestamp];
result.(name_time) = unified_time;

end
%------------- END OF CODE --------------



function start = get_start(timevector, min_time)
%GET_START - Anfangswert des Zeitvektors zurückgeben wenn dieser größer als eine Mindestzeit ist, ansonsten NaN
%
% Syntax:  start = get_start(timevector, min_time)
%
% Inputs:
%    timevector - Zeitvektor ohne Auf- und Abschalteffekte
%    min_time - Mindestzeit über welche der Anfangswert des zeitvektor liegen soll als Double
%
% Outputs:
%    start - Anfangswert des Zeitvektors wenn dieser größer als die Mindestzeit ist, ansonsten NaN
%
% Example: 
%    start = get_start([0.1, 0.2, 0.3], 0.05)
%
% Other m-files required: none
% MAT-files required: none
% Subfunctions: none
%
% See also: none
% Author: 1319658
% June 2021; Last revision: 04-June-2021
%------------- BEGIN CODE --------------
    if(timevector(1)>min_time) %Wert direkt am Anfang folgt auf min_time
        start = timevector(1); 
    else %Wert am Anfang folgt nicht auf min_time
        start = NaN;
    end
end
%------------- END OF CODE --------------



function update_progress(figure,rel_progress,message)
%UPDATE_PROGRESS - Message und Fortschritt einer uiprogressdlg setzen
%
% Syntax:  update_progress(figure,rel_progress,message)
%
% Inputs:
%    figure - uiprogressdlg welche geupdated werden soll
%    rel_progress - Prozentualer Anteil der Fortschritts am Gesamtaufwand als Double
%    message - Nachricht welche angezeigt werden soll als String oder Char-Array   
%
% Outputs:
%    none
%
% Example: 
%    update_progress(uiprogressdlg_fig, 0.7, "70% is done")
%
% Other m-files required: none
% MAT-files required: none
% Subfunctions: none
%
% See also: none
% Author: 1319658
% June 2021; Last revision: 04-June-2021
%------------- BEGIN CODE --------------
    figure.Value = rel_progress;
    figure.Message = message;
end
%------------- END OF CODE --------------
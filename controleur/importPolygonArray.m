function importPolygonArray(~,~, obj)
%IMPORTPOLYGONARRAY  Imports a folder containing polygons coordinates files (.txt) and make it the current polygon array
%
%   Inputs :
%       - ~ (not used) : inputs automatically send by matlab during a callback
%       - obj : handle of the MainFrame
%   Outputs : none

% open the folder selection prompt and let the user select the folder that
% contains the polygons that will be used as the polygon array
dname = uigetdir('C:\Stage2016_Thomas\data_plos\slabs\Tests');
files = dir(fullfile(dname, '*txt'));

% memory allocation

polygonArray = cell(1,length(files));
nameArray = cell(1, length(files));

if dname ~= 0
    if ~isempty(files)
        if ~isempty(obj.handles.panels)
        % if the figure already contains a polygon array
            obj = PolygonsManagerMainFrame;
        end
        
        % create waitbar
        h = waitbar(0,'D�but de l''import', 'name', 'Chargement des contours');
        for i = 1:length(files)
            % get the name of the polygon without the '.txt' at the end
            name = files(i).name(1:end-4);
            
            % save the name
            nameArray{i} = name;
            
            % save the polygon 
            polygonArray{i} = Table.read(fullfile(dname, files(i).name)).data;

            % update the waitbar
            waitbar(i / length(files), h, ['process : ' name]);
        end
        %close the waitbar
        close(h)
        
        % set the new polygon array as the current polygon array
        polygons = BasicPolygonArray(polygonArray);
        
        %setup the frame
        setupNewFrame(obj, nameArray, polygons);
    else
        msgbox('The selected folder is empty');
    end
end
end

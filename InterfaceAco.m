function varargout = InterfaceAco(varargin)
% INTERFACEACO MATLAB code for InterfaceAco.fig
%      INTERFACEACO, by itself, creates a new INTERFACEACO or raises the existing
%      singleton*.
%
%      H = INTERFACEACO returns the handle to a new INTERFACEACO or the handle to
%      the existing singleton*.
%
%      INTERFACEACO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFACEACO.M with the given input arguments.
%
%      INTERFACEACO('Property','Value',...) creates a new INTERFACEACO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before InterfaceAco_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to InterfaceAco_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help InterfaceAco

% Last Modified by GUIDE v2.5 08-Dec-2016 01:33:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @InterfaceAco_OpeningFcn, ...
                   'gui_OutputFcn',  @InterfaceAco_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end



function InterfaceAco_OpeningFcn(hObject, eventdata, handles, varargin)


handles.output = hObject;


% create an axes that spans the whole gui
ah = axes('unit', 'normalized', 'position', [0 0 1 1]); 
% import the background image and show it on the axes
bg = imread('D:\Workspace MATLAB\Master 2 Matlab\IBI\Totale\ACO graphique\back\InterfaceCentrale.png'); imagesc(bg);
% prevent plotting over the background and turn the axis off
set(ah,'handlevisibility','off','visible','off')
% making sure the background is behind all the other uicontrols
uistack(ah, 'bottom');




guidata(hObject, handles);






function varargout = InterfaceAco_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ImportButton.
function ImportButton_Callback(hObject, eventdata, handles)



global emplacement;
global matDistance;
global path;
global coordonner;
[FileName, dossier] = uigetfile('*.txt');
path = fullfile(dossier,FileName);

emplacement=get(handles.edit6,'string');


 matDistance=getMatriceDistances(path);

 set(handles.tableMatCoutTAG,'Data', matDistance);
 set(handles.tableMatCoutTAG,'visible','on');


axes(handles.axes1)

h = worldmap(emplacement);

%h=worldmap({'Africa','India'})
landareas = shaperead('landareas.shp','UseGeoCoords', true);
%geoshow (landareas, 'FaceColor', [1 1 .5]);
geoshow(landareas, 'FaceColor', [0.15 0.5 0.15])



for i=1:size(coordonner,1)    
    geoshow(coordonner(i,1)/1000,coordonner(i,2)/1000, 'Marker','.','MarkerSize',10,'MarkerEdgeColor','yellow')
 %    textm(coordonner(i,1)/1000,(coordonner(i,2)/1000) + 0.001, strcat(num2str(i)));    
end
%set(handles.axes1,'visible','on');




function LancerButton_Callback(hObject, eventdata, handles)

global emplacement;
global matDistance;
global path;
global coordonner;

nbrIterMax=str2num(get(handles.edit1,'string'));

nbrAgs=str2num(get(handles.edit2,'string'));

alpha=str2num(get(handles.edit3,'string'));

betta=str2num(get(handles.edit4,'string'));

segma=str2num(get(handles.edit5,'string'));

tic

[solution,cout,MeilleursSolutionss]=ACO_Algorithme_PATH(path,nbrIterMax,nbrAgs,alpha,betta,segma); %ACO_Algorithme(matDistance,nbrIterMax,nbrAgents,alphaa,betta,Segma)

toc

set(handles.tableSolutionTAG,'visible','on');
set(handles.tableSolutionTAG,'Data',solution);
set(handles.text4,'string',num2str(cout));





% dessiner le résultat

%axes(handles.axes1);

%-------------------------------------------------------------------------------------
figure;
h = worldmap(emplacement);
landareas = shaperead('landareas.shp','UseGeoCoords', true);
geoshow(landareas, 'FaceColor', [0.15 0.5 0.15])


for i=1:size(coordonner,1)    
    geoshow(coordonner(i,1)/1000,coordonner(i,2)/1000, 'Marker','.','MarkerSize',10,'MarkerEdgeColor','yellow')
    textm(coordonner(i,1)/1000,(coordonner(i,2)/1000) + 0.001, strcat(num2str(i))); 
end

vectLat=[];
vectLong=[];

for i=1:size(solution,2)
    
    vectLat=[vectLat coordonner(solution(1,i),1)/1000];
    vectLong=[vectLong coordonner(solution(1,i),2)/1000];
    
end

geoshow(vectLat, vectLong,'LineWidth',2);

geoshow(coordonner(solution(1,1),1)/1000,coordonner(solution(1,1),2)/1000, 'Marker','.','MarkerSize',11,'MarkerEdgeColor','red');

%-------------------------------------------------------------------------------------



% 
% axes(handles.axes1); % afficher le cycle hamiltonien
% 
% for i=1:size(solution,2)-1
%     
%     plot3m(coordonner(solution(1,i),1),lon,z,'w','LineWidth',2)
% end
% 









function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
set(handles.text4,'string','');
set(handles.tableMatCoutTAG,'visible','off');
set(handles.tableSolutionTAG,'visible','off');

set(handles.axes1,'visible','off');

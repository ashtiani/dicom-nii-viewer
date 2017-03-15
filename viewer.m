% Please report bugs and inquiries to: 
%
% Name       : Ali Ashtiani
% E-mail     : ali.ashtiani24@gmail.com
% Website    : http://ashtiani.io
% Licence    : MIT

function varargout = viewer(varargin)
% VIEWER MATLAB code for viewer.fig
%      VIEWER, by itself, creates a new VIEWER or raises the existing
%      singleton*.
%
%      H = VIEWER returns the handle to a new VIEWER or the handle to
%      the existing singleton*.
%
%      VIEWER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIEWER.M with the given input arguments.
%
%      VIEWER('Property','Value',...) creates a new VIEWER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before viewer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to viewer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help viewer

% Last Modified by GUIDE v2.5 15-Mar-2017 15:25:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @viewer_OpeningFcn, ...
                   'gui_OutputFcn',  @viewer_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before viewer is made visible.
function viewer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to viewer (see VARARGIN)



% Update handles structure
% currentpath = cd('..');
% parentpath = pwd()
addpath(genpath('../tools'));
setappdata(0,'imgFile', gcf);
%load nii file
nii = load_nii('sample.nii.gz');
imgFile=nii.img;
setappdata( 0,'imgFile',imgFile);

dicomlist = dir(fullfile(pwd,'dicom','*.dcm'));
for cnt = 1 : numel(dicomlist)
    dicoms{cnt} = dicomread(fullfile(pwd,'dicom',dicomlist(cnt).name));
    dcm_imgs(:,:,cnt)=dicoms{cnt};
end
setappdata( 0,'dicoms',dicoms);
setappdata( 0,'dcm_imgs', dcm_imgs);


% default img show of nii file
image_x = squeeze(imgFile(1,:,:));
image_y = squeeze(imgFile(:,1,:));
image_z = imgFile(:,:,1);

imagesc(image_x,'Parent',handles.axes1), colormap('gray');
imagesc(image_y,'Parent',handles.axes2), colormap('gray');
imagesc(image_z,'Parent',handles.axes3), colormap('gray');

% default img show of dicom file
dicom_x = squeeze(dcm_imgs(1,:,:));
dicom_y = squeeze(dcm_imgs(:,1,:));
dicom_z = dcm_imgs(:,:,1);

imagesc(dicom_x,'Parent',handles.axes4), colormap('gray');
imagesc(dicom_y,'Parent',handles.axes5), colormap('gray');
imagesc(dicom_z,'Parent',handles.axes6), colormap('gray');




% set the slider range and step size for nii files
%x_axis
 numSteps_x = size(imgFile,1);
 set(handles.slider1, 'Min', 1);
 set(handles.slider1, 'Max', numSteps_x);
 set(handles.slider1, 'Value', 1);
 set(handles.slider1, 'SliderStep', [1/(numSteps_x-1) , 1/(numSteps_x-1) ]);
 % save the current/last slider value
 handles.lastSliderVal = get(handles.slider1,'Value');
%z_axis
 numSteps_y = size(imgFile,2);
 set(handles.slider2, 'Min', 1);
 set(handles.slider2, 'Max', numSteps_y);
 set(handles.slider2, 'Value', 1);
 set(handles.slider2, 'SliderStep', [1/(numSteps_y-1) , 1/(numSteps_y-1) ]);
 % save the current/last slider value
 handles.lastSliderVal = get(handles.slider2,'Value');
%z_axis
 numSteps_z = size(imgFile,3);
 set(handles.slider3, 'Min', 1);
 set(handles.slider3, 'Max', numSteps_z);
 set(handles.slider3, 'Value', 1);
 set(handles.slider3, 'SliderStep', [1/(numSteps_z-1) , 1/(numSteps_z-1) ]);
 % save the current/last slider value
 handles.lastSliderVal = get(handles.slider3,'Value');
 % Update handles structure
  % Choose default command line output for viewer
handles.output = hObject;
 guidata(hObject, handles);
% UIWAIT makes viewer wait for user response (see UIRESUME)
% uiwait(handles.viewer);



%set the slider range and step size for dicom files
%x_axis
 numSteps_x2 = size(dcm_imgs,1);
 set(handles.slider4, 'Min', 1);
 set(handles.slider4, 'Max', numSteps_x2);
 set(handles.slider4, 'Value', 1);
 set(handles.slider4, 'SliderStep', [1/(numSteps_x2-1) , 1/(numSteps_x2-1) ]);
 % save the current/last slider value
 handles.lastSliderVal = get(handles.slider4,'Value');
 
 
 %y_axis
 numSteps_y2 = size(dcm_imgs,2);
 set(handles.slider5, 'Min', 1);
 set(handles.slider5, 'Max', numSteps_y2);
 set(handles.slider5, 'Value', 1);
 set(handles.slider5, 'SliderStep', [1/(numSteps_y2-1) , 1/(numSteps_y2-1) ]);
 % save the current/last slider value
 handles.lastSliderVal = get(handles.slider5,'Value');
 
 %z_axis
 numSteps_z2 = size(dcm_imgs,3);
 set(handles.slider6, 'Min', 1);
 set(handles.slider6, 'Max', numSteps_z2);
 set(handles.slider6, 'Value', 1);
 set(handles.slider6, 'SliderStep', [1/(numSteps_z2-1) , 1/(numSteps_z2-1) ]);
 % save the current/last slider value
 handles.lastSliderVal = get(handles.slider6,'Value');
 
 


% --- Outputs from this function are returned to the command line.
function varargout = viewer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

imgFile = getappdata(0,'imgFile');

s1 = round(get(handles.slider1,'Value'));
image_x = squeeze(imgFile(s1,:,:));

imagesc(image_x,'Parent',handles.axes1);
% 
dcm_imgs = getappdata(0,'dcm_imgs');
set(handles.slider4,'Value',s1);
dicom_x = squeeze(dcm_imgs(s1,:,:));
imagesc(dicom_x,'Parent',handles.axes4)


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
imgFile = getappdata(0,'imgFile');

s1 = round(get(handles.slider2,'Value'));
image_y = squeeze(imgFile(:,s1,:));


imagesc(image_y,'Parent',handles.axes2);
% 

dcm_imgs = getappdata(0,'dcm_imgs');
set(handles.slider5,'Value',s1);
dicom_y = squeeze(dcm_imgs(:,s1,:));
imagesc(dicom_y,'Parent',handles.axes5)


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

imgFile = getappdata(0,'imgFile');

s1 = ceil(get(handles.slider3,'Value'));
image_z = imgFile(:,:,s1);

imagesc(image_z,'Parent',handles.axes3);
% %%
dcm_imgs = getappdata(0,'dcm_imgs');
set(handles.slider6,'Value',s1)
dicom_z = squeeze(dcm_imgs(:,:,s1));
imagesc(dicom_z,'Parent',handles.axes6)



% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes4




% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    %dcm_imgs(:,:,cnt)=dicoms{cnt};
dcm_imgs = getappdata(0,'dcm_imgs');
s1 = ceil(get(handles.slider4,'Value'));
dicom_x = squeeze(dcm_imgs(s1,:,:));

imagesc(dicom_x,'Parent',handles.axes4);
% 

imgFile = getappdata(0,'imgFile');

set(handles.slider1,'Value',s1);
image_x = squeeze(imgFile(s1,:,:));

imagesc(image_x,'Parent',handles.axes1);





% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

dcm_imgs = getappdata(0,'dcm_imgs');
s1 = ceil(get(handles.slider5,'Value'))
dicom_y = squeeze(dcm_imgs(:,s1,:));

imagesc(dicom_y,'Parent',handles.axes5);
% 
imgFile = getappdata(0,'imgFile');

set(handles.slider2,'Value',s1)
image_y = squeeze(imgFile(:,s1,:));

imagesc(image_y,'Parent',handles.axes2)

% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
dcm_imgs = getappdata(0,'dcm_imgs');
s1 = ceil(get(handles.slider6,'Value'));
dicom_z = squeeze(dcm_imgs(:,:,s1));

imagesc(dicom_z,'Parent',handles.axes6);

imgFile = getappdata(0,'imgFile');

set(handles.slider3,'Value',s1)
image_z = squeeze(imgFile(:,:,s1));

imagesc(image_z,'Parent',handles.axes3)




% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

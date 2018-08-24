%Anirudh Kuchibhatla, CAAM 210, Fall 2017, Project 11.0
%
%Filename:bridgebattles.m
%
%This code generates a game that generates a plot of the old bridgebuilder
%project. The edit text box is used to enter how many sections are desired.
%While any positive integer would work, the game is best played between
%values 1-5. The pulldown menu allows one to choose the enemy they wish to
%fight, who have different weights and therefor deform the bridge
%differently. The toggle box is used to display water when pressed, and is
%triggered after each click of shoot. The slider is used to guess where the
%enemy might be. After clicking shoot, if the player hits the enemy, then
%the enemy lives displayed goes down by one. The game is over either when
%the enemy lives = 0 which results in the MATLAB graph being displayed, or
%when the bridge touches the water, which results in doge being shown.
%
%Usage: Type bridgebattles into the MATLAB prompt.

function varargout = bridgebattles(varargin)
% BRIDGEBATTLES MATLAB code for bridgebattles.fig
%      BRIDGEBATTLES, by itself, creates a new BRIDGEBATTLES or raises the existing
%      singleton*.
%
%      H = BRIDGEBATTLES returns the handle to a new BRIDGEBATTLES or the handle to
%      the existing singleton*.
%
%      BRIDGEBATTLES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BRIDGEBATTLES.M with the given input arguments.
%
%      BRIDGEBATTLES('Property','Value',...) creates a new BRIDGEBATTLES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bridgebattles_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bridgebattles_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bridgebattles

% Last Modified by GUIDE v2.5 12-Nov-2017 20:43:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bridgebattles_OpeningFcn, ...
                   'gui_OutputFcn',  @bridgebattles_OutputFcn, ...
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

% --- Executes just before bridgebattles is made visible.
function bridgebattles_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bridgebattles (see VARARGIN)

% Choose default command line output for bridgebattles
handles.output = hObject;
%Sets the counter initially at 0.
handles.counter = 0;
%Sets the lives left initially as 3.
handles.livesleft = 3;
% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using bridgebattles.
if strcmp(get(hObject,'Visible'),'off')
    plot(0,0);
end

% UIWAIT makes bridgebattles wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = bridgebattles_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in shoot.
function shoot_Callback(hObject, eventdata, handles)
% hObject    handle to shoot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
cla;
%Sets nos as the value obtained from the input the player enters into the
%edit text box.
nos = get(handles.editnos, 'string');
nos = str2double(nos);
%Sets popup_sel_index as the enemy chosen by the player.
popup_sel_index = get(handles.popupmenu1, 'Value');
%Sets a as the boolean value of handles.water based on the toggle box.
a = get(handles.water, 'Value');
%Sets the enemy weight based on what the player chose.
switch popup_sel_index
    case 1
        %Bowser's weight
        enemy_weight = 0.05;
    case 2
        %Ganondorf's weight
        enemy_weight = 0.04;
    case 3
        %Dirty Bubble's weight
        enemy_weight = 0.001;
    case 4
        %Man Ray's weight
        enemy_weight = 0.02;
end
%Adds one to the counter each time the push button is clicked.
handles.counter = handles.counter + 1;
rocksblasted = handles.counter;
%Sets the overall enemy weight as the sum of the enemy_weight and the
%rocksblasted on the bridge.
enemy_weight = enemy_weight + 0.02*(rocksblasted-1)/nos;
%lowest is set as the lowest point of the bridge.
lowest = minlow(nos,enemy_weight,4);
%enemieslocation is randomly chosen.
enemieslocation = rand;
%slidervalue is set based on what the player chooses using the slider.
slidervalue = get(handles.slider1, 'Value');
%cdistance is how far the player was from guessing the currect location of
%the enemy.
cdistance = abs(enemieslocation-slidervalue);
%If the enemy still has lives left and the player is within 0.1 of the
%enemy, then the enemy loses one life.
if handles.livesleft > 0 
    if cdistance < 0.1
        handles.livesleft = handles.livesleft-1;
    end
end
%The lives left is displayed in text5.
set(handles.text5, 'String', handles.livesleft);
if lowest>-0.75 && handles.livesleft>0
    %The bridge is plotted with the added weight of the rocks.
    build_load_plot_basic_bridge(nos,enemy_weight,4,a)
elseif handles.livesleft == 0
    %If the enemy lives reaches 0, the MATLAB logo is plotted.
    surf(membrane)
    title('You Win!!');
    %Victory Music
    load audio48
    sound(signal48kHz, Fs48)
else
    %If the bridge sinks, then doge is plotted.
    spy
    title('You Lose!!');
    axis off
end
%Updates the handles wih the push of the button.
guidata(hObject,handles);







% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)





function editnos_Callback(hObject, eventdata, handles)
% hObject    handle to editnos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editnos as text
%        str2double(get(hObject,'String')) returns contents of editnos as a double


% --- Executes during object creation, after setting all properties.
function editnos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editnos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes on button press in water.
function water_Callback(hObject, eventdata, handles)
% hObject    handle to water (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of water
%a is set as the toggle state, which is used by the push button.
a = get(handles.water, 'Value');



% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function[adj, xc, yc, len] = buildbasicbridge(nos)
%This function is responsible for creating the adjacency matrix necessary
%to plot the undeformed bridge. It is called by
%build_load_plot_basic_bridge and plot_spy.
%The only input for this function is nos, which is the number of the
%sections that the required bridge will have.
%The outputs of this function are adj, which is the adjacency matrix, xc,
%which is the x coordainates of each edge, yc, which is the y coordiante of
%each edge, and len, which is the length of each edge.
num_nodes = 2*nos+2;
%Sets the number of free nodes as the 2*nos + 2.
num_edges = 5*(nos+1);
%Sets the number of edges in the bridge as 5*(nos+1).
s = 1/sqrt(2);
%Sets s as 1/sqrt(2). which is also sin(45), which is an important number
%in this code.
adj = zeros(num_edges,2*num_nodes);
%Initially keeps the adjacency matrix as a blank zere matrix of dimensions
%num_edges x (2*num_nodes).
xc = zeros(num_edges, 2);
%Initally sets xc as a zero matrix.
yc = zeros(num_edges, 2);
%Initially sets yc as a zero matrix.
len = ones(num_edges, 1);
%Initially sets len as a one matrix, as most of the lengths are one.
%Left Side of Bridge
%These steps set up the adjacency matrix for the left side of the bridge.
adj(1,1) = 1;
adj(2, [3 4]) = [s s];
%This sets up xc for the left side of the bridge.
xc(1,:) = [0 1];
xc(2,:) = [0 1];
%This sets up yc for the left side of the bridge.
yc(1,:) = [0 0];
yc(2,:) = [0 1];
%Changes len(2) to 1/s as this is a diagonal.
len(2) = 1/s;
%Middle of Bridge
for i = 1: nos
    %Creates a for loop that will update adj for each section of the
    %bridge.
    %Creates some helpful variables.
    start_row = 5*i;
    start_col = 4*i+4;
    %These steps set up the adjacency matrix for the middle side of the
    %bridge for each for loop.
    adj(start_row-2, [start_col-6, start_col-4]) = [-1 1];
    adj(start_row-1, [start_col-7, start_col-6, start_col-1, start_col]) = [-s -s s s];
    adj(start_row, [start_col-5, start_col-4, start_col-3, start_col-2]) = [-s s s -s];
    adj(start_row+1, [start_col-5, start_col-1]) = [-1 1];
    adj(start_row+2, [start_col-7, start_col-3]) = [-1 1];
    %This sets up xc and yc for the middle side of the bridge for each for
    %loop.
    xc(start_row-2,:) = [i i];
    yc(start_row-2,:) = [0 1];
    xc(start_row-1,:) = [i i+1];
    yc(start_row-1,:) = [0 1];
    xc(start_row,:) = [i i+1];
    yc(start_row,:) = [1 0];
    xc(start_row+1,:) = [i i+1];
    yc(start_row+1,:) = [1 1];
    xc(start_row+2,:) = [i i+1];
    yc(start_row+2,:) = [0 0];
    %Changes the lengths of these edges ro 1/s as these are diagonals.
    len(start_row-1) = 1/s;
    len(start_row) = 1/s;
end
%End of Bridge
%These steps set up the adjacency matrix for the right side of the bridge.
adj(end-2,[end-2,end-1,end])=[-1 0 1];
adj(end-1,[end-1,end]) = [-s s];
adj(end, end-3) = -1;
%This sets up xc and yc for the right side of the bridge for each edge.
xc(end-2,:) = [nos+1 nos+1];
yc(end-2,:) = [0 1];
xc(end-1,:) = [nos+1 nos+2];
yc(end-1,:) = [1 0];
xc(end,:) = [nos+1 nos+2];
yc(end,:) = [0 0];
%Changes the length of this edge to 1/s as it is a diagonal.
len(end-1,:) = 1/s;

% 
function [dx, dy, work] = deform_basic_bridge (nos, apforce, adj, xc, yc, len, thick)
%This function is responsible for deform the bridge once the adjacency
%matrix is created. It is called by the function
%build_load_plot_basic_bridge. 
%The inputs of the function are nos, which is the number of sections,
%apforce, which is the weight of the car, adj, which is the adjacency
%matrix, xc and yc, which are the x and y coordinates, len, which is the
%length vector, and thick, which is the thickness of the edges.
%The outputs are dx, which is the deformed x coordinates, dy, which is the
%deformed y coordinates, and the work used.
%This is responsible for creating the force vector.
force = zeros(4*(nos+1),1);
for i = 1:2:(2*nos+2)
    force(2*i) = -apforce;
end
%This does the process by which the displacements can be obtained using
%force and stiffness.
stiffness = adj'*diag(thick./len')*adj; 
displacements = stiffness\force; 
work = displacements'*force; 
%Sets the x displacements into X and the y displacements into Y.
X = displacements(1:2:end); 
Y = displacements(2:2:end); 
% Initialize the return values 
dx = zeros(size(xc)); 
dy = zeros(size(yc)); 
% Deform the left side of bridge 
dx(1,:) = xc(1,:) + [0 X(1)]; 
dx(2,:) = xc(2,:) + [0 X(2)]; 
dy(1,:) = yc(1,:) + [0 Y(1)]; 
dy(2,:) = yc(2,:) + [0 Y(2)]; 
% Deform the middle of bridge
for i = 1:nos
    %Creates some helpful variables.
    start_row = 5*i;
    %Creates a for loop that will update dx and dy for each section of the
    %bridge.
    dx(start_row-2,:) = xc(start_row-2,:)+[X(2*i-1) X(2*i)];
    dy(start_row-2,:) = yc(start_row-2,:)+[Y(2*i-1) Y(2*i)];
    dx(start_row-1,:) = xc(start_row-1,:)+[X(2*i-1) X(2*i+2)];
    dy(start_row-1,:) = yc(start_row-1,:)+[Y(2*i-1) Y(2*i+2)];
    dx(start_row,:) = xc(start_row,:)+[X(2*i) X(2*i+1)];
    dy(start_row,:) = yc(start_row,:)+[Y(2*i) Y(2*i+1)];
    dx(start_row+1,:) = xc(start_row+1,:)+[X(2*i) X(2*i+2)];
    dy(start_row+1,:) = yc(start_row+1,:)+[Y(2*i) Y(2*i+2)];
    dx(start_row+2,:) = xc(start_row+2,:)+[X(2*i-1) X(2*i+1)];
    dy(start_row+2,:) = yc(start_row+2,:)+[Y(2*i-1) Y(2*i+1)];
end
% Deform the right side of bridge
%Updates the values of dx and dy for the end of the bridge.
dx(end-2,:) = xc(end-2,:) + [X(end-1) X(end)];
dy(end-2,:) = yc(end-2,:) + [Y(end-1) Y(end)]; 
dx(end-1,:) = xc(end-1,:) + [X(end) 0]; 
dy(end-1,:) = yc(end-1,:) + [Y(end) 0]; 
dx(end,:) = xc(end,:) + [X(end-1) 0]; 
dy(end,:) = yc(end,:) + [Y(end-1) 0]; 

function [lowest] = minlow(nos,car_weight,thick)
%This is the function minlow, which returns the lowest points of the
%bridge. Its inputs are the nos, car_weight, and thickness. The output is
%the lowest y coordinate of the bridge.
[adj, xc, yc, len] = buildbasicbridge(nos);
%Calls deform_basic_bridge to obtain these values which are set into these
%variables.
[~, dy, ~] = deform_basic_bridge (nos, car_weight, adj, xc, yc, len, thick);
%Calls deform_basic_bridge to obtain these values which are set into these
%variables
lowest = min(min(dy));


function build_load_plot_basic_bridge (nos, car_weight, thick,a)
%This is responsible for plotting the undeformed bridge as well as 2
%deformed of bridges based on the car_weights inputted. It calls on the
%functions buildbasicbridge, deform_basic_bridge, and plot_bridge. It is
%called in the main driver fucntion.
%The inputs of this function are nos, which is the number of sections,
%car_weight1 and car_weight2, which are the two car weights of each car,
%and thick, which is the thickness of the edge.
%Calls buildbasicbridge to obtain these values which are set into these
%variables.
[adj, xc, yc, len] = buildbasicbridge(nos);
%Calls deform_basic_bridge to obtain these values which are set into these
%variables.
[dx1, dy1, ~] = deform_basic_bridge (nos, car_weight, adj, xc, yc, len, thick);
%Calls deform_basic_bridge to obtain these values which are set into these
%variables.
%Calls plot_bridge for this, which will plot the undeformed bridge.
plot_bridge(nos,dx1, dy1, thick,a)
%Puts the plot of the deformed bridge with car_weight2 in the third
%subplot.


function plot_bridge (nos, xc, yc, thick,a)
%This is the function plot_bridge which will plot the bridge based on the
%inputs given.
%The inputs are nos, whicb is the number of sections in the bridge, xc,
%which is the x coordinates, yc, which is the y coordinates, and thick,
%which is the thickness of the edges.
%The output is just the plot of the bridge.
hold on
for i = 1:5*(nos+1)
    %Plots the lines for the bridge.
    line(xc(i,:),yc(i,:), 'LineWidth', thick/2)
end
%Draws the white polygons that signify land.
fill([-1 -1 0 0.5],[-2 0 0 -2], 'g')
fill([nos+1.5 nos+2 nos+3 nos+3],[-2 0 0 -2], 'g')
%Gives the 
if a == 1
    fill([0.2 0.5 nos+1.5 nos+1.8],[-0.75 -2 -2 -0.75], 'b')
end
%Turns off the axes.
axis off
hold off


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%This displays the values of the slider in the text below it.
slidervalue = num2str(get(handles.slider1, 'Value'));
set(handles.text3, 'String', slidervalue);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in instructionsbutton.
function instructionsbutton_Callback(hObject, eventdata, handles)
% hObject    handle to instructionsbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Pops up the message box for the instructions.
h = msgbox('Evil Doge and his villain friends are plotting to take over the MATLAB kingdom! Shoot catapults on the bridge that the villain is crossing to stop them! Unfortunately, the kingdom is bankrupt, so if you shoot too many, the bridge will sink and you will lose as you would have destroyed your own bridge. Each villain has three lives. Use the slider to aim at the villains, who are invisible and will spawn at random locations on the bridge. Choose the amount of sections you wish to have in the text box, and choose the enemy you wish to face in the drop-down menu. Click shoot to launch the projectile. If you want to see the water, click on toggle box and shoot to see how much distance you have before the bridge collapses. You will know that you have won when you see the glorious MATLAB logo plotted.');


% --- Executes on button press in instructionsbutton.
function headerbutton_Callback(hObject, eventdata, handles)
% hObject    handle to instructionsbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Displays the header in a message box.
h = msgbox({'Anirudh Kuchibhatla, CAAM 210, Fall 2017, Project 11.0' 'Filename:bridgebattles.m' 'This code generates a game that generates a plot of the old bridgebuilder project. The edit text box is used to enter how many sections are desired. While any positive integer would work, the game is best played between values 1-5. The pulldown menu allows one to choose the enemy they wish to fight, who have different weights and therefor deform the bridge differently. The toggle box is used to display water when pressed, and is triggered after each click of shoot. The slider is used to guess where the enemy might be. After clicking shoot, if the player hits the enemy, then the enemy lives displayed goes down by one. The game is over either when the enemy lives = 0 which results in the MATLAB graph being displayed, or when the bridge touches the water, which results in doge being shown.' 'Usage: To run this code, type brudgebattles into the MATLAB Command window'});


% --- Executes when uipanel1 is resized.
function uipanel1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



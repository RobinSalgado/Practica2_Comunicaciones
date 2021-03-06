%% Sistemas de Comunicaciones Digitales - Practica 2 Transmision
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Autores: 
%   Jose Andres Hernandez Hernandez ie704453
%   Robin Salgado de Anda           ie686481
%   Isaac Yael Vazquez Gonzalez     ie703092
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parte 1 - Caracterizacion del Canal del Comunicacion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Paso 1: Generacion de una senal senoidal de 5kHz de frecuencia y 1 de
%           amplitud. Reproducir el sonido de manera que se transmita al 
%           receptor de manera que se encuentren los valores de volumen y 
%           sensibilidad adecuados para el sistema

close all; clc; clear all;      % Borramos todo
fs = 96e3;                      % Frecuencia de muestre a 96kHz
mp = 16;                        % 16-bits por muestra
Amp = 1                         % Amplitud de senoidal
f = 5000;                       % Frecuencia de senoidal
T = 1;                          % Cantidad de segundos limite
t = 0:1/fs:T;                   % Vector de tiempo
y = sin(2*pi*f*t);              % Funcion de senoidal
plot(t,y)                       % Grafica de la senal senoidal
soundsc(y,fs)                   % Reproduccion de audio

%% Paso 2: Identificar el canal, es decir, obtener su respuesta en 
%           frecuencia. Vamos a emplear tres t�cnicas diferentes. 
%
%% a) Impulso conformado por un segundo de 0 1 0 

Pulse = zeros(1,2*fs+1) % Vector de ceros con duracion de 2s
Pulse(fs) = 1;          % A la mitad del vector ponemos un solo pulso
soundsc(Pulse,fs);      % Reproducimos con una frecuencia de 96kHz

%% c) Como segunda t�cnica, utilizaremos una se�al que tiene el mismo 
%       espectro que el impulso: el ruido gaussiano

Ruido = randn(1,5*fs);              % Vector de ruido gaussiano de 5s
pwelch(Ruido,[],[],[],fs,'power');  % Lo analizamos con pwelch
soundsc(Ruido,fs);                  % Lo reproducimos

%% e) Genera una senal que sea la suma de senoidales de misma amplitud y 
%       con frecuencias de 500:500:2000

time = 0:1/fs:2;                        % Vector de tiempo de 2s
sen1 = sin(2*pi*500 *time);             % Senoidal de 500Hz
sen2 = sin(2*pi*1000*time);             % Senoidal de 1kHz
sen3 = sin(2*pi*1500*time);             % Senoidal de 1.5kHz
sen4 = sin(2*pi*2000*time);             % Senoidal de 2kHz

senTotal = sen1 + sen2 + sen3 + sen4;   % Suma de senoidales
soundsc(senTotal,fs);                   % Lo reproducimos

%% f) Genere una senal �chirp� (-1 volt a 1 volt) de frecuencias 
%       500:500:20000      

t = 0:1/fs:2;                   % Vector de tiempo de 2s con pasos de 1/fs 
y = chirp(t,500,2,20e3);        % Senal chirp de 2s segundos de 500 a 20kHz
pwelch(y,[],[],[],fs,'power');  % Analisis con pwelch
soundsc(y,fs);                  % Reproducimos
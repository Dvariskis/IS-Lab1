%Classification using perceptron
clear all
clc

%Reading apple images
A1=imread('apple_04.jpg');
A2=imread('apple_05.jpg');
A3=imread('apple_06.jpg');
A4=imread('apple_07.jpg');
A5=imread('apple_11.jpg');
A6=imread('apple_12.jpg');
A7=imread('apple_13.jpg');
A8=imread('apple_17.jpg');
A9=imread('apple_19.jpg');

%Reading pears images
P1=imread('pear_01.jpg');
P2=imread('pear_02.jpg');
P3=imread('pear_03.jpg');
P4=imread('pear_09.jpg');

%Calculate for each image, colour and roundness
%For Apples
%1st apple image(A1)
hsv_value_A1=spalva_color(A1); %color
metric_A1=apvalumas_roundness(A1); %roundness
%2nd apple image(A2)
hsv_value_A2=spalva_color(A2); %color
metric_A2=apvalumas_roundness(A2); %roundness
%3rd apple image(A3)
hsv_value_A3=spalva_color(A3); %color
metric_A3=apvalumas_roundness(A3); %roundness
%4th apple image(A4)
hsv_value_A4=spalva_color(A4); %color
metric_A4=apvalumas_roundness(A4); %roundness
%5th apple image(A5)
hsv_value_A5=spalva_color(A5); %color
metric_A5=apvalumas_roundness(A5); %roundness
%6th apple image(A6)
hsv_value_A6=spalva_color(A6); %color
metric_A6=apvalumas_roundness(A6); %roundness
%7th apple image(A7)
hsv_value_A7=spalva_color(A7); %color
metric_A7=apvalumas_roundness(A7); %roundness
%8th apple image(A8)
hsv_value_A8=spalva_color(A8); %color
metric_A8=apvalumas_roundness(A8); %roundness
%9th apple image(A9)
hsv_value_A9=spalva_color(A9); %color
metric_A9=apvalumas_roundness(A9); %roundness

x1_a = [hsv_value_A1 hsv_value_A2 hsv_value_A3];
x2_a = [metric_A1 metric_A2 metric_A3];
x1_new_a = [hsv_value_A5 hsv_value_A6 hsv_value_A9];
x2_new_a = [metric_A5 metric_A6 metric_A9];

%For Pears
%1st pear image(P1)
hsv_value_P1=spalva_color(P1); %color
metric_P1=apvalumas_roundness(P1); %roundness
%2nd pear image(P2)
hsv_value_P2=spalva_color(P2); %color
metric_P2=apvalumas_roundness(P2); %roundness
%3rd pear image(P3)
hsv_value_P3=spalva_color(P3); %color
metric_P3=apvalumas_roundness(P3); %roundness
%2nd pear image(P4)
hsv_value_P4=spalva_color(P4); %color
metric_P4=apvalumas_roundness(P4); %roundness

x1_p = [hsv_value_P1 hsv_value_P2];
x2_p = [metric_P1 metric_P2];
x1_new_p = [hsv_value_P3 hsv_value_P4];
x2_new_p = [metric_P3 metric_P4];

figure, plot(x1_a,x2_a,'r*',x1_p,x2_p,'g*')
grid on

%selecting features(color, roundness, 3 apples and 2 pears)
%building matrix 2x5
x1=[x1_a, x1_p];
x2=[x2_a, x2_p];

%Desired output vector
T=[1;1;1;-1;-1;];

%% Tinklo atsako skaičiavimas

% pradinių ryšių svorių generavimas
w1 = randn(1)*0.1;
w2 = randn(1)*0.1;
b = randn(1)*0.1;

for i = 1:5
    %Pasvertosios sumos skaičiavimas
    v = x1(i)*w1 + x2(i)*w2 + b;
        % aktyvavimo funkcijos pritaikymas 
        if v > 0
            y = 1;
        else
            y = -1;
        end
    % palyginama su norimu atsaku ir skaičiavimo klaida
    e = T(i) - y;
end

n = 0.05;
E = 1;
k = 0; %iteraciju skaičius

% Mokymas
while E ~= 0 % executes while the total error is not 0
    for i = 1:5
        v = x1(i)*w1 + x2(i)*w2 + b;
            % aktyvavimo funkcijos pritaikymas 
            if v > 0
                y = 1;
            else
                y = -1;
            end
        % palyginama su norimu atsaku ir skaičiavimo klaida
        e = T(i) - y;
        % tinklo ryšių svorių atnaujinimas
        w1 = w1 + n*e*x1(i);
        w2 = w2 + n*e*x2(i);
        b = b + n*e;
    end
    
    E = [];
    for i = 1:5
        disp(['Tikrinamas pavyzdys: ',num2str(i)]);
        v = x1(i)*w1 + x2(i)*w2 + b;
            % aktyvavimo funkcijos pritaikymas  
            if v > 0
                y = 1;
            else
                y = -1;
            end
        % palyginama su norimu atsaku ir skaičiavimo klaida
        e = T(i) - y;
        E = [E abs(e)];
        if e~=0, disp('Neatspėta');
        else disp('Atspėta')
        end
    end
    E = sum(E);
    k = k + 1;
    disp(['Iteracijos Nr.: ',num2str(k)])
end

%% Testavimas su naujais duomenimis

disp('Nauji duomenys');

hold on 
plot(x1_new_a,x2_new_a,'r+',x1_new_p,x2_new_p,'g+')
legend('Obuolys','Kriaušė','Naujas Obuolys','Nauja Kriaušė');
hold off

x1_new=[x1_new_a,x1_new_p];
x2_new=[x2_new_a,x2_new_p];

T_new=[1;1;1;-1;-1];

for i = 1:5
    disp(['Tikrinamas nematytas mokymo metu pavyzdys: ',num2str(i)]);
    v = x1_new(i)*w1 + x2_new(i)*w2 + b;
        if v > 0
            y = 1;
        else
            y = -1;
        end
    e = T_new(i) - y;
    if e~=0, disp('Neatspėta');
    else disp('Atspėta')
    end
end
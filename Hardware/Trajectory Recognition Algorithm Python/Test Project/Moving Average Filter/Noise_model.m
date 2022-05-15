n = 1000;
filename = 'M7.xlsx';
m = 5*n;
t = linspace(0, 10*pi, m);
t = reshape(t, [m, 1]);
x = zeros(m, 1);
x = random('Normal', x, 0.1);
y = sin(t);
y = random('Normal', y, 0.1);
z = zeros(m, 1);
z = random('Normal', z, 0.1);
writematrix([x,y,z],filename,'Sheet',1,'Range','A1:C5000')
plot(t,y)
xlabel('t')
ylabel('sin(t)')
title('Plot of the Sine Function')

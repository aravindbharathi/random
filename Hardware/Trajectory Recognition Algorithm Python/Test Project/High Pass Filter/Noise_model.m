n = 200;
m = 5*n;
filename = 'M10.xlsx';
t = linspace(0, 10*pi, m);
t = reshape(t, [m, 1]);
x = zeros(m, 1);
x = random('Normal', x, 0.1);
y = random('Normal', 9.8, 0.3) + sin(t);
y = random('Normal', y, 0.1);
z = zeros(m, 1);
z = random('Normal', z, 0.1);
writematrix([x,y,z],filename,'Sheet',1,'Range','A1:C1000')
plot(t,y)
xlabel('t')
ylabel('sin(t)')
title('Plot of the Sine Function')
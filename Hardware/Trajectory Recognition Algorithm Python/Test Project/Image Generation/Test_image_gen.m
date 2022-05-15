n = 1000;
filename = 'M7.xlsx';
t = linspace(0, 2*pi, n);
t = reshape(t, [n, 1]);
x = zeros(n,1);
y = sin(t);
writematrix([x,y],filename,'Sheet',1,'Range','A1:B1000')
plot(t,y)
xlabel('t')
ylabel('sin(t)')
title('Plot of the Sine Function')
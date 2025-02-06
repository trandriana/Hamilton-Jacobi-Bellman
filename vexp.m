function [u labda] = vexp(g)

N = length(u);
u = g;
for i = 1:N-1
    theta = 1./(1:N-i);
    [u(i+1) I] = min((1-theta).*u(i) + theta.*u(i+1:N));
    lbda(i+1)= 1/I;
end

end
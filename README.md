# Numerical approximation of a backward parabolitc partial differential equation

In this repository, I implement a numerical scheme that compute the solution $V(t,x)$ of a backward parabolic partial differential equation of the form

$$
\partial_t V(t,x) + \tfrac12\sigma^2(t,x)D_x^2 V(t,x) = H(t,x),\quad V(T,x) = g(x).
$$

We use a probabilistic numerical scheme, also called layer method for the time-discretization. For a brief overview and an extensive analysis, see 
- [A probabilistic approach to the solution of the Neumann problem for nonlinear parabolic equation](https://doi.org/10.1093/imanum/22.4.599).

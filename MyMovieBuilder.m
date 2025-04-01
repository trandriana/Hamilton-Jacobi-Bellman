function MyMovieBuilder(file)
    clc
    format bank
    disp('Loading file....');
    load(file);
    clc
    whos
    [L M] = size(V);
    Vmax    = max(max(V(:,:))); Vmin    = min(min(V(:,:)));
    myvid   = VideoWriter('MyMovieGame.avi');
    open(myvid);
    
    for i=1:10:L
        plot(x, Vexact(L,:), '--red', 'LineWidth', 1); 
        hold on;
        plot(x,V(i,:), '--ok', 'LineWidth', 1); 
        plot(x,Vexact(i,:), '-blue', 'LineWidth', 1); 
        error = norm(Vexact(i,:) - V(i,:), 'inf');
        running_title = [
            '$\Delta t = $', num2str(t(2) - t(1), '%1.e\n'),...
            ', $\Delta x = $', num2str(x(2) - x(1), '%1.e\n'),... 
            ', $t$ = ', num2str(t(i), '%1.2f\n'),...
            ', $Error_x$ = ', num2str(error, '%1.e\n')];
        title(running_title, 'Interpreter','latex', 'FontSize', 12);
       
        xlabel('$x$', 'Interpreter','latex'); 
        ylabel('$V(t, x)$', 'Interpreter','latex');
        ylim([Vmin Vmax]);
        legend('$V_{exact}(T,x)$', '$V_{approx}(t,x)$','$V_{exact}(t,x)$', 'Interpreter','latex', 'location', 'southeast');
        set(gca,'fontsize',15, 'LineWidth', 2);
        grid on; 
        %grid minor;
        frame = getframe(gcf);
        hold off;
        writeVideo(myvid,frame);
    end
    close(myvid);
end
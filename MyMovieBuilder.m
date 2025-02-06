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
        plot(x,V(L,:), '-red', 'LineWidth', 2); hold on;
        plot(x,V(i,:), '-blue', 'LineWidth', 2); 
        title(['Value function at $t$ = ',num2str(t(i), '%1.2f\n')],...
                                    'Interpreter','latex', 'FontSize',15);
       
        xlabel('$x$', 'Interpreter','latex'); 
        ylabel('$V(t, x)$', 'Interpreter','latex');
        ylim([Vmin Vmax]);
        legend('Function at time $T$','Function at time $t$', 'Interpreter','latex');
        set(gca,'fontsize',15, 'LineWidth', 2);
        grid on; 
        %grid minor;
        frame = getframe(gcf);
        hold off;
        writeVideo(myvid,frame);
    end
    close(myvid);
end
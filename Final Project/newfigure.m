function newfigure(plotname, xname, yname)
    figure; set(gcf, "Color", "w"); set(gca, "FontSize", 16); 
    box on; grid on; hold on; legend('show'); 
    set(groot, 'defaultTextInterpreter', 'latex');
    set(groot, 'defaultLegendInterpreter', 'latex');
    title(plotname); xlabel(xname); ylabel(yname);
end

%Visualize mesh
g = @(x) squareg(x);
pdegplot(g,'EdgeLabels','on')
plot(P(1,:),P(2,:),'o')
plot([P(1, E(1,:)); P(2, E(1,:))],[P(1,E(2,:)); P(2, E(2,:)))
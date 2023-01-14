function mypdeplot(p, e, t, zdata, u)
figure
% Ersten Punkt anhängen, um ein geschlossenes Dreieck zu erhalten
tt = [t(1:3,:); t(1,:)];
P = reshape(p(:,reshape(tt', [], 1)), 2, [], 4);
E = reshape(p(:,reshape(e(1:2,:)', [], 1)), 2, [], 2);

if nargin==3
    hold('on');
    % Plotten der Dreiecke
    plot(squeeze(P(1,:,:))', squeeze(P(2,:,:))', 'b-');
    % Plotten der Randkanten
    plot(squeeze(E(1,:,:))', squeeze(E(2,:,:))', 'r-');
    hold('off');
    axis equal
    axis tight
end

if nargin==5
    trisurf(t(1:3,:)',p(1,:),p(2,:),u)
    zlabel("zdata");
    title(zdata)
   

end

saveas(gcf, zdata+".svg")

function mypdeplot(p, e, t)


hold('on');

% Ersten Punkt anhängen, um ein geschlossenes Dreieck zu erhalten
tt = [t(1:3,:); t(1,:)];

% Plotten der Dreiecke
P = reshape(p(:,reshape(tt', [], 1)), 2, [], 4);
plot(squeeze(P(1,:,:))', squeeze(P(2,:,:))', 'b-');

% Plotten der Randkanten
E = reshape(p(:,reshape(e(1:2,:)', [], 1)), 2, [], 2);
plot(squeeze(E(1,:,:))', squeeze(E(2,:,:))', 'r-');

hold('off');

axis equal
axis tight

end

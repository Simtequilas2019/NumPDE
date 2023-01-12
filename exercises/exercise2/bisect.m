function [ p1,e1,t1 ] = bisect(g,p,e,t,k)

% Kopieren der Initialstrukturen
p1=p;
e1=e;
t1=t;

% Als String übergebener Funktionsname wird in auswertbare Funktion
% konvertiert.
g = str2func(g);
if isempty(k)
    display('Keine Indexmenge zur Verfeinerung verfuegbar!')
end

anzahlpunkte = length(p(1,:));
index_p_neu = anzahlpunkte+1;

iter = 1;

while ~isempty(k);
    
    % Aktueller Index
    i = k(1);
    
    % Position der Eckpunkte
    pos1 = p1(:,t1(1,i));
    pos2 = p1(:,t1(2,i));
    pos3 = p1(:,t1(3,i));
    
    %Laengste Kante bestimmen
    [~,l] = max([ ...
        (pos1-pos2)'*(pos1-pos2), ...
        (pos2-pos3)'*(pos2-pos3), ...
        (pos3-pos1)'*(pos3-pos1)]);

    %zyklische Verteilung:
    c=circshift((1:3)',[1-l,0]);    
    node1 = c(1);
    node2 = c(2);
    node3 = c(3);
    
    %Neuer Punkt
    newp = 1/2*(p1(:,t1(node1,i))+p1(:,t1(node2,i)));
    p1=[p1 newp];
    
    % Index des potentiellen Nachbardreiecks bestimmen
    %Zuerst wird der index von t gesucht für die sowohl 
    n=  find(sum((t1(1:3,:)==t1(node1,i)) + ...
                 (t1(1:3,:)==t1(node2,i)))==2);
    n(find(n==i))=[];
    
    
    %Dreieck teilen
    t1 = [t1 [t1(node3,i);t1(node2,i);index_p_neu;1]];
    backup=t1(node2,i);
    t1(node2,i) = index_p_neu;
    
    % Kanten kontrolle
    if ~isempty(n) % d.h. es gibt ein Nachbardreieck
        % Nachbardreieck teilen
        m=find((t1(1:3,n)~=t1(node1,i))'.*(t1(1:3,n)~=backup)');
        t1 = [t1 [t1(node1,i);t1(m,n);index_p_neu;1]];
        t1(:,n) = [index_p_neu;t1(m,n);backup;1];
        k(find(k==n))=[]; % Entferne Nachbardreieck aus der Indexmenge
    else % d.h. es gibt kein Nachbardreieck
        edge=  find(sum((e1(1:2,:)==t1(node1,i)) + (e1(1:2,:)==backup))==2);
        % Kante liegt auf dem Rand => neuen Punkt auf dem Rand bestimmen
        [x,y]  =         g(e1(5,edge),(e1(3,edge)+e1(4,edge))/2);
        % Punktkoordinaten aktuallisieren
        p1(:,end) = [x;y];
        % edge Liste aktuallisieren
        e1 =[e1 [index_p_neu;e1(2,edge);(e1(3,edge)+e1(4,edge))/2;...
            e1(4,edge);e1(5:7,edge)]];
        e1(:,edge) = [e1(1,edge); ...
            index_p_neu;e1(3,edge);(e1(3,edge)+e1(4,edge))/2 ;e1(5:7,edge)];
    end

    index_p_neu = index_p_neu + 1;
    k(1) = [];
end


end




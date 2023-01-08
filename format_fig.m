function format_fig(largura, altura)
%format_fig formata figura atualmente em scope para ter uma dada altura e
%largura
    f = gcf;
    f.Position(3) =  largura;
    f.Position(4) =  altura;
end
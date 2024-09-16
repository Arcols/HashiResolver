pragma Ada_2012;
package body TypeCase is

   -- Implémentation de la fonction ValeurTypeCase
    function ValeurTypeCase (t : in Type_TypeCase) return Integer is
    begin
        return Integer(t);
    end ValeurTypeCase;

    -- Implémentation de la fonction estIle
    function estIle (t : in Type_TypeCase) return Boolean is
    begin
        return t = NOEUD;
    end estIle;

    -- Implémentation de la fonction estPont
    function estPont (t : in Type_TypeCase) return Boolean is
    begin
        return t = ARETE;
    end estPont;

    -- Implémentation de la fonction estMer
    function estMer (t : in Type_TypeCase) return Boolean is
    begin
        return t = MER;
    end estMer;
end TypeCase;

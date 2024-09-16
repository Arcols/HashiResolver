package body Ile is

   function ConstruireIle (v : in Integer) return Type_Ile is
      I : Type_Ile;
   begin
      if v < 1 or else v > 8 then
         raise VALEUR_ILE_INVALIDE;
      else
         I.v := v;
         return I;
      end if;
   end ConstruireIle;

   function ObtenirValeur (i : in Type_Ile) return Integer is
   begin
      return i.v;
   end ObtenirValeur;

   function estIleComplete (i : in Type_Ile) return Boolean is
   begin
      -- Vérifie si la valence de l'île est égale à 0
      return ObtenirValeur(i) = 0;
   end estIleComplete;

   function modifierIle (i : in Type_Ile; p : in Integer)
      return Type_Ile is
   begin
      if p <= 0 or else p > 2 then
         raise VALEUR_PONT_INVALIDE;
      elsif ObtenirValeur(i) - p < 0 then
         raise PONT_IMPOSSIBLE;
      else
         return Type_Ile'(v => i.v - p);
      end if;
   end modifierIle;

end Ile;

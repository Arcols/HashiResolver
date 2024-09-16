pragma Ada_2012;
package body Coordonnee is

   ---------------------------
   -- ConstruireCoordonnees --
   ---------------------------

   function ConstruireCoordonnees
     (Ligne, Colonne : in Integer) return Type_Coordonnee
   is
      Nouvelle_Coordonnee : Type_Coordonnee;
   begin
      Nouvelle_Coordonnee.Ligne := Ligne;
      Nouvelle_Coordonnee.Colonne := Colonne;
      return Nouvelle_Coordonnee;
   end ConstruireCoordonnees;

   ------------------
   -- ObtenirLigne --
   ------------------

   function ObtenirLigne (C : in Type_Coordonnee) return Integer is
   begin
      return C.Ligne;
   end ObtenirLigne;

   --------------------
   -- ObtenirColonne --
   --------------------

   function ObtenirColonne (C : in Type_Coordonnee) return Integer is
   begin
      return C.Colonne;
   end ObtenirColonne;

end Coordonnee;

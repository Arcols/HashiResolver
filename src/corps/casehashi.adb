with Ada.Text_IO;
package body CaseHashi is

   function ConstruireCase (C : in Type_Coordonnee) return Type_CaseHashi is
      CaseHashi : Type_CaseHashi;
   begin
      CaseHashi.C := C;
      CaseHashi.T := MER;
      return CaseHashi;
   end ConstruireCase;

   function ObtenirTypeCase (C : in Type_CaseHashi) return Type_TypeCase is
   begin
      return C.T;
   end ObtenirTypeCase;

   function ObtenirCoordonnee (C : in Type_CaseHashi) return Type_Coordonnee is
   begin
      return C.C;
   end ObtenirCoordonnee;

   function ObtenirIle (C : in Type_CaseHashi) return Type_Ile is
   begin
      if C.T /= NOEUD then
         raise TYPE_INCOMPATIBLE;
      end if;

      return C.I;
   end ObtenirIle;

   function ObtenirPont (C : in Type_CaseHashi) return Type_Pont is
   begin
      if C.T /= ARETE then
         raise TYPE_INCOMPATIBLE;
      end if;

      return C.P;
   end ObtenirPont;

   function modifierIle (C : in Type_CaseHashi; I : in Type_Ile) return Type_CaseHashi is
   begin
      if C.T /= MER then
         raise TYPE_INCOMPATIBLE;
      end if;

      return (C => C.C, T => NOEUD, I => I, P => C.P);
   end modifierIle;

   function modifierPont (C : in Type_CaseHashi; P : in Type_Pont) return Type_CaseHashi is
   begin
      if C.T /= ARETE and C.T /= MER then
         raise TYPE_INCOMPATIBLE;
      end if;

      -- Logique pour modifier la valeur du pont (un à deux, ou autre)
      return (C => C.C, T => ARETE, I => C.I, P => P);  -- Ici, la logique de modification doit être complétée
   end modifierPont;

   function "=" (C1 : in Type_CaseHashi; C2 : in Type_CaseHashi) return Boolean is
   begin
      return C1.C = C2.C and C1.T = C2.T and (C1.I = C2.I and C1.P = C2.P);  -- Égalité basée sur la coordonnée, le type, et l'île/le pont
   end "=";

end CaseHashi;

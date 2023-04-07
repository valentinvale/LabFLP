module Sugar where

import Exp

desugarVar :: Var -> IndexedVar
desugarVar (Var s) = makeIndexedVar s

sugarVar :: IndexedVar -> Var
sugarVar (IndexedVar s 0) = Var s
sugarVar v = if ivCount v == 0
  then Var (ivName v)
  else Var (ivName v ++ "_" ++show (ivCount v))

desugarExp :: ComplexExp -> Exp
desugarExp x = case x of
  CX v -> X (desugarVar v)
  CLam v e -> Lam (desugarVar v) (desugarExp e)
  CApp e1 e2 -> App (desugarExp e1) (desugarExp e2)

sugarExp :: Exp -> ComplexExp
sugarExp x = case x of
  X v -> CX (sugarVar v)
  Lam v e -> CLam (sugarVar v) (sugarExp e)
  App e1 e2 -> CApp (sugarExp e1) (sugarExp e2)



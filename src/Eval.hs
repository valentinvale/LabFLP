module Eval where
import Exp
import Data.List (union, delete, nub)

vars :: Exp -> [IndexedVar]
vars x = case x of
  X v -> [v]
  Lam v e -> v : vars e
  App e1 e2 -> vars e1 `union` vars e2

freeVars :: Exp -> [IndexedVar]
freeVars x = case x of
  X v -> [v]
  Lam v e -> delete v (freeVars e)
  App e1 e2 -> freeVars e1 `union` freeVars e2

occursFree :: IndexedVar -> Exp -> Bool
occursFree v e = v `elem` freeVars e

--Scrieți o funcție care dată fiind o variabilă și o listă de variabile produce o variabilă nouă care are același nume cu variabila dată dar e diferită de ea și de orice altă variabilă din lista dată

freshVar :: IndexedVar -> [IndexedVar] -> IndexedVar
freshVar v vs =
  let
    name = ivName v
    matchingVars = filter (\w -> ivName w == name) vs
    count = length matchingVars
  in IndexedVar name (count)


-- >>> freshVar (makeIndexedVar "x") [makeIndexedVar "x"]
-- IndexedVar {ivName = "x", ivCount = 1}

renameVar :: IndexedVar -> IndexedVar -> Exp -> Exp
renameVar toReplace replacement x = case x of
  X v -> if v == toReplace then X replacement else X v
  Lam v e -> if v == toReplace then Lam v e else Lam v (renameVar toReplace replacement e)
  App e1 e2 -> App (renameVar toReplace replacement e1) (renameVar toReplace replacement e2)

substitute :: IndexedVar -> Exp -> Exp -> Exp
substitute toReplace replacement x = case x of
  X v -> if v == toReplace then replacement else X v
  Lam v e -> if v == toReplace then Lam v e else Lam v (substitute toReplace replacement e)
  App e1 e2 -> App (substitute toReplace replacement e1) (substitute toReplace replacement e2)

normalize :: Exp -> Exp
normalize x = case x of
  X v -> X v
  Lam v e -> Lam v (normalize e)
  App e1 e2 -> case normalize e1 of
    Lam v e -> normalize (substitute v (normalize e2) e)
    e1' -> App e1' (normalize e2)

-- >>> normalize (X (makeIndexedVar "x"))
-- X (IndexedVar {ivName = "x", ivCount = 0})
